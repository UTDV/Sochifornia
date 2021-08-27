Imports System.Data.SqlClient
Imports System.IO

Public Class PostNewsDetails
    Inherits System.Web.UI.Page

    Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim tp As String = ""

        If Request.QueryString("type") IsNot Nothing Then
            tp = Request.QueryString("type")
        End If


        If Not IsPostBack Then

            HiddenField("slug") = Request.CurrentExecutionFilePath.Split("/")(2)

            Dim cmd As New SqlCommand("Exec dbo.[GetPostInfoShow] @slug, @type", c)
            cmd.Parameters.AddWithValue("slug", Request.CurrentExecutionFilePath.Split("/")(2))
            cmd.Parameters.AddWithValue("type", tp)
            c.Open()
            Dim RDR As SqlDataReader
            RDR = cmd.ExecuteReader
            RDR.Read()
            If RDR.HasRows Then
                NewsHeadline.ContentText = RDR("Text").ToString
                Page.Title = RDR("Header").ToString
                HeaderLabel.Text = RDR("Header").ToString
                DateLabel.Text = FormatDateTime(CDate(RDR("Created").ToString), DateFormat.ShortDate)

                If RDR("ImageUrl").ToString <> "/Content/PostsFoto/" Then

                    Dim byteArray() As Byte = Nothing
                    Using stream As New IO.FileStream(Server.MapPath("~" + RDR("ImageUrl").ToString), IO.FileMode.Open, IO.FileAccess.Read)
                        byteArray = New Byte(stream.Length - 1) {}
                        stream.Read(byteArray, 0, CInt(Fix(stream.Length)))
                    End Using
                    MainFotoBI.ContentBytes = byteArray

                    NewsFormLayout.FindItemOrGroupByName("MainFotoLayoutItem").ClientVisible = True

                Else

                    NewsFormLayout.FindItemOrGroupByName("MainFotoLayoutItem").ClientVisible = False

                End If


                Dim galleryCount As Integer = Directory.GetFiles(Server.MapPath(RDR("GalleryUrl").ToString)).Count

                If galleryCount > 0 Then

                    NewsImageGallegy.SettingsFolder.ImageSourceFolder = RDR("GalleryUrl").ToString
                    NewsImageGallegy.SettingsFolder.ImageCacheFolder = "~\Content\PostsFoto\Cache"

                    NewsFormLayout.FindItemOrGroupByName("NewsGallery").ClientVisible = True

                    If galleryCount >= 6 Then
                        'NewsImageGallegy.Width = 700
                        NewsImageGallegy.SettingsBreakpointsLayout.ItemsPerRow = 6
                    Else
                        'NewsImageGallegy.Width = galleryCount * 100 + 100
                        NewsImageGallegy.SettingsBreakpointsLayout.ItemsPerRow = galleryCount
                    End If

                Else
                    NewsFormLayout.FindItemOrGroupByName("NewsGallery").ClientVisible = False
                End If

                'похожие новости

                If RDR("SimilarCnt") = 0 Then
                    NewsFormLayout.FindItemOrGroupByName("SimilarPostsGroup").ClientVisible = False
                Else
                    NewsFormLayout.FindItemOrGroupByName("SimilarPostsGroup").ClientVisible = True
                End If

            End If
            RDR.Close()
            c.Close()
            cmd.Dispose()

        End If

    End Sub

    Protected Sub NewAdGallery_ItemDataBound(source As Object, e As DevExpress.Web.ImageGalleryItemEventArgs)

        If Directory.Exists(MapPath("~/Content/Foto/" & e.Item.Name)) = True Then

            If File.Exists(MapPath("~/Content/Foto/" & e.Item.Name & "/!Main.jpg")) = True Then

                e.Item.ImageUrl = "~/Content/Foto/" & e.Item.Name & "/!Main.jpg"

            ElseIf File.Exists(MapPath("~/Content/Foto/" & e.Item.Name & "/!Main.jpeg")) = True Then
                e.Item.ImageUrl = "~/Content/Foto/" & e.Item.Name & "/!Main.jpeg"

            ElseIf File.Exists(MapPath("~/Content/Foto/" & e.Item.Name & "/!Main.png")) = True Then
                e.Item.ImageUrl = "~/Content/Foto/" & e.Item.Name & "/!Main.png"

            Else
                e.Item.ImageUrl = "~/Content/Foto/007/placeholder.png"

            End If

        Else
            e.Item.ImageUrl = "~/Content/Foto/007/placeholder.png"

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