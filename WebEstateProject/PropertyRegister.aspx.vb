Imports System.Data.SqlClient
Imports System.IO
Imports DevExpress
Imports System.Drawing
Imports System.Drawing.Imaging
Imports DevExpress.Web
Imports System.Drawing.Text
Imports System.Drawing.Drawing2D

Public Class PropertyRegister
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            HiddenField("OpenFotoID") = ""
        End If

    End Sub

    Protected Sub PropertyRegisterGrid_RowInserting(sender As Object, e As DevExpress.Web.Data.ASPxDataInsertingEventArgs)

        If e.NewValues.Item("ActualUntil") Is Nothing Then
            e.NewValues("ActualUntil") = DateAdd(DateInterval.Month, 1, Now())
        End If

        Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)

        Dim cmd As New SqlCommand("insert into [dbo].[PropertyObjects] (Creator, Name, Type, Complex, District, Street, Rooms, ApartmentArea, LandArea, Floor, TotalFloor, Status,
												Condition, Registration, WindowView, Stove, Ipoteka, ToSea, Sale, Description, VIP, ElitProperty, ActualUntil, Hide, LastUpdate)
                                   values ('system', @Name, @Type, @Complex, @District, @Street, @RoomsNumber, @ApartmentArea, @LandArea, @Floor, @TotalFloor, @Status, @Condition, @Registration, 
                                           @WindowView, @Stove, isnull(@Ipoteka,0), @ToSea, isnull(@Sale,0), @Description, isnull(@VIP,0), isnull(@ElitProperty,0), @ActualUntil, isnull(@Hide,0), getdate())
        
                                   declare @ID int = IDENT_CURRENT('[dbo].[PropertyObjects]')

                                   insert into [dbo].[PropertyObjectsMetaData] (Creator, ObjectID, MetaNameID, MetaData)
                                   values ('system', @ID, 54, @Price) 

                                   select @ID", c)
        cmd.Parameters.AddWithValue("Name", e.NewValues("Name"))
        cmd.Parameters.AddWithValue("Type", e.NewValues("Type"))
        cmd.Parameters.AddWithValue("Complex", IIf(e.NewValues("Complex") = Nothing, DBNull.Value, e.NewValues("Complex")))
        cmd.Parameters.AddWithValue("District", e.NewValues("District"))
        cmd.Parameters.AddWithValue("Street", IIf(e.NewValues("Street") = Nothing, DBNull.Value, e.NewValues("Street")))
        cmd.Parameters.AddWithValue("RoomsNumber", IIf(e.NewValues("RoomsNumber") = Nothing, DBNull.Value, e.NewValues("RoomsNumber")))
        cmd.Parameters.AddWithValue("ApartmentArea", e.NewValues("ApartmentArea"))
        cmd.Parameters.AddWithValue("LandArea", IIf(e.NewValues("LandArea") = Nothing, DBNull.Value, e.NewValues("LandArea")))
        cmd.Parameters.AddWithValue("Floor", IIf(e.NewValues("Floor") = Nothing, DBNull.Value, e.NewValues("Floor")))
        cmd.Parameters.AddWithValue("TotalFloor", IIf(e.NewValues("TotalFloor") = Nothing, DBNull.Value, e.NewValues("TotalFloor")))
        cmd.Parameters.AddWithValue("Status", e.NewValues("Status"))
        cmd.Parameters.AddWithValue("Condition", e.NewValues("Condition"))
        cmd.Parameters.AddWithValue("Registration", e.NewValues("Registration"))
        cmd.Parameters.AddWithValue("WindowView", IIf(e.NewValues("WindowView") = Nothing, DBNull.Value, e.NewValues("WindowView")))
        cmd.Parameters.AddWithValue("Stove", IIf(e.NewValues("Stove") = Nothing, DBNull.Value, e.NewValues("Stove")))
        cmd.Parameters.AddWithValue("Ipoteka", IIf(e.NewValues("Ipoteka") = Nothing, DBNull.Value, e.NewValues("Ipoteka")))
        cmd.Parameters.AddWithValue("ToSea", IIf(e.NewValues("ToSea") = Nothing, DBNull.Value, e.NewValues("ToSea")))
        cmd.Parameters.AddWithValue("Sale", IIf(e.NewValues("Sale") = Nothing, DBNull.Value, e.NewValues("Sale")))
        cmd.Parameters.AddWithValue("Description", e.NewValues("Description"))
        cmd.Parameters.AddWithValue("VIP", IIf(e.NewValues("VIP") = Nothing, DBNull.Value, e.NewValues("VIP")))
        cmd.Parameters.AddWithValue("ElitProperty", IIf(e.NewValues("ElitProperty") = Nothing, DBNull.Value, e.NewValues("ElitProperty")))
        cmd.Parameters.AddWithValue("ActualUntil", IIf(e.NewValues("ActualUntil") = Nothing, DBNull.Value, e.NewValues("ActualUntil")))
        cmd.Parameters.AddWithValue("Hide", IIf(e.NewValues("Hide") = Nothing, DBNull.Value, e.NewValues("Hide")))
        cmd.Parameters.AddWithValue("Price", e.NewValues("Price"))
        c.Open()
        Dim PropertyID = cmd.ExecuteScalar
        c.Close()
        cmd.Dispose()
        c.Dispose()

        Directory.CreateDirectory(MapPath("~\Content\Foto\" & PropertyID.ToString))

    End Sub

    Protected Sub PropertyRegisterGrid_RowUpdating(sender As Object, e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs)

        Dim ChgPrice = CInt(e.OldValues("Price").ToString = e.NewValues("Price").ToString)

        Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)

        Dim cmd As New SqlCommand(" update [dbo].[PropertyObjects]
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
                                        Ipoteka = @Ipoteka,
                                        ToSea = @ToSea,
                                        Sale = @Sale,
                                        Description = @Description,
                                        VIP = @VIP,
                                        ElitProperty = @ElitProperty,
                                        ActualUntil = @ActualUntil,
                                        Hide = @Hide,
                                        LastUpdate = getdate()
                                    where ID = @ID

                                    if @ChgPrice = 0
                                    begin
                                        insert into [dbo].[PropertyObjectsMetaData] (Creator, ObjectID, MetaNameID, MetaData)
                                        values ('system', @ID, 54, @Price)
                                    end
                                    ", c)
        cmd.Parameters.AddWithValue("ID", e.Keys.Values(0))
        cmd.Parameters.AddWithValue("Name", e.NewValues("Name"))
        cmd.Parameters.AddWithValue("Type", e.NewValues("Type"))
        cmd.Parameters.AddWithValue("Complex", IIf(e.NewValues("Complex") = Nothing, DBNull.Value, e.NewValues("Complex")))
        cmd.Parameters.AddWithValue("District", e.NewValues("District"))
        cmd.Parameters.AddWithValue("Street", IIf(e.NewValues("Street") = Nothing, DBNull.Value, e.NewValues("Street")))
        cmd.Parameters.AddWithValue("Rooms", IIf(e.NewValues("RoomsNumber") = Nothing, DBNull.Value, e.NewValues("RoomsNumber")))
        cmd.Parameters.AddWithValue("ApartmentArea", e.NewValues("ApartmentArea"))
        cmd.Parameters.AddWithValue("LandArea", IIf(e.NewValues("LandArea") = Nothing, DBNull.Value, e.NewValues("LandArea")))
        cmd.Parameters.AddWithValue("Floor", IIf(e.NewValues("Floor") = Nothing, DBNull.Value, e.NewValues("Floor")))
        cmd.Parameters.AddWithValue("TotalFloor", IIf(e.NewValues("TotalFloor") = Nothing, DBNull.Value, e.NewValues("TotalFloor")))
        cmd.Parameters.AddWithValue("Status", e.NewValues("Status"))
        cmd.Parameters.AddWithValue("Condition", e.NewValues("Condition"))
        cmd.Parameters.AddWithValue("Registration", e.NewValues("Registration"))
        cmd.Parameters.AddWithValue("WindowView", IIf(e.NewValues("WindowView") = Nothing, DBNull.Value, e.NewValues("WindowView")))
        cmd.Parameters.AddWithValue("Stove", IIf(e.NewValues("Stove") = Nothing, DBNull.Value, e.NewValues("Stove")))
        cmd.Parameters.AddWithValue("Ipoteka", e.NewValues("Ipoteka"))
        cmd.Parameters.AddWithValue("ToSea", IIf(e.NewValues("ToSea") = Nothing, DBNull.Value, e.NewValues("ToSea")))
        cmd.Parameters.AddWithValue("Sale", e.NewValues("Sale"))
        cmd.Parameters.AddWithValue("Description", e.NewValues("Description"))
        cmd.Parameters.AddWithValue("VIP", e.NewValues("VIP"))
        cmd.Parameters.AddWithValue("ElitProperty", e.NewValues("ElitProperty"))
        cmd.Parameters.AddWithValue("ActualUntil", IIf(e.NewValues("ActualUntil") = Nothing, DBNull.Value, e.NewValues("ActualUntil")))
        cmd.Parameters.AddWithValue("Hide", e.NewValues("Hide"))
        cmd.Parameters.AddWithValue("Price", e.NewValues("Price"))
        cmd.Parameters.AddWithValue("ChgPrice", ChgPrice)

        c.Open()
        cmd.ExecuteNonQuery()
        c.Close()
        cmd.Dispose()
        c.Dispose()

    End Sub

    Protected Sub PropertyRegisterGrid_RowDeleted(sender As Object, e As Web.Data.ASPxDataDeletedEventArgs)

        ClearImageGalleryThumb()

        Directory.Delete(MapPath("~\Content\Foto\" & e.Values("ID").ToString), True)

    End Sub

    Protected Sub FileManager_FilesUploaded(source As Object, e As FileManagerFilesUploadedEventArgs)

        UpdateFotoCount()

        ClearImageGalleryThumb()

    End Sub

    Protected Sub FileManager_ItemsDeleted(source As Object, e As FileManagerItemsDeletedEventArgs)

        UpdateFotoCount()

        ClearImageGalleryThumb()

    End Sub

    Protected Sub UpdateFotoCount()

        Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)

        Dim cmd As New SqlCommand("update [dbo].[PropertyObjects]
                                   set Foto = @Foto, LastUpdate = getdate() 
                                   where ID = @ID", c)
        cmd.Parameters.AddWithValue("Foto", Directory.GetFiles(MapPath("~\Content\Foto\" & HiddenField.Get("OpenFotoID").ToString)).Count)
        cmd.Parameters.AddWithValue("ID", CInt(HiddenField.Get("OpenFotoID")))
        c.Open()
        cmd.ExecuteNonQuery()
        c.Close()
        cmd.Dispose()
        c.Dispose()

    End Sub

    Protected Sub FileManager_FileUploading(source As Object, e As FileManagerFileUploadEventArgs)


        If Directory.GetFiles(MapPath(e.File.Folder.FullName)).Count = 0 Then
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



    Public Shared Function GetReducedImage(ByVal image As Image, ByVal extremeWidth As Integer, ByVal extremeHeight As Integer) As Image

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

    Protected Sub FileManager_CustomCallback(sender As Object, e As CallbackEventArgsBase)


        Dim param As String() = e.Parameter.Split("/")

        Dim ThumbFolder As String = MapPath("~/Content/Thumb/PropertyRegisterThumb/" & param(4))

        Directory.Delete(ThumbFolder, True)

        ClearImageGalleryThumb()

        If Directory.GetFiles(MapPath(FileManager.SelectedFile.Folder.FullName), "!Main.*").Count = 0 Then

            My.Computer.FileSystem.RenameFile(MapPath(FileManager.SelectedFile.FullName), "!Main" & FileManager.SelectedFile.Extension)



        Else

            Dim fileEntries As String() = Directory.GetFiles(MapPath(FileManager.SelectedFile.Folder.FullName), "!Main.*")
            Dim fileName As String

            For Each fileName In fileEntries

                Dim g As Guid
                g = Guid.NewGuid()
                My.Computer.FileSystem.RenameFile(fileName, g.ToString & ".jpg")

            Next

            My.Computer.FileSystem.RenameFile(MapPath(FileManager.SelectedFile.FullName), "!Main" & FileManager.SelectedFile.Extension)

        End If



    End Sub


    Protected Sub ClearImageGalleryThumb()

        If Directory.Exists(MapPath("~\Content\Thumb\ImageGalleryThumb\" & HiddenField.Get("OpenFotoID").ToString)) Then

            Directory.Delete(MapPath("~\Content\Thumb\ImageGalleryThumb\" & HiddenField.Get("OpenFotoID").ToString), True)

        End If

    End Sub

End Class