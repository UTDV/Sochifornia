Imports System.Web.Security

Public Class Login
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    <Obsolete>
    Protected Sub LoginButton_Click(sender As Object, e As EventArgs)

        If FormsAuthentication.Authenticate(LoginTB.Text, PasswordTB.Text) Then
            FormsAuthentication.RedirectFromLoginPage(LoginTB.Text, RememberCheckBox.Checked)
        Else
            ErrorLabel.Text = "Неверный логин/пароль"
        End If

    End Sub
End Class