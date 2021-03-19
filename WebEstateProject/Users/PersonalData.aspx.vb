Imports System.IO
Imports System.Data.SqlClient

Public Class ConfirmUserData
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

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

                Else

                    Directory.CreateDirectory(MapPath("~\Content\UsersContent\" & Session("GUID").ToString))

                    If Directory.GetFiles(MapPath("~\Content\UsersContent\" & Session("GUID").ToString), "Avatar.png").Count = 1 Then
                        AvatarBI.ContentBytes = GetByteArrayFromImage("~\Content\UsersContent\" & Session("GUID").ToString & "\Avatar.png")
                    End If

                End If

            End If

        End If

    End Sub

    Protected Function GetByteArrayFromImage(ByVal img As String) As Byte()
        Dim byteArray() As Byte = Nothing
        Using stream As New FileStream(Server.MapPath(img), FileMode.Open, FileAccess.Read)
            byteArray = New Byte(stream.Length - 1) {}
            stream.Read(byteArray, 0, CInt(Fix(stream.Length)))
        End Using
        Return byteArray
    End Function

    Protected Sub AvatarUpload_FileUploadComplete(sender As Object, e As DevExpress.Web.FileUploadCompleteEventArgs)


        e.UploadedFile.SaveAs(MapPath("~\Content\UsersContent\" & Session("GUID").ToString & "\Avatar.png"), True)



    End Sub

    Protected Sub SaveButton_Click(sender As Object, e As EventArgs)

        Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)

        Dim cmd As New SqlCommand("update [dbo].[Users]
                                   set LastName = @LastName,
                                       FirstName = @FirstName,
	                                   SecondName = @SecondName,
	                                   BirthDate = @BirthDate,
	                                   WhatsApp = @WhatsApp,
	                                   Telegram = @Telegram,
	                                   VK = @VK,
	                                   Facebook = @Facebook,
	                                   Instagram = @Instagram
                                   where GUID = @GUID", c)
        cmd.Parameters.AddWithValue("GUID", Session("GUID").ToString)
        cmd.Parameters.AddWithValue("LastName", LastNameTB.Text)
        cmd.Parameters.AddWithValue("FirstName", FirstNameTB.Text)
        cmd.Parameters.AddWithValue("SecondName", IIf(IsNothing(SecondNameTB.Value) = True, DBNull.Value, SecondNameTB.Text))
        cmd.Parameters.AddWithValue("BirthDate", BirthDateDE.Value)
        cmd.Parameters.AddWithValue("WhatsApp", IIf(IsNothing(WhatsAppTB.Value) = True, DBNull.Value, WhatsAppTB.Text))
        cmd.Parameters.AddWithValue("Telegram", IIf(IsNothing(TelegramTB.Value) = True, DBNull.Value, TelegramTB.Text))
        cmd.Parameters.AddWithValue("VK", IIf(IsNothing(VKTB.Value) = True, DBNull.Value, VKTB.Text))
        cmd.Parameters.AddWithValue("Facebook", IIf(IsNothing(FacebookTB.Value) = True, DBNull.Value, FacebookTB.Text))
        cmd.Parameters.AddWithValue("Instagram", IIf(IsNothing(InstagramTB.Value) = True, DBNull.Value, InstagramTB.Text))
        c.Open()
        cmd.ExecuteNonQuery()
        c.Close()
        cmd.Dispose()
        c.Dispose()

        Response.Redirect(Request.Path)

    End Sub

End Class