Public Class Site1
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Request.Path.ToLower = "/login.aspx" Or Request.Path.ToLower = "/users/loginuser.aspx" Or Request.Path.ToLower = "/users/registration.aspx" Or Request.Path.ToLower = "/users/confirmuserdata.aspx" Then

            AuthorizationButton.Visible = False
            ExitButton.Visible = False
            BottomForm.FindItemOrGroupByName("PropertyRegisterButtonItem").Visible = False

        Else

            If Request.Path.ToLower = "/propertyregister.aspx" Then
                BottomPanel.Visible = False
            End If

            If Request.IsAuthenticated Then
                AuthorizationButton.Visible = False
                ExitButton.Visible = True
                BottomForm.FindItemOrGroupByName("PropertyRegisterButtonItem").Visible = True
            Else
                AuthorizationButton.Visible = True
                ExitButton.Visible = False
                BottomForm.FindItemOrGroupByName("PropertyRegisterButtonItem").Visible = False
            End If

        End If



    End Sub

    Protected Sub ExitButton_Click(sender As Object, e As EventArgs)
        FormsAuthentication.SignOut()
        Response.Redirect("Default.aspx")
    End Sub
End Class