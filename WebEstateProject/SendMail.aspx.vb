Imports System.Data.SqlClient
Imports MailKit.Net.Smtp
Imports System.Net
Imports MimeKit
Imports DevExpress.Web


Public Class SendMail
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim IsObj As Boolean = False

        'Dim emailto = "anastasvk@mail.ru"
        Dim emailto = "info@sochifornia.realty"

        Dim bld As New BodyBuilder()
        Dim message = New MimeMessage()
        message.From.Add(New MailboxAddress("Система уведомлений Sochifornia", "info@sochifornia.realty"))
        message.To.Add(New MailboxAddress("Sochifornia", emailto))

        message.Subject = "Оповещение об окончании срока актуальности объявлений"

        bld.HtmlBody = "<br/>Сегодня заканчивается срок актуальности следующих объявлений:<br/><br/>" _
            + "<table border='1' cellpadding='5' >
                <tbody>
                <tr>										   
                <th width='10%'; style='text-align: center;'> ID </th>
                <th width='25%'; style='text-align: center;'> Категория </th>	
                <th width='25%'; style='text-align: center;'> Район </th>
                <th width='40%'; style='text-align: center;'> Название </th>
                </tr>"

        Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)

        Dim cmd As New SqlCommand("declare @dt date = convert(date, getdate())

	                                SELECT p.ID
		                                 , p.[Name]
		                                 , (select MetaName
			                                from dbo.PropertyMetaNames
			                                where ID = p.[Type]) [Type]
		                                 , (select MetaName
			                                from dbo.PropertyMetaNames
			                                where ID = p.[District]) [District]
	                                FROM [dbo].[PropertyObjects] p 
	                                where p.Hide = 0 
	                                  and p.Sale = 0 
	                                  and p.ActualUntil = @dt", c)

        c.Open()
        Dim RDR As SqlDataReader
        RDR = cmd.ExecuteReader()
        While RDR.Read()
            If RDR.HasRows Then
                IsObj = True
                bld.HtmlBody = bld.HtmlBody + "<tr>
										    <th style='text-align: center;'> " + RDR("ID").ToString + " </th>
										    <th style='text-align: left;'> " + RDR("Type").ToString + "  </th>
										    <th style='text-align: left;'> " + RDR("District").ToString + " </th>
                                            <th style='text-align: left;'> " + RDR("Name").ToString + " </th>
										   </tr>"
            End If
        End While


        RDR.Close()
        c.Close()
        cmd.Dispose()
        c.Dispose()


        bld.HtmlBody += "</tbody></table>"

        bld.HtmlBody += "<br/><br/><br/>Письмо сгенерированно автоматически, отвечать на него не надо."

        message.Body = bld.ToMessageBody()

        If IsObj = True Then
            Dim client = New SmtpClient()
            client.Connect("smtp.mail.ru", 465, True)
            client.Authenticate("info@sochifornia.realty", "Ii123456")
            client.Send(message)
            client.Disconnect(True)
        End If


    End Sub

End Class