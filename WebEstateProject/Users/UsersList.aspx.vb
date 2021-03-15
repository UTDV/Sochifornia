Public Class UsersList
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("GUID") Is Nothing Or Session("Status") <> "64" Then
            Response.Redirect("~/Users/LoginUser.aspx")
        End If

    End Sub

End Class