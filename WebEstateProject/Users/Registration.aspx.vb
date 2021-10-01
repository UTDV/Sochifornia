Imports System.Data.SqlClient
Imports DevExpress.Web
Imports System.Net
Imports MimeKit
Imports MailKit.Net.Smtp
Imports System.IO


Public Class Registration
    Inherits System.Web.UI.Page

    Public Shared ConfirmPhoneCode As String
    Public Shared ConfirmSMSCode As String
    Public Shared ConfirmPhoneStatus As String

    Public Shared ConfirmEmailCode As String
    Public Shared ConfirmEmailStatus As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

        End If

    End Sub

    Protected Sub RegistrationButton_Click(sender As Object, e As EventArgs)

        ErrorLabel.Text = ""

        If Captcha.IsValid Then

            If ConfirmEmailStatus <> LoginEmailTB.Text Then

                ErrorLabel.Text = "Подтвердите электронную почту!"

                If ConfirmPhoneStatus = PhoneTB.Value Then
                    ConfirmPhoneButton.Enabled = False
                    ConfirmPhoneButton.Text = "Телефон подтвержден"
                End If

            ElseIf ConfirmPhoneStatus <> PhoneTB.Value Then

                ErrorLabel.Text = "Подтвердите телефон!"

                If ConfirmEmailStatus = LoginEmailTB.Text Then
                    ConfirmEmailButton.Enabled = False
                    ConfirmEmailButton.Text = "e-mail подтвержден"
                End If

            Else

                Try

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
                                                insert into [u1302649_sochifornia].[dbo].[Users] (Email, Phone, LastName, FirstName, SecondName, BirthDate, Role, IP, Password, Status, EmailConfirm, PhoneConfirm, GUID, WhatsApp)
                                                values (@Email, @Phone, @LastName, @FirstName, @SecondName, @BirthDate, 61, @IP, @Password, 64, 1, 1, @GUID, @WhatsApp)

                                                select 1, @GUID
                                           end   ", c)
                    cmd.Parameters.AddWithValue("Email", LoginEmailTB.Text)
                    cmd.Parameters.AddWithValue("Phone", "7" & PhoneTB.Text)
                    cmd.Parameters.AddWithValue("WhatsApp", PhoneTB.Text)
                    cmd.Parameters.AddWithValue("LastName", LastNameTB.Text)
                    cmd.Parameters.AddWithValue("FirstName", FirstNameTB.Text)
                    cmd.Parameters.AddWithValue("SecondName", IIf(IsNothing(SecondNameTB.Value) = True, DBNull.Value, SecondNameTB.Text))
                    cmd.Parameters.AddWithValue("BirthDate", BirthDateDE.Value)
                    cmd.Parameters.AddWithValue("IP", addresses(1).ToString)
                    cmd.Parameters.AddWithValue("Password", hash)
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
                        'Session("GUID") = resString
                        'Session("Status") = "64"

                        Directory.CreateDirectory(MapPath("~\Content\UsersContent\" & resString))

                        Dim ticket As FormsAuthenticationTicket = New FormsAuthenticationTicket(1, resString, Now, Now.AddMinutes(FormsAuthentication.Timeout.TotalMinutes), False, "64|61" & "|" & FirstNameTB.Text & " " & LastNameTB.Text)
                        Dim encTicket As String = FormsAuthentication.Encrypt(ticket)
                        Response.Cookies.Add(New HttpCookie(FormsAuthentication.FormsCookieName, encTicket))


                        'FormsAuthentication.RedirectFromLoginPage(LoginEmailTB.Text, False)

                        Response.Redirect("~/PropertyRegister.aspx")
                    Else

                        If ConfirmPhoneStatus = PhoneTB.Value Then
                            ConfirmPhoneButton.Enabled = False
                            ConfirmPhoneButton.Text = "Телефон подтвержден"
                        End If

                        If ConfirmEmailStatus = LoginEmailTB.Text Then
                            ConfirmEmailButton.Enabled = False
                            ConfirmEmailButton.Text = "e-mail подтвержден"
                        End If

                        ErrorLabel.Text = resString

                    End If

                Catch ex As Exception

                    If ConfirmPhoneStatus = PhoneTB.Value Then
                        ConfirmPhoneButton.Enabled = False
                        ConfirmPhoneButton.Text = "Телефон подтвержден"
                    End If

                    If ConfirmEmailStatus = LoginEmailTB.Text Then
                        ConfirmEmailButton.Enabled = False
                        ConfirmEmailButton.Text = "e-mail подтвержден"
                    End If

                    ErrorLabel.Text = "Что-то пошло не так..."

                End Try

            End If

        Else

            If ConfirmPhoneStatus = PhoneTB.Value Then
                ConfirmPhoneButton.Enabled = False
                ConfirmPhoneButton.Text = "Телефон подтвержден"
            End If

            If ConfirmEmailStatus = LoginEmailTB.Text Then
                ConfirmEmailButton.Enabled = False
                ConfirmEmailButton.Text = "e-mail подтвержден"
            End If

        End If

    End Sub

    Protected Sub ConfirmCBack_Callback(source As Object, e As CallbackEventArgs)

        Dim prm As String() = e.Parameter.Split("|")

        ' Подтверждение электронной почты
        If prm(0) = "1" Then

            ''ТЕСТ
            'ConfirmEmailCode = GetHash.GetPasswordHash("123456")
            'e.Result = "1|"
            ''ТЕСТ

            'Формирование пароля
            Dim pass As New StringBuilder
            Dim rnd As New Random

            For i = 0 To 5
                pass.Append(ChrW(rnd.Next(48, 58)))
            Next

            'Формирование и отправка письма
            Dim bld As New BodyBuilder()
            Dim message = New MimeMessage()
            message.From.Add(New MailboxAddress("Агентство недвижимости Sochifornia", "noreply@sochifornia.realty"))
            message.To.Add(New MailboxAddress(prm(1), prm(1)))

            message.Subject = "Подтверждение электронной почты"

            bld.TextBody = "Код для подтверждения электронной почты: " & pass.ToString & vbCrLf & vbCrLf & vbCrLf & "Письмо сформировано автоматически. Пожалуйста, не отвечайте на него."

            message.Body = bld.ToMessageBody()

            Try

                Dim client = New SmtpClient()
                client.Connect("smtp.mail.ru", 465, True)
                client.Authenticate("noreply@sochifornia.realty", "S)ch1fornia")
                client.Send(message)
                client.Disconnect(True)

                'ConfirmEmailCode = pass.ToString
                ConfirmEmailCode = GetHash.GetPasswordHash(pass.ToString)

                e.Result = "1|"

            Catch ex As Exception

                e.Result = "0|Ошибка подтверждения электронной почты"

            End Try

        End If


        ' Подтверждение телефона по звонку
        If prm(0) = "2" Then

            ''ТЕСТ
            'ConfirmPhoneCode = GetHash.GetPasswordHash("123456")
            'e.Result = "2|"
            ''ТЕСТ

            'https://smsc.ru/api/http/status_messages/status_answer/#menu

            Dim PostData As String = "phones=7" & prm(1) & "&mes=code&call=1&fmt=2"

            Dim byteArray As Byte() = Encoding.UTF8.GetBytes(PostData)

            Dim request As HttpWebRequest = DirectCast(WebRequest.Create("https://smsc.ru/sys/send.php?login=it.sochi@rd-net.ru&psw=Admin32297044&" & PostData), HttpWebRequest)
            request.Method = "POST"
            request.ContentLength = byteArray.Length

            Try

                Dim dataStream As Stream = request.GetRequestStream()
                dataStream.Write(byteArray, 0, byteArray.Length)
                dataStream.Close()

                Dim response As HttpWebResponse = DirectCast(request.GetResponse(), HttpWebResponse)



                If response.StatusDescription = "OK" Then

                    dataStream = response.GetResponseStream()
                    Dim reader As New StreamReader(dataStream, Encoding.UTF8)
                    Dim ResponseFromServer As String = reader.ReadToEnd()
                    reader.Close()
                    dataStream.Close()
                    response.Close()

                    Dim phcode As XElement = XElement.Parse(ResponseFromServer)

                    Dim code As String = phcode.Descendants("code").Value

                    Dim err As String = phcode.Descendants("error_code").Value

                    If IsNothing(code) = True Then

                        If IsNothing(err) = True Then
                            e.Result = "0|Ошибка подтверждения телефона"
                        Else
                            e.Result = "0|Ошибка подтверждения телефона, код " & err.ToString
                        End If
                    Else

                        ConfirmPhoneCode = GetHash.GetPasswordHash(Right(code.ToString, 6))

                        e.Result = "2|"
                    End If

                End If



            Catch ex As Exception
                e.Result = "0|Ошибка подтверждения телефона"
            End Try

        End If


        ' Подтверждение телефона по СМС
        If prm(0) = "3" Then

            Dim rn = New Random

            Dim smscode As String = rn.Next(0, 9).ToString & rn.Next(0, 9).ToString & rn.Next(0, 9).ToString & rn.Next(0, 9).ToString


            ''ТЕСТ
            'Dim smscode As String = "1234"
            'ConfirmSMSCode = GetHash.GetPasswordHash(smscode)
            'e.Result = "3|"
            ''ТЕСТ


            Dim mes As String = "Регистрация Sochifornia. Код подтверждения телефона: " & smscode

            Dim PostData As String = "phones=7" & prm(1) & "&mes=" & mes & "&fmt=2"

            Dim byteArray As Byte() = Encoding.UTF8.GetBytes(PostData)

            Dim request As HttpWebRequest = DirectCast(WebRequest.Create("https://smsc.ru/sys/send.php?login=it.sochi@rd-net.ru&psw=Admin32297044&" & PostData), HttpWebRequest)
            request.Method = "POST"
            request.ContentLength = byteArray.Length

            Try

                Dim dataStream As Stream = request.GetRequestStream()
                dataStream.Write(byteArray, 0, byteArray.Length)
                dataStream.Close()

                Dim response As HttpWebResponse = DirectCast(request.GetResponse(), HttpWebResponse)

                If response.StatusDescription = "OK" Then

                    dataStream = response.GetResponseStream()
                    Dim reader As New StreamReader(dataStream, Encoding.UTF8)
                    Dim ResponseFromServer As String = reader.ReadToEnd()
                    reader.Close()
                    dataStream.Close()
                    response.Close()

                    Dim phcode As XElement = XElement.Parse(ResponseFromServer)

                    Dim err As String = phcode.Descendants("error_code").Value

                    If IsNothing(err) = False Then
                        'e.Result = "4|Ошибка отправки сообщения, код " & err.ToString
                        e.Result = "4|Ошибка отправки СМС"
                    Else

                        ConfirmSMSCode = GetHash.GetPasswordHash(smscode)

                        e.Result = "3|"

                    End If

                Else
                    'e.Result = "4|Ошибка отправки СМС. Статус: " & response.StatusDescription
                    e.Result = "4|Ошибка отправки СМС"
                End If

            Catch ex As Exception
                e.Result = "4|Ошибка отправки СМС"
            End Try

        End If

    End Sub

    Protected Sub CBackCheckCode_Callback(source As Object, e As CallbackEventArgs)

        Dim hashCheckCode As String = GetHash.GetPasswordHash(e.Parameter.Split("|")(1))

        If e.Parameter.Split("|")(0) = "PhoneCall" Then

            If hashCheckCode = ConfirmPhoneCode Then
                ConfirmPhoneStatus = PhoneTB.Value
                e.Result = "PhoneCall|1"
            Else
                ConfirmPhoneStatus = ""
                e.Result = "PhoneCall|0"
            End If

        ElseIf e.Parameter.Split("|")(0) = "PhoneSMS" Then

            If hashCheckCode = ConfirmSMSCode Then
                ConfirmPhoneStatus = PhoneTB.Value
                e.Result = "PhoneSMS|1"
            Else
                ConfirmPhoneStatus = ""
                e.Result = "PhoneSMS|0"
            End If

        ElseIf e.Parameter.Split("|")(0) = "Email" Then

            If hashCheckCode = ConfirmEmailCode Then
                ConfirmEmailStatus = LoginEmailTB.Text
                e.Result = "Email|1"
            Else
                ConfirmEmailStatus = ""
                e.Result = "Email|0"
            End If

        End If

    End Sub

End Class