Imports System.Data.SqlClient
Imports System.IO

Public Class PropertyDetails
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Request.QueryString("id") Is Nothing Then
            Response.Redirect("~/Default.aspx")
        End If

        Directory.CreateDirectory(MapPath("~\Content\Foto\" & Request.QueryString("id").ToString))

        FotoGallary.SettingsFolder.ImageSourceFolder = "~\Content\Foto\" & Request.QueryString("id").ToString

        FotoGallary.SettingsFolder.ImageCacheFolder = "~\Content\Thumb\ImageGalleryThumb\" & Request.QueryString("id").ToString

        FotoGallary.UpdateImageCacheFolder()

        Dim TpDev = Request.Browser.IsMobileDevice

        If TpDev = True Then
            PrintButton.Visible = False
        End If

        If Not IsPostBack Then

            Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)

            Dim cmd As New SqlCommand("exec dbo.GetPropertyObjectData @ID", c)
            cmd.Parameters.AddWithValue("ID", Request.QueryString("id"))
            c.Open()
            Dim RDR As SqlDataReader
            RDR = cmd.ExecuteReader
            RDR.Read()

            If RDR.HasRows Then
                TypeLabel.Text = RDR("Type").ToString.ToUpper
                HeadLine.HeaderText = RDR("Name").ToString
                Page.Title = RDR("Name").ToString
                ComplexLabel.Text = RDR("Complex").ToString
                DistrictLabel.Text = RDR("District").ToString
                StreetLabel.Text = RDR("Street").ToString
                RoomsLabel.Text = RDR("Rooms").ToString
                PriceLabel.Text = RDR("Price").ToString
                AreaLabel.Text = RDR("ApartmentArea").ToString
                PriceForMetrLabel.Text = RDR("PriceForMetr").ToString
                LandAreaLabel.Text = RDR("LandArea").ToString
                FloorLabel.Text = RDR("Floor").ToString
                ToSeaLabel.Text = RDR("ToSea").ToString
                StatusLabel.Text = RDR("Status").ToString
                ConditionLabel.Text = RDR("Condition").ToString
                RegistrationLabel.Text = RDR("Registration").ToString
                ViewLabel.Text = RDR("WindowView").ToString
                StoveLabel.Text = RDR("Stove").ToString
                IpotekaLabel.Text = RDR("Ipoteka").ToString
                DescriptionLabel.Text = RDR("Description").ToString
                LastUpdateLabel.Text = RDR("LastUpdate").ToString
                If RDR("ActualStatus").ToString <> "Актуально" Then
                    ActualStatusHeadline.HeaderText = RDR("ActualStatus").ToString.ToUpper
                End If
            End If
            RDR.Close()
            c.Close()
            cmd.Dispose()
            c.Dispose()

            If StoveLabel.Text = "" Then
                FormLayout.FindItemOrGroupByName("Stove").Visible = False
            End If

            If ComplexLabel.Text = "" Then
                FormLayout.FindItemOrGroupByName("Complex").Visible = False
            End If

            If StreetLabel.Text = "" Then
                FormLayout.FindItemOrGroupByName("Street").Visible = False
            End If

            If RoomsLabel.Text = "" Then
                FormLayout.FindItemOrGroupByName("Rooms").Visible = False
            End If

            If LandAreaLabel.Text = "" Then
                FormLayout.FindItemOrGroupByName("LandArea").Visible = False
            End If

            If FloorLabel.Text = "" Then
                FormLayout.FindItemOrGroupByName("Floor").Visible = False
            End If

            If ToSeaLabel.Text = "" Then
                FormLayout.FindItemOrGroupByName("ToSea").Visible = False
            End If

            If ViewLabel.Text = "" Then
                FormLayout.FindItemOrGroupByName("WindowView").Visible = False
            End If

        End If

        If ActualStatusHeadline.HeaderText = "СКРЫТО" Then
            Response.Redirect("~/Default.aspx")
        End If

    End Sub

End Class