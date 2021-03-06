Imports System.Data.SqlClient
Imports DevExpress.Web
Imports System.Net
Imports MimeKit
Imports MailKit.Net.Smtp

Public Class Registration
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            HiddenField("ConfirmEmailCode") = ""
            HiddenField("ConfirmPhoneCode") = ""
            HiddenField("ConfirmEmailStatus") = "0"
            HiddenField("ConfirmPhoneStatus") = "0"
        End If

    End Sub

    Protected Sub RegistrationButton_Click(sender As Object, e As EventArgs)

        If Captcha.IsValid Then

            If HiddenField.Get("ConfirmEmailStatus") = "0" Then

                ErrorLabel.Text = "Подтвердите электронную почту!"

            Else

                Dim hash As String = GetHash.GetPasswordHash(PasswordTB.Text)

                Dim strHostName As String = Dns.GetHostName()
                Dim addresses As IPAddress() = Dns.GetHostEntry(strHostName).AddressList

                Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)
                Dim cmd As New SqlCommand("if @Email in (SELECT Email FROM [u1302649_sochifornia].[dbo].[Users])  
                                           begin 
                                                select 0,'Пользователь с указанной электронной почтой уже существует'
                                           end

                                           else if @Phone in (SELECT Phone FROM [u1302649_sochifornia].[dbo].[Users])
                                           begin 
                                                select 0,'Пользователь с указанным телефоном уже существует'
                                           end

                                           else
                                           begin
                                            
                                                declare @GUID uniqueidentifier = NEWID()
                                                insert into [u1302649_sochifornia].[dbo].[Users] (Email, Phone, LastName, FirstName, SecondName, BirthDate, Role, IP, Password, Status, EmailConfirm, PhoneConfirm)
                                                values (@Email, @Phone, @LastName, @FirstName, @SecondName, @BirthDate, 61, @IP, @Password, 64, @EmailConfirm, @PhoneConfirm)

                                                select 1, @GUID
                                           end   ", c)
                cmd.Parameters.AddWithValue("Email", LoginEmailTB.Text)
                cmd.Parameters.AddWithValue("Phone", "7" & PhoneTB.Text)
                cmd.Parameters.AddWithValue("LastName", LastNameTB.Text)
                cmd.Parameters.AddWithValue("FirstName", FirstNameTB.Text)
                cmd.Parameters.AddWithValue("SecondName", IIf(IsNothing(SecondNameTB.Value) = True, DBNull.Value, SecondNameTB.Text))
                cmd.Parameters.AddWithValue("BirthDate", BirthDateDE.Value)
                cmd.Parameters.AddWithValue("IP", addresses(1).ToString)
                cmd.Parameters.AddWithValue("Password", hash)
                cmd.Parameters.AddWithValue("EmailConfirm", CInt(HiddenField.Get("ConfirmEmailStatus")))
                cmd.Parameters.AddWithValue("PhoneConfirm", CInt(HiddenField.Get("ConfirmPhoneStatus")))
                c.Open()
                Dim res As Integer = 0
                Dim resString As String = ""
                Dim RDR As SqlDataReader
                RDR = cmd.ExecuteReader
                RDR.Read()
                If RDR.HasRows Then
                    res = CInt(RDR(0).ToString)
                    resString = RDR(1).ToString
                End If
                RDR.Close()
                c.Close()
                cmd.Dispose()
                c.Dispose()

                If res = 1 Then
                    Response.Redirect("~/Default.aspx")
                Else
                    ErrorLabel.Text = resString
                End If

            End If

        End If

    End Sub

    Protected Sub ConfirmCBack_Callback(source As Object, e As CallbackEventArgs)

        Dim prm As String() = e.Parameter.Split("|")

        ' Подтверждение электронной почты
        If prm(0) = "1" Then

            'Формирование пароля
            Dim pass As New StringBuilder
            Dim rnd As New Random

            For i = 0 To 5
                pass.Append(ChrW(rnd.Next(48, 58)))
            Next

            'Формирование и отправка письма
            Dim bld As New BodyBuilder()
            Dim message = New MimeMessage()
            message.From.Add(New MailboxAddress("Агентство недвижимости Sochifornia", "info@sochifornia.realty"))
            message.To.Add(New MailboxAddress(prm(1), prm(1)))

            message.Subject = "Подтверждение электронной почты"

            bld.TextBody = "Код для подтверждения электронной почты: " & pass.ToString & vbCrLf & vbCrLf & vbCrLf & "Письмо сформировано автоматически. Пожалуйста, не отвечайте на него."

            message.Body = bld.ToMessageBody()

            Try

                'Dim client = New SmtpClient()
                'client.Connect("smtp.mail.ru", 465, True)
                'client.Authenticate("info@sochifornia.realty", "Ii123456")
                'client.Send(message)
                'client.Disconnect(True)

                e.Result = "1|" & pass.ToString

            Catch ex As Exception

                e.Result = "0|" & ex.ToString

            End Try

        End If

    End Sub

End Class