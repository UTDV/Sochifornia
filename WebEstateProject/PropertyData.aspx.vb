Public Class PropertyData
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If Request.QueryString("id") Is Nothing Then
            Response.Redirect("~/PropertyRegister.aspx")
        End If

        FileManager.Settings.RootFolder = MapPath("~/Content/Foto/" & Request.QueryString("id"))

    End Sub

End Class