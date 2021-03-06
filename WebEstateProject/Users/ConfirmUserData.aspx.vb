Public Class ConfirmUserData
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If Request.QueryString("guid") Is Nothing Then
            Response.Redirect("~/Users/LoginUser.aspx")
        End If


    End Sub

End Class