Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.IO

Public Class NewAdList
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    Protected Sub NewAdGallery_ItemDataBound(source As Object, e As DevExpress.Web.ImageGalleryItemEventArgs)

        Dim path As String

        If Directory.Exists(MapPath("~/Content/Foto/" & e.Item.Name)) = True Then

            If File.Exists(MapPath("~/Content/Foto/" & e.Item.Name & "/!Main.jpg")) = True Then
                path = "~/Content/Foto/" & e.Item.Name & "/!Main.jpg"

            ElseIf File.Exists(MapPath("~/Content/Foto/" & e.Item.Name & "/!Main.jpeg")) = True Then
                path = "~/Content/Foto/" & e.Item.Name & "/!Main.jpeg"

            ElseIf File.Exists(MapPath("~/Content/Foto/" & e.Item.Name & "/!Main.png")) = True Then
                path = "~/Content/Foto/" & e.Item.Name & "/!Main.png"

            Else
                path = "~/Content/Foto/007/placeholder.png"

            End If

        Else
            path = "~/Content/Foto/007/placeholder.png"

        End If

        Dim byteArray() As Byte = Nothing
        Using stream As New IO.FileStream(Server.MapPath(path), IO.FileMode.Open, IO.FileAccess.Read)
            byteArray = New Byte(stream.Length - 1) {}
            stream.Read(byteArray, 0, CInt(Fix(stream.Length)))
        End Using

        e.Item.ImageContentBytes = byteArray


    End Sub



End Class