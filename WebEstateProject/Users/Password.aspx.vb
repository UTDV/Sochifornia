Imports System.Data.SqlClient


Public Class Password
    Inherits System.Web.UI.Page

    Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Request.QueryString("type") Is Nothing Then
            Response.Redirect("~/Default.aspx")
        End If

        If Not IsPostBack Then

            'Смена пароля через ЛК
            If Request.QueryString("type") = "0" Then

                If Request.IsAuthenticated = False Then

                    Response.Redirect("~/Users/LoginUser.aspx")

                Else

                    Dim id As FormsIdentity = CType(User.Identity, FormsIdentity)
                    Dim ticket As FormsAuthenticationTicket = id.Ticket
                    Dim userData As String() = ticket.UserData.Split("|")

                    Session("GUID") = ticket.Name
                    Session("Status") = userData(0)
                    Session("Role") = userData(1)

                    ' Если статус не Активный или Роль не Админ
                    If Session("Status") <> "64" Or Session("Role") <> "60" Then
                        Session("GUID") = Nothing
                        FormsAuthentication.SignOut()
                        Response.Redirect("~/Users/LoginUser.aspx")

                    Else

                        Page.Title = "Изменение пароля"
                        InfoLabel.Text = "Изменение пароля пользователя. Страница в разработке."
                        ChangePasswordForm.Visible = False

                    End If

                End If

                'Восстановление пароля через почту
            ElseIf Request.QueryString("type") = "1" Then

                If Request.QueryString("id") Is Nothing Then

                    Response.Redirect("~/Default.aspx")

                Else

                    Page.Title = "Восстановление пароля"

                    Try

                        Dim cmd As New SqlCommand("declare @Created datetime, @isChanged int

                                                    SELECT @Created = [Created], @isChanged = isPasswordChanged
                                                    FROM [dbo].[UsersMetaData] 
                                                    where [MetaNameID] = 89  and [MetaData] = @id 

                                                    if @Created is null select '0|Некорректная ссылка'

                                                    if @isChanged = 1 select '0|Ссылка на восстановление пароля недействительна'

                                                    else if @Created > DATEADD(d, 1, getdate())  select '0|Истек срок действия ссылки для восстановления пароля'

                                                    else select '1|'", c)
                        cmd.Parameters.AddWithValue("id", Request.QueryString("id"))
                        c.Open()
                        Dim CheckResult As String = cmd.ExecuteScalar.ToString
                        c.Close()
                        cmd.Dispose()

                        If CheckResult.Split("|")(0) = "0" Then
                            InfoLabel.Text = CheckResult.Split("|")(1)
                            ChangePasswordForm.Visible = False
                        Else
                            InfoLabel.Visible = False
                            ChangePasswordForm.Visible = True
                            ChangePasswordForm.FindItemOrGroupByName("group").Caption = "Восстановление пароля"
                        End If

                    Catch ex As Exception

                        InfoLabel.Text = "Ошибка восстановления пароля"
                        ChangePasswordForm.Visible = False

                    End Try

                End If

            End If

        End If

    End Sub



    Protected Sub CBackChangePassword_Callback(source As Object, e As DevExpress.Web.CallbackEventArgs)

        Dim hashPassword As String = GetHash.GetPasswordHash(PasswordOneTB.Text)

        Try

            Dim cmd As New SqlCommand("update [dbo].Users
                                       set Password = @Password
                                       where id = (select UserID from [dbo].[UsersMetaData] where MetaData = @id)

                                            update [dbo].[UsersMetaData]
                                            set isPasswordChanged = 1
                                            where MetaData = @id
                                       ", c)
            cmd.Parameters.AddWithValue("Password", hashPassword)
            cmd.Parameters.AddWithValue("id", Request.QueryString("id"))
            c.Open()
            cmd.ExecuteNonQuery()
            c.Close()
            cmd.Dispose()

            e.Result = "1"

        Catch ex As Exception
            e.Result = "0"
        End Try

    End Sub

End Class