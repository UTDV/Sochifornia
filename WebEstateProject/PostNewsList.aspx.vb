Imports System.IO
Imports DevExpress.Web

Public Class PostNewsList
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub NewsList_ItemDataBound(source As Object, e As DevExpress.Web.NewsItemEventArgs)

        Dim ht As ASPxHtmlEditor.ASPxHtmlEditor = New ASPxHtmlEditor.ASPxHtmlEditor

        ht.Html = e.Item.Text

        Dim mStream As MemoryStream = New MemoryStream()
        ht.Export(DevExpress.Web.ASPxHtmlEditor.HtmlEditorExportFormat.Txt, mStream)
        Dim plainText As String = System.Text.Encoding.UTF8.GetString(mStream.ToArray())

        e.Item.Text = plainText

    End Sub

End Class