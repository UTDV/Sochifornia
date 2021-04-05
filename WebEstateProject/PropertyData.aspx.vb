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
                                                Street = @Street,
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
                                                AdStatus = iif(@ActualUntil < convert(date, getdate()), 76, @AdStatus)
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

                                            select 1
                                        end
                                    ", c)
            cmd.Parameters.AddWithValue("UserStatus", Session("Status").ToString)
            cmd.Parameters.AddWithValue("UserRole", Session("Role").ToString)
            cmd.Parameters.AddWithValue("Creator", Session("GUID").ToString)
            cmd.Parameters.AddWithValue("ID", Request.QueryString("id"))
            cmd.Parameters.AddWithValue("Name", NameMemo.Text)
            cmd.Parameters.AddWithValue("Type", TypeCB.Value)
            cmd.Parameters.AddWithValue("Complex", IIf(ComplexTB.Value = Nothing, DBNull.Value, ComplexTB.Text))
            cmd.Parameters.AddWithValue("District", DistrictCB.Value)
            cmd.Parameters.AddWithValue("Street", IIf(StreetTB.Value = Nothing, DBNull.Value, StreetTB.Text))
            cmd.Parameters.AddWithValue("Rooms", IIf(RoomsSpin.Value = Nothing, DBNull.Value, RoomsSpin.Value))
            cmd.Parameters.AddWithValue("ApartmentArea", ApartmentAreaSpin.Value)
            cmd.Parameters.AddWithValue("LandArea", IIf(LandAreaSpin.Value = Nothing, DBNull.Value, LandAreaSpin.Value))
            cmd.Parameters.AddWithValue("Floor", IIf(FloorSpin.Value = Nothing, DBNull.Value, FloorSpin.Value))
            cmd.Parameters.AddWithValue("TotalFloor", IIf(TotalFloorSpin.Value = Nothing, DBNull.Value, TotalFloorSpin.Value))
            cmd.Parameters.AddWithValue("Status", StatusCB.Value)
            cmd.Parameters.AddWithValue("Condition", ConditionCB.Value)
            cmd.Parameters.AddWithValue("Registration", RegistrationCB.Value)
            cmd.Parameters.AddWithValue("WindowView", IIf(WindowViewCB.Value = Nothing, DBNull.Value, WindowViewCB.Value))
            cmd.Parameters.AddWithValue("Stove", IIf(StoveCB.Value = Nothing, DBNull.Value, StoveCB.Value))
            cmd.Parameters.AddWithValue("Ipoteka", IIf(IpotekaCheckBox.Value = Nothing, DBNull.Value, IpotekaCheckBox.Value))
            cmd.Parameters.AddWithValue("ToSea", IIf(ToSeaSpin.Value = Nothing, DBNull.Value, ToSeaSpin.Value))
            'cmd.Parameters.AddWithValue("Sale", IIf(SaleCheckBox.Value = Nothing, DBNull.Value, SaleCheckBox.Value))
            cmd.Parameters.AddWithValue("Description", DescriptionMemo.Text)
            cmd.Parameters.AddWithValue("VIP", IIf(VIPCheckBox.Value = Nothing, DBNull.Value, VIPCheckBox.Value))
            cmd.Parameters.AddWithValue("ElitProperty", IIf(ElitPropertyCheckBox.Value = Nothing, DBNull.Value, ElitPropertyCheckBox.Value))
            cmd.Parameters.AddWithValue("ActualUntil", ActualUntilDE.Value)
            'cmd.Parameters.AddWithValue("Hide", IIf(HideCheckBox.Value = Nothing, DBNull.Value, HideCheckBox.Value))
            cmd.Parameters.AddWithValue("Price", PriceSpin.Value)
            cmd.Parameters.AddWithValue("Slug", slugTxt)
            cmd.Parameters.AddWithValue("Posrednik", IIf(PosrednikCB.Value = Nothing, DBNull.Value, PosrednikCB.Value))
            cmd.Parameters.AddWithValue("Comission", IIf(ComissionTB.Value = Nothing, DBNull.Value, ComissionTB.Text))
            cmd.Parameters.AddWithValue("AdStatus", AdStatusCB.Value)

            c.Open()
            Dim res As Integer = cmd.ExecuteScalar
            c.Close()
            cmd.Dispose()
            c.Dispose()

            e.Result = res

        Catch ex As Exception
            e.Result = 0
        End Try


    End Sub

End Class