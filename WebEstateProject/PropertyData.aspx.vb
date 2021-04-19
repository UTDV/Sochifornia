Imports System.Data.SqlClient
Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.IO


Public Class PropertyData
    Inherits System.Web.UI.Page

    Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If Request.QueryString("id") Is Nothing Then
            Response.Redirect("~/PropertyRegister.aspx")
        End If

        Directory.CreateDirectory(MapPath("~\Content\Foto\" & Request.QueryString("id")))

        FileManager.Settings.RootFolder = MapPath("~/Content/Foto/" & Request.QueryString("id"))


        If Not IsPostBack Then

            If Request.IsAuthenticated = False Then

                Response.Redirect("~/Users/LoginUser.aspx")

            Else

                Dim id As FormsIdentity = CType(User.Identity, FormsIdentity)
                Dim ticket As FormsAuthenticationTicket = id.Ticket
                Dim userData As String() = ticket.UserData.Split("|")

                Session("GUID") = ticket.Name
                Session("Status") = userData(0)
                Session("Role") = userData(1)


                If Session("Status") <> "64" Then

                    ' Если статус не Активный
                    Session("GUID") = Nothing
                    FormsAuthentication.SignOut()
                    Response.Redirect("~/Users/LoginUser.aspx")

                ElseIf Session("Role") <> "60" Then

                    'Если роль не Админ, ищем автора

                    Dim cmd As New SqlCommand("select Creator from [dbo].[PropertyObjects] where ID = @ID", c)
                    cmd.Parameters.AddWithValue("ID", Request.QueryString("id"))
                    c.Open()
                    Dim Creator As String = cmd.ExecuteScalar.ToString
                    c.Close()
                    cmd.Dispose()

                    If Session("GUID").ToString.ToUpper <> Creator.ToUpper Then
                        Response.Redirect("~/Default.aspx")
                    End If

                End If

            End If

        End If


    End Sub


    'Обновляем инфу о количестве фото
    Protected Sub UpdateFotoCount()

        Dim cmd As New SqlCommand("update [dbo].[PropertyObjects]
                                   set Foto = @Foto, LastUpdate = getdate() 
                                   where ID = @ID", c)
        cmd.Parameters.AddWithValue("Foto", Directory.GetFiles(MapPath("~\Content\Foto\" & Request.QueryString("id"))).Count)
        cmd.Parameters.AddWithValue("ID", Request.QueryString("id"))
        c.Open()
        cmd.ExecuteNonQuery()
        c.Close()
        cmd.Dispose()
        c.Dispose()

    End Sub


    'Удаление thumb
    Protected Sub ClearImageGalleryThumb()

        If Directory.Exists(MapPath("~\Content\Thumb\ImageGalleryThumb\" & Request.QueryString("id"))) Then

            Directory.Delete(MapPath("~\Content\Thumb\ImageGalleryThumb\" & Request.QueryString("id")), True)

        End If

    End Sub


    'Назначение главной фотки
    Protected Sub FileManager_CustomCallback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)

        Dim param As String() = e.Parameter.Split("/")

        Dim ThumbFolder As String = MapPath("~/Content/Thumb/PropertyRegisterThumb/" & param(4))

        Directory.Delete(ThumbFolder, True)

        ClearImageGalleryThumb()

        If Directory.GetFiles(FileManager.SelectedFile.Folder.FullName, "!Main.*").Count = 0 Then

            My.Computer.FileSystem.RenameFile(FileManager.SelectedFile.FullName, "!Main" & FileManager.SelectedFile.Extension)

        Else

            Dim fileEntries As String() = Directory.GetFiles(FileManager.SelectedFile.Folder.FullName, "!Main.*")
            Dim fileName As String

            For Each fileName In fileEntries

                Dim g As Guid
                g = Guid.NewGuid()
                My.Computer.FileSystem.RenameFile(fileName, g.ToString & ".jpg")

            Next

            My.Computer.FileSystem.RenameFile(FileManager.SelectedFile.FullName, "!Main" & FileManager.SelectedFile.Extension)

        End If

    End Sub


    'Обновляем данные после загрузки и удаления файлов
    Protected Sub FileManager_FilesUploaded(source As Object, e As DevExpress.Web.FileManagerFilesUploadedEventArgs)
        UpdateFotoCount()
        ClearImageGalleryThumb()
    End Sub

    Protected Sub FileManager_ItemsDeleted(source As Object, e As DevExpress.Web.FileManagerItemsDeletedEventArgs)
        UpdateFotoCount()
        ClearImageGalleryThumb()
    End Sub


    'Корректируем фото при загрузке
    Protected Sub FileManager_FileUploading(source As Object, e As DevExpress.Web.FileManagerFileUploadEventArgs)

        If Directory.GetFiles(e.File.Folder.FullName).Count = 0 Then
            e.FileName = "!Main" & e.File.Extension
        End If

        Dim img = GetReducedImage(Image.FromStream(e.InputStream), 1024, 768)

        Dim gr As Graphics = Graphics.FromImage(img)
        'Dim fnt As Font = New Font(FontFamily.GenericMonospace.Name, 25, FontStyle.Italic)
        Dim fnt As Font = New Font("Papyrus", 10)

        Dim str As String = "SOCHIFORNIA"
        Dim wstr As Single = Fix(img.Width / gr.MeasureString(str, fnt).Width / 2)

        Dim x As Single = gr.MeasureString(str, fnt).Width

        For i = 0 To wstr - 1
            gr.DrawString(str, fnt, New SolidBrush(Color.FromArgb(100, Color.White)), x, img.Height / 4)
            gr.DrawString(str, fnt, New SolidBrush(Color.FromArgb(100, Color.White)), x, img.Height / 2)
            gr.DrawString(str, fnt, New SolidBrush(Color.FromArgb(100, Color.White)), x, img.Height * 3 / 4)
            x += gr.MeasureString(str, fnt).Width * 2
        Next

        Dim ms As New MemoryStream()
        img.Save(ms, ImageFormat.Jpeg)
        ms.Seek(0, SeekOrigin.Begin)

        e.OutputStream = ms

    End Sub


    Private Function GetReducedImage(ByVal image As Image, ByVal extremeWidth As Integer, ByVal extremeHeight As Integer) As Image

        Dim size As New Size(image.Width, image.Height)

        If image.Width > extremeWidth Or image.Height > extremeHeight Then

            Dim ratio As Double = System.Convert.ToDouble(image.Width) / System.Convert.ToDouble(image.Height)
            size = New Size(extremeWidth, System.Convert.ToInt32(Microsoft.VisualBasic.Conversion.Fix(extremeWidth / ratio)))
            If size.Height > extremeHeight Then
                size = New Size(System.Convert.ToInt32(Microsoft.VisualBasic.Conversion.Fix(extremeHeight * ratio)), extremeHeight)
            End If

        End If

        Return New Bitmap(image, size)

    End Function


    'Сохранение данных
    Protected Sub CBackSave_Callback(source As Object, e As DevExpress.Web.CallbackEventArgs)


        Try

            'здесь добавление slug
            Dim slugTxt As String = SlugUniq.GetSlug(NameMemo.Text, SlugUniq.SlugType.PropertyObject, Request.QueryString("id"))

            Dim cmd As New SqlCommand(" if @UserStatus != '64'
                                        begin
                                            select 0
                                        end

                                        else if @UserRole != '60' and @Creator != (select Creator from [dbo].[PropertyObjects] where ID = @ID)
                                        begin
                                            select 0
                                        end

                                        else
                                        begin

                                            update [dbo].[PropertyObjects]
                                            set Name = @Name,
                                                Type = @Type,
                                                Complex = @Complex,
                                                District = @District,
                                                --Street = @Street,
                                                Rooms = @Rooms,
                                                ApartmentArea = @ApartmentArea,
                                                LandArea = @LandArea,
                                                Floor = @Floor,
                                                TotalFloor = @TotalFloor,
                                                Status = @Status,
                                                Condition = @Condition,
                                                Registration = @Registration,
                                                WindowView = @WindowView,
                                                Stove = @Stove,
                                                Ipoteka = isnull(@Ipoteka,0),
                                                ToSea = @ToSea,
                                                --Sale = isnull(@Sale,0),
                                                Description = @Description,
                                                VIP = isnull(@VIP,0),
                                                ElitProperty = isnull(@ElitProperty,0),
                                                ActualUntil = @ActualUntil,
                                                --Hide = isnull(@Hide,0),
                                                LastUpdate = getdate(),
                                                Slug = @Slug,
                                                Posrednik = @Posrednik,
                                                Comission = @Comission,
                                                AdStatus = @AdStatus,
                                                YandexFeed = @YandexFeed, 
                                                CianFeed = @CianFeed
                                            where ID = @ID


                                            declare @OldPrice float

                                              select @OldPrice = TRY_CONVERT(FLOAT, price.MetaData)
                                              from dbo.PropertyObjectsMetaData price
                                              where price.ObjectID = @ID
                                                and price.MetaNameID = 54
                                             and price.Created = (select max(maxprice.Created)
                                                      from dbo.PropertyObjectsMetaData maxprice
                                                   where maxprice.ObjectID = price.ObjectID
                                                     and maxprice.MetaNameID = price.MetaNameID
                                                     )


                                            if TRY_CONVERT(float, @Price) != @OldPrice or @OldPrice is null
                                            begin
                                                insert into [dbo].[PropertyObjectsMetaData] (Creator, ObjectID, MetaNameID, MetaData)
                                                values (@Creator, @ID, 54, @Price)
                                            end

                                            delete from [dbo].[PropertyObjectsMetaData] where ObjectID = @ID and MetaNameID in (77,78,79,80,81,82,83)
                                            insert into [dbo].[PropertyObjectsMetaData] (Creator, ObjectID, MetaNameID, MetaData)
                                            values (@Creator, @ID, 77, @Country), 
                                                   (@Creator, @ID, 78, @Region),
                                                   (@Creator, @ID, 79, @RegionDistrict),
                                                   (@Creator, @ID, 80, @LocalityName),
                                                   (@Creator, @ID, 81, @StreetName),
                                                   (@Creator, @ID, 82, @Apartment),
                                                   (@Creator, @ID, 83, @House)

                                            select 1
                                        end
                                    ", c)
            cmd.Parameters.AddWithValue("UserStatus", Session("Status").ToString)
            cmd.Parameters.AddWithValue("UserRole", Session("Role").ToString)
            cmd.Parameters.AddWithValue("Creator", Session("GUID").ToString)
            cmd.Parameters.AddWithValue("ID", Request.QueryString("id"))
            cmd.Parameters.AddWithValue("Name", NameMemo.Text)
            cmd.Parameters.AddWithValue("Type", TypeCB.Value)
            cmd.Parameters.AddWithValue("Complex", IIf(ComplexTB.Value Is Nothing, DBNull.Value, ComplexTB.Text))
            cmd.Parameters.AddWithValue("District", DistrictCB.Value)
            'cmd.Parameters.AddWithValue("Street", IIf(StreetTB.Value = Nothing, DBNull.Value, StreetTB.Text))
            cmd.Parameters.AddWithValue("Rooms", IIf(RoomsSpin.Value Is Nothing, DBNull.Value, RoomsSpin.Value))
            cmd.Parameters.AddWithValue("ApartmentArea", ApartmentAreaSpin.Value)
            cmd.Parameters.AddWithValue("LandArea", IIf(LandAreaSpin.Value Is Nothing, DBNull.Value, LandAreaSpin.Value))
            cmd.Parameters.AddWithValue("Floor", IIf(FloorSpin.Value Is Nothing, DBNull.Value, FloorSpin.Value))
            cmd.Parameters.AddWithValue("TotalFloor", IIf(TotalFloorSpin.Value Is Nothing, DBNull.Value, TotalFloorSpin.Value))
            cmd.Parameters.AddWithValue("Status", StatusCB.Value)
            cmd.Parameters.AddWithValue("Condition", ConditionCB.Value)
            cmd.Parameters.AddWithValue("Registration", RegistrationCB.Value)
            cmd.Parameters.AddWithValue("WindowView", IIf(WindowViewCB.Value Is Nothing, DBNull.Value, WindowViewCB.Value))
            cmd.Parameters.AddWithValue("Stove", IIf(StoveCB.Value Is Nothing, DBNull.Value, StoveCB.Value))
            cmd.Parameters.AddWithValue("Ipoteka", IIf(IpotekaCheckBox.Value Is Nothing, DBNull.Value, IpotekaCheckBox.Value))
            cmd.Parameters.AddWithValue("ToSea", IIf(ToSeaSpin.Value Is Nothing, DBNull.Value, ToSeaSpin.Value))
            'cmd.Parameters.AddWithValue("Sale", IIf(SaleCheckBox.Value = Nothing, DBNull.Value, SaleCheckBox.Value))
            cmd.Parameters.AddWithValue("Description", DescriptionMemo.Text)
            cmd.Parameters.AddWithValue("VIP", IIf(VIPCheckBox.Value Is Nothing, DBNull.Value, VIPCheckBox.Value))
            cmd.Parameters.AddWithValue("ElitProperty", IIf(ElitPropertyCheckBox.Value Is Nothing, DBNull.Value, ElitPropertyCheckBox.Value))
            cmd.Parameters.AddWithValue("ActualUntil", ActualUntilDE.Value)
            'cmd.Parameters.AddWithValue("Hide", IIf(HideCheckBox.Value = Nothing, DBNull.Value, HideCheckBox.Value))
            cmd.Parameters.AddWithValue("Price", PriceSpin.Value)
            cmd.Parameters.AddWithValue("Slug", slugTxt)
            cmd.Parameters.AddWithValue("Posrednik", IIf(PosrednikCB.Value Is Nothing, DBNull.Value, PosrednikCB.Value))
            cmd.Parameters.AddWithValue("Comission", IIf(ComissionTB.Value Is Nothing, DBNull.Value, ComissionTB.Text))
            cmd.Parameters.AddWithValue("AdStatus", AdStatusCB.Value)
            cmd.Parameters.AddWithValue("Country", IIf(CountryTB.Value Is Nothing, DBNull.Value, CountryTB.Text))
            cmd.Parameters.AddWithValue("Region", IIf(RegionTB.Value Is Nothing, DBNull.Value, RegionTB.Text))
            cmd.Parameters.AddWithValue("RegionDistrict", IIf(RegionDistrictTB.Value Is Nothing, DBNull.Value, RegionDistrictTB.Text))
            cmd.Parameters.AddWithValue("LocalityName", IIf(LocalityNameTB.Value Is Nothing, DBNull.Value, LocalityNameTB.Text))
            cmd.Parameters.AddWithValue("StreetName", IIf(StreetNameTB.Value Is Nothing, DBNull.Value, StreetNameTB.Text))
            cmd.Parameters.AddWithValue("House", IIf(HouseTB.Value Is Nothing, DBNull.Value, HouseTB.Text))
            cmd.Parameters.AddWithValue("Apartment", IIf(ApartmentTB.Value Is Nothing, DBNull.Value, ApartmentTB.Text))
            cmd.Parameters.AddWithValue("YandexFeed", IIf(YandexFeedCheckBox.Value Is Nothing, 0, YandexFeedCheckBox.Value))
            cmd.Parameters.AddWithValue("CianFeed", IIf(CianFeedCheckBox.Value Is Nothing, 0, CianFeedCheckBox.Value))

            c.Open()
            Dim res As Integer = cmd.ExecuteScalar
            c.Close()
            cmd.Dispose()
            c.Dispose()



            If res = 1 Then

                'Только для вторичной недвижимости
                If TypeCB.Value = 1 Then

                    YandexFeedUpdate(YandexFeedCheckBox.Value, AdStatusCB.Value)
                    CianFeedUpdate(CianFeedCheckBox.Value, AdStatusCB.Value)

                End If

            End If



            e.Result = res

        Catch ex As Exception
            e.Result = 0
        End Try


    End Sub



    Public Sub CianFeedUpdate(ByVal isCianPublic As Boolean, ByVal AdStatus As Integer)


        Dim CianRooms As Integer
        If RoomsSpin.Value = 0 Then
            CianRooms = 9
        ElseIf RoomsSpin.Value >= 1 And RoomsSpin.Value <= 5 Then
            CianRooms = RoomsSpin.Value
        ElseIf RoomsSpin.Value > 5 Then
            CianRooms = 6
        End If


        Dim spath As String = MapPath("~/Content/XMLFeed/CianFeed.xml")

        Dim doc As XDocument = XDocument.Load(spath)

        Dim i As Integer = 0

        'Ищем есть ли объект в файле
        Dim objs As IEnumerable(Of XElement) = From el In doc.Root.Elements() Where el.<ExternalId>.Value = Request.QueryString("id") Select el

        For Each el As XElement In objs
            i += 1
        Next


        If isCianPublic = True And AdStatus = 73 Then


            If IsNothing(RegionTB.Value) = False And
                IsNothing(RegionDistrictTB.Value) = False And
                IsNothing(LocalityNameTB.Value) = False And
                IsNothing(StreetNameTB.Value) = False And
                IsNothing(HouseTB.Value) = False And
                IsNothing(AgentNameTB.Value) = False And
                IsNothing(AgentPhoneTB.Value) = False And
                IsNothing(AgentEmailTB.Value) = False And
                IsNothing(PriceSpin.Value) = False And
                IsNothing(ApartmentAreaSpin.Value) = False And
                IsNothing(RoomsSpin.Value) = False And
                IsNothing(FloorSpin.Value) = False And
                IsNothing(TotalFloorSpin.Value) = False And
                IsNothing(DescriptionMemo.Value) = False And
                RegistrationCB.Value = 47 And
                Directory.GetFiles(MapPath("~\Content\Foto\" & Request.QueryString("id"))).Count > 0 Then

                If i > 0 Then
                    objs.Remove()
                End If

                Dim obj As XElement = New XElement("object")

                obj.Add(New XElement("ExternalId", Request.QueryString("id")))
                obj.Add(New XElement("Category", "flatSale"))
                obj.Add(New XElement("Description", DescriptionMemo.Text))
                obj.Add(New XElement("Address", RegionTB.Text & ", " & LocalityNameTB.Text & ", " & StreetNameTB.Text & ", " & HouseTB.Text))

                Dim Phones As XElement = New XElement("Phones")
                Dim PhoneSchema As XElement = New XElement("PhoneSchema")
                PhoneSchema.Add(New XElement("CountryCode", "+7"))
                PhoneSchema.Add(New XElement("Number", AgentPhoneTB.Text.Substring(2)))
                Phones.Add(PhoneSchema)
                obj.Add(Phones)

                Dim SubAgent As XElement = New XElement("SubAgent")
                SubAgent.Add(New XElement("Email", AgentEmailTB.Text))
                SubAgent.Add(New XElement("Phone", AgentPhoneTB.Text))
                SubAgent.Add(New XElement("FirstName", AgentNameTB.Text))
                obj.Add(SubAgent)

                obj.Add(New XElement("FlatRoomsCount", CianRooms))
                obj.Add(New XElement("TotalArea", ApartmentAreaSpin.Value))
                obj.Add(New XElement("FloorNumber", FloorSpin.Value))

                Dim Building As XElement = New XElement("Building")
                Building.Add(New XElement("FloorsCount", TotalFloorSpin.Value))
                obj.Add(Building)

                Dim BargainTerms As XElement = New XElement("BargainTerms")
                BargainTerms.Add(New XElement("Price", PriceSpin.Value))
                BargainTerms.Add(New XElement("Currency", "rur"))
                BargainTerms.Add(New XElement("MortgageAllowed", IpotekaCheckBox.Value))
                BargainTerms.Add(New XElement("SaleType", "free"))
                obj.Add(BargainTerms)


                Dim Photos As XElement = New XElement("Photos")
                For Each foundFile In Directory.GetFiles(MapPath("~\Content\Foto\" & Request.QueryString("id")))
                    Dim PhotoSchema As XElement = New XElement("PhotoSchema")
                    PhotoSchema.Add(New XElement("FullUrl", "sochifornia.realty\Content\Foto\" & Request.QueryString("id") & "\" & Path.GetFileName(foundFile)))
                    PhotoSchema.Add(New XElement("IsDefault", IIf(Path.GetFileNameWithoutExtension(foundFile) = "!Main", "true", "false")))
                    Photos.Add(PhotoSchema)
                Next
                obj.Add(Photos)


                doc.Root.Add(obj)

                doc.Save(spath)

            End If


        ElseIf (isCianPublic = False Or AdStatus <> 73) And i > 0 Then 'Если объект есть в файле и его нужно убрать - удаляем

                objs.Remove()
            doc.Save(spath)

        End If

    End Sub

    Public Sub YandexFeedUpdate(ByVal isYandexPublic As Boolean, ByVal AdStatus As Integer)


        Dim spath As String = MapPath("~/Content/XMLFeed/YandexFeed.xml")

        Dim doc As XDocument = XDocument.Load(spath)
        Dim ns As XNamespace = XNamespace.Get("http://webmaster.yandex.ru/schemas/feed/realty/2010-06")
        Dim i As Integer = 0

        'Ищем есть ли объект в файле
        Dim offers As IEnumerable(Of XElement) = From el In doc.Root.Elements() Where el.Name.Namespace = ns And el.@<internal-id> = Request.QueryString("id") Select el

        For Each el As XElement In offers
            i += 1
        Next

        If isYandexPublic = True And AdStatus = 73 Then 'Добавление/обновление объекта (только для объявлений в статусе ОПУБЛИКОВАНО)

            If IsNothing(CountryTB.Value) = False And
                IsNothing(RegionTB.Value) = False And
                IsNothing(RegionDistrictTB.Value) = False And
                IsNothing(LocalityNameTB.Value) = False And
                IsNothing(StreetNameTB.Value) = False And
                IsNothing(HouseTB.Value) = False And
                IsNothing(ApartmentTB.Value) = False And
                IsNothing(AgentNameTB.Value) = False And
                IsNothing(AgentPhoneTB.Value) = False And
                IsNothing(PriceSpin.Value) = False And
                IsNothing(ApartmentAreaSpin.Value) = False And
                IsNothing(RoomsSpin.Value) = False And
                IsNothing(FloorSpin.Value) = False And
                RegistrationCB.Value = 47 And
                Directory.GetFiles(MapPath("~\Content\Foto\" & Request.QueryString("id"))).Count >= 4 Then


                If i > 0 Then
                    offers.Remove()
                End If


                Dim offer As XElement = New XElement(ns + "offer")

                offer.SetAttributeValue("internal-id", Request.QueryString("id"))

                offer.Add(New XElement(ns + "type", "продажа"))
                offer.Add(New XElement(ns + "property-type", "жилая"))
                offer.Add(New XElement(ns + "category", "квартира"))
                offer.Add(New XElement(ns + "creation-date", New DateTimeOffset(CDate(CreatedDE.Value), New TimeSpan(3, 0, 0)).ToString("yyyy-MM-ddTHH:mm:ssK")))

                Dim location As XElement = New XElement(ns + "location")
                location.Add(New XElement(ns + "country", CountryTB.Text))
                location.Add(New XElement(ns + "region", RegionTB.Text))
                location.Add(New XElement(ns + "district", RegionDistrictTB.Text))
                location.Add(New XElement(ns + "locality-name", LocalityNameTB.Text))
                location.Add(New XElement(ns + "address", StreetNameTB.Text & ", " & HouseTB.Text))
                location.Add(New XElement(ns + "apartment", ApartmentTB.Text))
                offer.Add(location)

                Dim sAgent As XElement = New XElement(ns + "sales-agent")
                sAgent.Add(New XElement(ns + "name", AgentNameTB.Text))
                sAgent.Add(New XElement(ns + "phone", AgentPhoneTB.Text))
                sAgent.Add(New XElement(ns + "category", "агентство"))
                offer.Add(sAgent)

                Dim price As XElement = New XElement(ns + "price")
                price.Add(New XElement(ns + "value", Math.Round(PriceSpin.Value, 0)))
                price.Add(New XElement(ns + "currency", "RUB"))
                offer.Add(price)

                Dim dealStatus As String = ""
                If RegistrationCB.Value = 47 Then
                    dealStatus = "прямая продажа"
                ElseIf RegistrationCB.Value = 48 Then
                    dealStatus = "переуступка"
                End If
                offer.Add(New XElement(ns + "deal-status", dealStatus))

                Dim area As XElement = New XElement(ns + "area")
                area.Add(New XElement(ns + "value", Math.Round(ApartmentAreaSpin.Value, 0)))
                area.Add(New XElement(ns + "unit", "кв. м"))
                offer.Add(area)


                For Each foundFile In Directory.GetFiles(MapPath("~\Content\Foto\" & Request.QueryString("id")))
                    offer.Add(New XElement(ns + "image", "sochifornia.realty\Content\Foto\" & Request.QueryString("id") & "\" & Path.GetFileName(foundFile)))
                    'offer.Add(New XElement(ns + "image", foundFile))
                Next


                If RoomsSpin.Value = 0 Then
                    offer.Add(New XElement(ns + "studio", "да"))
                ElseIf RoomsSpin.Value > 0 Then
                    offer.Add(New XElement(ns + "rooms", RoomsSpin.Value))
                End If

                offer.Add(New XElement(ns + "floor", FloorSpin.Value))

                doc.Root.Add(offer)

                doc.Root.Element(ns + "generation-date").SetValue(New DateTimeOffset(Now, New TimeSpan(3, 0, 0)).ToString("yyyy-MM-ddTHH:mm:ssK"))

                doc.Save(spath)



            End If

        ElseIf (isYandexPublic = False Or AdStatus <> 73) And i > 0 Then 'Если объект есть в файле и его нужно убрать - удаляем

            offers.Remove()
            doc.Root.Element(ns + "generation-date").SetValue(New DateTimeOffset(Now, New TimeSpan(3, 0, 0)).ToString("yyyy-MM-ddTHH:mm:ssK"))
            doc.Save(spath)

        End If




    End Sub

End Class