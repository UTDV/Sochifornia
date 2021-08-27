Imports System.IO

Public Class VIPList
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'If Request.QueryString("type") = "v" Then
        '    VIPSlider.SettingsNavigationBar.Position = DevExpress.Web.NavigationBarPosition.Right
        'Else
        '    VIPSlider.SettingsNavigationBar.Position = DevExpress.Web.NavigationBarPosition.Bottom
        'End If



    End Sub

    'Protected Sub Unnamed_DataBound(sender As Object, e As EventArgs)

    '    Dim im As DevExpress.Web.ASPxImage = DirectCast(sender, DevExpress.Web.ASPxImage)

    '    If Directory.Exists(MapPath("~/Content/Foto/" & im.TabIndex.ToString)) = True Then

    '        If File.Exists(MapPath("~/Content/Foto/" & im.TabIndex.ToString & "/!Main.jpg")) = True Then
    '            im.ImageUrl = "~/Content/Foto/" & im.TabIndex.ToString & "/!Main.jpg"

    '        ElseIf File.Exists(MapPath("~/Content/Foto/" & im.TabIndex.ToString & "/!Main.jpeg")) = True Then
    '            im.ImageUrl = "~/Content/Foto/" & im.TabIndex.ToString & "/!Main.jpeg"

    '        ElseIf File.Exists(MapPath("~/Content/Foto/" & im.TabIndex.ToString & "/!Main.png")) = True Then
    '            im.ImageUrl = "~/Content/Foto/" & im.TabIndex.ToString & "/!Main.png"

    '        End If

    '    End If

    'End Sub

    Protected Sub VIPGallery_ItemDataBound(source As Object, e As DevExpress.Web.ImageGalleryItemEventArgs)

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