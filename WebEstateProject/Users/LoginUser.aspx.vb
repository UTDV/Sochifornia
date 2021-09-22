Imports System.Data.SqlClient
Imports MailKit.Net.Smtp
Imports MimeKit


Public Class Login1
    Inherits System.Web.UI.Page

    Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub LoginButton_Click(sender As Object, e As EventArgs)

        Dim hash As String = GetHash.GetPasswordHash(PasswordTB.Text)

        Dim cmd As New SqlCommand("SELECT [GUID], Status, Role, [FirstName] + ' ' + [LastName] as UserName
                                   FROM [u1302649_sochifornia].[dbo].[Users]
                                   where CONCAT(Email, Password) = CONCAT(@Email, @Password)  ", c)
        cmd.Parameters.AddWithValue("Email", LoginEmailTB.Text)
        cmd.Parameters.AddWithValue("Password", hash)
        c.Open()
        Dim res As Integer = 0
        Dim resString As String = ""
        Dim userstatus As String = ""
        Dim userrole As String = ""
        Dim username As String = ""
        Dim RDR As SqlDataReader
        RDR = cmd.ExecuteReader
        RDR.Read()
        If RDR.HasRows Then
            res = 1
            resString = RDR("GUID").ToString
            userstatus = RDR("Status").ToString
            userrole = RDR("Role").ToString
            username = RDR("UserName").ToString
        End If
        RDR.Close()
        c.Close()
        cmd.Dispose()
        c.Dispose()

        If res = 1 Then
            'Session("GUID") = resString
            'Session("Status") = userstatus

            Dim ticket As FormsAuthenticationTicket = New FormsAuthenticationTicket(1, resString, Now, Now.AddMinutes(FormsAuthentication.Timeout.TotalMinutes), False, userstatus & "|" & userrole & "|" & username)
            Dim encTicket As String = FormsAuthentication.Encrypt(ticket)
            Response.Cookies.Add(New HttpCookie(FormsAuthentication.FormsCookieName, encTicket))

            'FormsAuthentication.RedirectFromLoginPage(LoginEmailTB.Text, False)
            'Response.Redirect(FormsAuthentication.GetRedirectUrl(LoginEmailTB.Text, False))
            Response.Redirect("~/PropertyRegister.aspx")
        Else
            ErrorLabel.Text = "Неверный логин или пароль"
        End If


    End Sub

    Protected Sub CBackNewPassword_Callback(source As Object, e As DevExpress.Web.CallbackEventArgs)

        If Captcha.IsValid Then

            Try

                'Проверка данных

                Dim ContactString As String = ""
                If e.Parameter = "0" Then
                    ContactString = NewPasswordEmailTB.Text
                Else
                    ContactString = "7" & NewPasswordSMSTB.Value
                End If

                Dim cmd As New SqlCommand("declare @cnt int

                                            if @Type = 0
                                            begin
	                                            select @cnt = count(*)
	                                            FROM [dbo].[Users]
	                                            where Role in (60,61)
	                                                and Status = 64
	                                                and Email = @Contact
                                            END
                                            ELSE
                                            BEGIN
	                                            select @cnt = count(*)
	                                            FROM [dbo].[Users]
	                                            where Role in (60,61)
	                                                and Status = 64
	                                                and Phone = @Contact
                                            END

                                            if @cnt = 0 select '0|Пользователь не найден'

                                            else if @cnt = 1
                                            begin
	                                            if @Type = 0
	                                            begin
		                                            select CONCAT('1|', GUID, '|', id)
		                                            FROM [dbo].[Users]
		                                            where Role in (60,61)
			                                            and Status = 64
			                                            and Email = @Contact
	                                            END
	                                            ELSE
	                                            BEGIN
		                                            select CONCAT('1|', GUID, '|', id)
		                                            FROM [dbo].[Users]
		                                            where Role in (60,61)
			                                            and Status = 64
			                                            and Phone = @Contact
	                                            END
                                            end

                                            else if @cnt > 1 select '0|Найдено несколько пользователей'

                                            ", c)
                cmd.Parameters.AddWithValue("Type", e.Parameter)
                cmd.Parameters.AddWithValue("Contact", ContactString)
                c.Open()
                Dim CheckString As String = cmd.ExecuteScalar.ToString
                c.Close()
                cmd.Dispose()

                If CheckString.Split("|")(0) = "0" Then

                    e.Result = CheckString

                ElseIf CheckString.Split("|")(0) = "1" Then

                    e.Result = NewPassword(CInt(e.Parameter), CheckString.Split("|")(1), CInt(CheckString.Split("|")(2)), ContactString)

                Else
                    e.Result = "0|Что-то пошло не так"
                End If


            Catch ex As Exception
                e.Result = "0|Что-то пошло не так"
            End Try

        Else

            e.Result = "0|Неверный код"

        End If

    End Sub


    Private Function NewPassword(ByVal Type As Integer, ByVal Creator As String, UserID As Integer, ByVal Contact As String)

        'Dim checkCode As String = ""
        Dim res As String = "0|"

        'ОТПРАВКА ССЫЛКИ НА ПОЧТУ
        If Type = 0 Then

            Dim g As Guid
            g = Guid.NewGuid
            'checkCode = g.ToString

            Dim path As String = "https://Sochifornia.realty/Users/Password.aspx?type=1&id=" & g.ToString

            'Dim path As String = "https://localhost:44386/Users/Password.aspx?type=1&id=" & g.ToString

            Try

                Dim cmd As New SqlCommand("insert into [dbo].[UsersMetaData] ([Creator], [UserID], [MetaNameID], [MetaData])
                                       values (@Creator, @UserID, 89, @MetaData)", c)
                cmd.Parameters.AddWithValue("Creator", Creator)
                cmd.Parameters.AddWithValue("UserID", UserID)
                cmd.Parameters.AddWithValue("MetaData", g.ToString)
                c.Open()
                cmd.ExecuteNonQuery()
                c.Close()
                cmd.Dispose()


                Dim bld As New BodyBuilder()
                Dim message = New MimeMessage()
                message.From.Add(New MailboxAddress("Система уведомлений Sochifornia", "noreply@sochifornia.realty"))
                message.To.Add(New MailboxAddress(Contact, Contact))

                message.Subject = "Восстановление пароля"

                bld.HtmlBody = "<br/>Для восстановления пароля Sochifornia.realty пройдите по ссылке: <br/><br/>" & "<a href=" & path + "> ССЫЛКА ДЛЯ ВОССТАНОВЛЕНИЯ ПАРОЛЯ </a>" _
                    & "<br/><br/> Письмо сформировано автоматически, не отвечайте на него."

                message.Body = bld.ToMessageBody()

                Dim client = New SmtpClient()
                client.Connect("smtp.mail.ru", 465, True)
                client.Authenticate("noreply@sochifornia.realty", "S)ch1fornia")
                client.Send(message)
                client.Disconnect(True)

                res = "1|Ссылка для восстановления пароля отправлена на почту " & Contact

            Catch ex As Exception
                res = "0|Что-то пошло не так..."
            End Try
        End If
        Return res

    End Function

End Class