Imports DevExpress.Data
Imports MailKit.Net.Smtp
Imports MimeKit
Imports System.Data.SqlClient

Public Class _Default
    Inherits System.Web.UI.Page

    Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If (Not PropertyCardView.IsCallback) Then
            SetPropertyCardViewSorting("ByDate")
        End If

        If Not IsPostBack Then
            HiddenField("ID") = ""
            ObjectHiddenField("CreatorEmail") = ""
            ObjectHiddenField("slug") = ""
        End If

    End Sub

    Protected Sub ItemTextLabel_Init(sender As Object, e As EventArgs)

        Dim lb As DevExpress.Web.ASPxLabel = DirectCast(sender, DevExpress.Web.ASPxLabel)
        lb.Text = Eval("Type").ToString

    End Sub

    Private Sub SetPropertyCardViewSorting(ByVal sortPrm As String)

        PropertyCardView.ClearSort()

        Select Case sortPrm
            Case "ByDate"
                PropertyCardView.SortBy(PropertyCardView.Columns("LastUpdate"), ColumnSortOrder.Descending)
            Case "ByPriceAsc"
                PropertyCardView.SortBy(PropertyCardView.Columns("Price"), ColumnSortOrder.Ascending)
            Case "ByPriceDesc"
                PropertyCardView.SortBy(PropertyCardView.Columns("Price"), ColumnSortOrder.Descending)
        End Select

    End Sub

    Private Sub SetPropertyCardViewFiltering(ByVal FltrExpr As String)

        PropertyCardView.FilterExpression = FltrExpr

    End Sub

    Protected Sub PropertyCardView_CustomCallback(sender As Object, e As DevExpress.Web.ASPxCardViewCustomCallbackEventArgs)

        Dim data() As String = e.Parameters.Split("|")

        If data(0) = "filter" Then
            SetPropertyCardViewFiltering(data(1))
        End If

        If data(0) = "sort" Then
            SetPropertyCardViewSorting(data(1))
        End If


    End Sub

    Protected Sub ContactsPopup_WindowCallback(source As Object, e As DevExpress.Web.PopupWindowCallbackArgs)

        Dim cmd As New SqlCommand("exec dbo.GetPropertyObjectData @ID", c)
        cmd.Parameters.AddWithValue("ID", e.Parameter)
        c.Open()
        Dim RDR As SqlDataReader
        RDR = cmd.ExecuteReader
        RDR.Read()
        If RDR.HasRows Then

            CreatorNameHL.HeaderText = RDR("CreatorName").ToString
            CreatorPhone.HeaderText = Format(CDbl(RDR("CreatorPhone").ToString), "+# (###) ###-##-##")
            CreatorPhone.NavigateUrl = "tel:+" + RDR("CreatorPhone").ToString
            ObjectHiddenField("CreatorEmail") = RDR("CreatorEmail").ToString
            ObjectHiddenField("slug") = RDR("Slug").ToString

        End If
        RDR.Close()
        c.Close()
        cmd.Dispose()
        c.Dispose()

        ContactsFormLayout.ClientVisible = True

    End Sub

    Protected Sub CBackSendMail_Callback(source As Object, e As DevExpress.Web.CallbackEventArgs)

        Try

            Dim emailto As String = ObjectHiddenField("CreatorEmail")
            'Dim path As String = MapPath("~/object/" & ObjectHiddenField("slug"))

            Dim path2 As String = "https://Sochifornia.realty/object/" & ObjectHiddenField("slug")

            'Dim path3 As String = "../object/" & ObjectHiddenField("slug")

            Dim bld As New BodyBuilder()
            Dim message = New MimeMessage()
            message.From.Add(New MailboxAddress("Система уведомлений Sochifornia", "info@sochifornia.realty"))
            message.To.Add(New MailboxAddress(emailto, emailto))

            message.Subject = "Сообщение с сайта от клиента"

            bld.HtmlBody = "<br/>Поступило сообщение от клиента " & NameSendMail.Text & ", телефон: " & IIf(IsNothing(PhoneSendMail.Value) = True, "не указан", PhoneSendMail.Text) &
                ", почта: " & IIf(IsNothing(EmailSendMail.Value) = True, "не указана", EmailSendMail.Text) & "<br/><br/>" & "Текст сообщения: " & IIf(IsNothing(NoteSendMail.Value) = True, NoteSendMail.NullText, NoteSendMail.Text) &
                "<br/><br/>" & "<a href=" & path2 + "> ССЫЛКА НА ОБЪЕКТ </a>"

            message.Body = bld.ToMessageBody()

            Dim client = New SmtpClient()
            client.Connect("smtp.mail.ru", 465, True)
            client.Authenticate("info@sochifornia.realty", "Ii123456")
            client.Send(message)
            client.Disconnect(True)

            e.Result = 1

        Catch ex As Exception
            e.Result = 0
        End Try

    End Sub

End Class