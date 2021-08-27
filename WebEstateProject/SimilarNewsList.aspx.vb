Imports System.IO

Public Class SimilarNewsList
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

            SimilarHiddenField("slug") = Request.QueryString("slug")

        End If

    End Sub

    Protected Sub SimilarNewsGallery_ItemDataBound(source As Object, e As DevExpress.Web.ImageGalleryItemEventArgs)

        Dim path As String

        If File.Exists(MapPath("~/Content/PostsFoto/" & e.Item.Name)) = True Then
            path = "~/Content/PostsFoto/" & e.Item.Name

        Else
            path = "~/Content/Foto/007/News/News.jpg"

        End If

        Dim byteArray() As Byte = Nothing
        Using stream As New IO.FileStream(Server.MapPath(path), IO.FileMode.Open, IO.FileAccess.Read)
            byteArray = New Byte(stream.Length - 1) {}
            stream.Read(byteArray, 0, CInt(Fix(stream.Length)))
        End Using

        e.Item.ImageContentBytes = byteArray

    End Sub
End Class