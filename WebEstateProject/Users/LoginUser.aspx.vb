Imports System.Data.SqlClient


Public Class Login1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub LoginButton_Click(sender As Object, e As EventArgs)

        Dim hash As String = GetHash.GetPasswordHash(PasswordTB.Text)

        Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)

        Dim cmd As New SqlCommand("SELECT [GUID], Status, Role, [FirstName] + ' ' + [LastName] as UserName
                                   FROM [u1302649_sochifornia].[dbo].[Users]
                                   where CONCAT(Email, Password) = CONCAT(@Email, @Password)  ", c)
        cmd.Parameters.AddWithValue("Email", LoginEmailTB.Text)
        cmd.Parameters.AddWithValue("Password", hash)
        c.Open()
        Dim res As Integer = 0
        Dim resString As String = ""
        Dim userstatus As String = ""
        Dim userrole As String = ""
        Dim username As String = ""
        Dim RDR As SqlDataReader
        RDR = cmd.ExecuteReader
        RDR.Read()
        If RDR.HasRows Then
            res = 1
            resString = RDR("GUID").ToString
            userstatus = RDR("Status").ToString
            userrole = RDR("Role").ToString
            username = RDR("UserName").ToString
        End If
        RDR.Close()
        c.Close()
        cmd.Dispose()
        c.Dispose()

        If res = 1 Then
            'Session("GUID") = resString
            'Session("Status") = userstatus

            Dim ticket As FormsAuthenticationTicket = New FormsAuthenticationTicket(1, resString, Now, Now.AddMinutes(FormsAuthentication.Timeout.TotalMinutes), False, userstatus & "|" & userrole & "|" & username)
            Dim encTicket As String = FormsAuthentication.Encrypt(ticket)
            Response.Cookies.Add(New HttpCookie(FormsAuthentication.FormsCookieName, encTicket))

            'FormsAuthentication.RedirectFromLoginPage(LoginEmailTB.Text, False)
            'Response.Redirect(FormsAuthentication.GetRedirectUrl(LoginEmailTB.Text, False))
            Response.Redirect("~/PropertyRegister.aspx")
        Else
            ErrorLabel.Text = "Неверный логин или пароль"
        End If


    End Sub

End Class