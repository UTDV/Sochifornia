Imports System.Data.SqlClient
Imports System.IO
Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.Windows.Forms

Public Class PostEditPage
    Inherits System.Web.UI.Page




    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)
        Dim cmd As SqlCommand
        Dim PostID As Int32 = 0

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

                ' Если статус не Активный
                If Session("Status") <> "64" Then
                    Session("GUID") = Nothing
                    FormsAuthentication.SignOut()
                    Response.Redirect("~/Users/LoginUser.aspx")
                End If
            End If




            If Request.QueryString("slug") = "new" Then
                cmd = New SqlCommand("INSERT INTO [dbo].[Posts]
                                                   ([Creator]
                                                   ,[Category])
                                             VALUES
                                                   ( (Select ID from Users where GUID = @UserGUID) 
                                                   ,@Category)

                                                Declare @PostId int = IDENT_CURRENT('[dbo].[Posts]')

                                                INSERT INTO [dbo].[PostsMetaData]
                                                       ([PostId]
                                                       ,[MetaNameID]
                                                       ,[MetaData])
                                                 VALUES
                                                       (@PostId
		                                               , 17
		                                               , 11)
                                                Select @PostId
                                                ", c)
                cmd.Parameters.AddWithValue("UserGUID", Session("UserGUID").ToString)
                cmd.Parameters.AddWithValue("Category", Request.QueryString("type"))
                c.Open()
                PostID = cmd.ExecuteScalar
                c.Close()
                cmd.Dispose()

                Response.Redirect("~/PostEditPage.aspx?id=" + PostID.ToString)

            ElseIf Request.QueryString("slug") Is Nothing Then
                If Request.QueryString("id") Is Nothing Then
                    Response.Redirect("~/PostRegister.aspx")
                End If
                PostID = Request.QueryString("id")
            Else
                cmd = New SqlCommand("Select ID from [dbo].[Posts] where slug = @slug", c)
                cmd.Parameters.AddWithValue("slug", Request.QueryString("slug"))
                c.Open()
                PostID = cmd.ExecuteScalar
                c.Close()
                cmd.Dispose()
            End If


            If PostID > 0 Then
                If Session("Role") = 60 Then
                    Category_CB.Enabled = True
                    Creator_CB.Enabled = True
                    ID_TB.Enabled = True
                Else
                    cmd = New SqlCommand("Select convert(nvarchar,u.guid)
                                            from [dbo].[Posts] p
                                                join Users u on u.id = p.Creator
                                            where ID = @id", c)
                    cmd.Parameters.AddWithValue("id", PostID.ToString)
                    c.Open()
                    Dim UserGuid As String = cmd.ExecuteScalar
                    c.Close()
                    cmd.Dispose()

                    If UserGuid.ToUpper <> Session("UserGUID").ToString.ToUpper Then
                        'Response.Write("Нет прав")
                        Response.Redirect("~/PostRegister.aspx")
                    End If
                End If
            Else
                Response.Redirect("~/PostRegister.aspx")
            End If
            RenewFields()


        End If




    End Sub

    Private Sub RenewFields()
        Dim PostID As Int32 = Request.QueryString("id")
        Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)
        Dim cmd As New SqlCommand("Select p.Text, p.ImageURL, p.Category, SubCat.MetaData SubCategory, Reg.MetaData Region
                                    from [dbo].[Posts] p
                                        left join [dbo].[PostsMetaData] SubCat on SubCat.PostId = p.ID	and SubCat.MetaNameID = 22
		                                left join [dbo].[PostsMetaData] Reg on Reg.PostId = p.ID	and Reg.MetaNameID = 23
                                    where p.ID = @id", c)
        cmd.Parameters.AddWithValue("id", PostID.ToString)

        c.Open()
        Try
            Dim rdr = cmd.ExecuteReader
            If rdr.HasRows() Then
                rdr.Read()

                HTML_TB.Html = rdr("Text").ToString

                If Len(rdr("ImageUrl").ToString) > 0 Then


                    Dim byteArray() As Byte = Nothing
                    Using stream As New IO.FileStream(Server.MapPath("~\Content\PostsFoto\" + rdr("ImageUrl").ToString), IO.FileMode.Open, IO.FileAccess.Read)
                        byteArray = New Byte(stream.Length - 1) {}
                        stream.Read(byteArray, 0, CInt(Fix(stream.Length)))
                    End Using
                    AvatarBI.ContentBytes = byteArray
                End If

                SubCategory_CB.Value = rdr("SubCategory")
                Region_CB.Value = rdr("Region")
                'MainImage.ImageUrl = "~\Content\PostsFoto\" + rdr("ImageUrl").ToString
                If rdr("Category") = 1 Then
                    PostForm.FindItemOrGroupByName("SubCategory").Visible = True
                    PostForm.FindItemOrGroupByName("Region").Visible = False
                ElseIf rdr("Category") = 3 Then
                    PostForm.FindItemOrGroupByName("Region").Visible = True
                    PostForm.FindItemOrGroupByName("SubCategory").Visible = False
                Else
                    PostForm.FindItemOrGroupByName("Region").Visible = False
                    PostForm.FindItemOrGroupByName("SubCategory").Visible = False
                End If

            End If
            rdr.Close()
        Catch ex As Exception

        End Try

        c.Close()
        cmd.Dispose()
        Directory.CreateDirectory(MapPath("~\Content\PostsFoto\" + Request.QueryString("id")))

        PostGallegy.SettingsFolder.ImageSourceFolder = "~\Content\PostsFoto\" + Request.QueryString("id")
        PostGallegy.SettingsFolder.ImageCacheFolder = "~\Content\PostsFoto\Cache"
        FileManager.Settings.RootFolder = "~\Content\PostsFoto\" + Request.QueryString("id")


    End Sub

    Protected Sub MN_Panel_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)


        Try
            System.Threading.Thread.Sleep(500)
            Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)
            Dim cmd As New SqlCommand("Update Posts
                                        set Created = @Created
                                        , Creator = @Creator
                                        , Slug = @Slug
                                        , Header = @Header
                                        , Text = @Text
                                        , Category = @Category
                                       where ID = @ID
                                    
                                    if @SubCategory > 0 
                                    begin
                                        if (select count(*) from PostsMetaData where MetaNameId =22 and PostID = @ID )> 0
                                        begin
                                            update PostsMetaData set MetaData = @SubCategory where MetaNameId =22 and PostID = @ID
                                        end
                                        else
                                        begin
                                            insert into PostsMetaData (PostID, MetaNameId, MetaData) Values (@ID,22,@SubCategory)
                                        end
                                    end

                                    if @Region > 0 
                                    begin
                                        if (select count(*) from PostsMetaData where MetaNameId =23 and PostID = @ID )> 0
                                        begin
                                            update PostsMetaData set MetaData = @Region where MetaNameId =23 and PostID = @ID
                                        end
                                        else
                                        begin
                                            insert into PostsMetaData (PostID, MetaNameId, MetaData) Values (@ID,23,@Region)
                                        end
                                    end

                                    if @Status <> (SELECT MetaData
                                                    FROM PostsMetaData
                                                    WHERE PostId = @ID
                                                          AND MetaNameId = 17
                                                          AND created =
                                                    (
                                                        SELECT MAX(created)
                                                        FROM PostsMetaData
                                                        WHERE PostId = @ID
                                                              AND MetaNameId = 17
                                                    ))
                                    Begin
                                        INSERT INTO [dbo].[PostsMetaData]
                                               ([PostId]
                                               ,[MetaNameID]
                                               ,[MetaData])
                                         VALUES
                                               (@ID
		                                       , 17
		                                       , @Status)
                                    End

                                           ", c)
            cmd.Parameters.AddWithValue("ID", ID_TB.Value)
            cmd.Parameters.AddWithValue("Created", Created_DE.Value)
            cmd.Parameters.AddWithValue("Creator", Creator_CB.Value)
            cmd.Parameters.AddWithValue("Slug", IIf(Slug_TB.Text Is Nothing, DBNull.Value, Slug_TB.Text))
            cmd.Parameters.AddWithValue("Header", IIf(Header_TB.Text Is Nothing, DBNull.Value, Header_TB.Text))
            cmd.Parameters.AddWithValue("Text", IIf(HTML_TB.Html Is Nothing, DBNull.Value, HTML_TB.Html))
            cmd.Parameters.AddWithValue("Category", Category_CB.Value)
            cmd.Parameters.AddWithValue("Status", Status_CB.Value)
            cmd.Parameters.AddWithValue("SubCategory", IIf(SubCategory_CB.Value Is Nothing, DBNull.Value, SubCategory_CB.Value))
            cmd.Parameters.AddWithValue("Region", IIf(Region_CB.Value Is Nothing, DBNull.Value, Region_CB.Value))

            c.Open()
            cmd.ExecuteNonQuery()
            c.Close()


        Catch ex As Exception

        End Try

        'RenewFields()
    End Sub

    Protected Sub ImageUpload_FilesUploadComplete(sender As Object, e As DevExpress.Web.FilesUploadCompleteEventArgs)

    End Sub

    Protected Sub ImageUpload_FileUploadComplete(sender As Object, e As DevExpress.Web.FileUploadCompleteEventArgs)
        Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)
        Dim fn = e.UploadedFile.FileName
        Dim g = Guid.NewGuid()
        Dim url = MapPath("~\Content\PostsFoto\" & g.ToString + ".png")
        e.UploadedFile.SaveAs(url)

        Dim cmd As New SqlCommand("Update Posts set  ImageUrl = @Url where Id = @ID", c)

        cmd.Parameters.AddWithValue("ID", Request.QueryString("id"))
        cmd.Parameters.AddWithValue("Url", g.ToString + ".png")
        c.Open()
        cmd.ExecuteNonQuery()
        c.Close()
        cmd.Dispose()
        c.Dispose()

    End Sub

    Protected Sub ImageCallBack_Callback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)
        Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)
        Dim cmd As New SqlCommand("Select  ImageURL
                                    from [dbo].[Posts] p
                                        
                                    where ID = @id", c)
        cmd.Parameters.AddWithValue("id", Request.QueryString("id").ToString)

        c.Open()
        Try
            Dim rdr = cmd.ExecuteScalar
            If Len(rdr.ToString) > 0 Then
                Dim byteArray() As Byte = Nothing
                Using stream As New IO.FileStream(Server.MapPath("~\Content\PostsFoto\" + rdr.ToString), IO.FileMode.Open, IO.FileAccess.Read)
                    byteArray = New Byte(stream.Length - 1) {}
                    stream.Read(byteArray, 0, CInt(Fix(stream.Length)))
                End Using
                AvatarBI.ContentBytes = byteArray
            End If
        Catch ex As Exception

        End Try

        c.Close()
        cmd.Dispose()
    End Sub

    Protected Sub FileManager_CustomCallback(sender As Object, e As DevExpress.Web.CallbackEventArgsBase)

    End Sub

    Protected Sub FileManager_FilesUploaded(source As Object, e As DevExpress.Web.FileManagerFilesUploadedEventArgs)

    End Sub

    Protected Sub FileManager_ItemsDeleted(source As Object, e As DevExpress.Web.FileManagerItemsDeletedEventArgs)

    End Sub

    Protected Sub FileManager_FileUploading(source As Object, e As DevExpress.Web.FileManagerFileUploadEventArgs)
        'If Directory.GetFiles(MapPath(e.File.Folder.FullName)).Count = 0 Then
        '    e.FileName = "!Main" & e.File.Extension
        'End If

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

    Protected Sub MN_Panel_PreRender(sender As Object, e As EventArgs)
        RenewFields()
    End Sub

    Protected Sub MN_Panel_BeforeGetCallbackResult(sender As Object, e As EventArgs)
        RenewFields()
    End Sub

    Protected Sub CBack_Callback_TB(source As Object, e As DevExpress.Web.CallbackEventArgs)
        e.Result = SlugUniq.GetSlug(e.Parameter, SlugUniq.SlugType.Post, Request.QueryString("id"))

    End Sub
End Class