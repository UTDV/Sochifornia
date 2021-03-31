Imports System.IO
Imports System.Data.SqlClient
Imports System.Net

Public Class Site1
    Inherits System.Web.UI.MasterPage


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)
        Dim rp = Request.Path.ToLower

        'записываем ГИД в КУки, чтобы определять Пользака
        If Request.Cookies("G_S") Is Nothing Then
            Dim nc As New HttpCookie("G_S")
            Dim g As Guid
            g = Guid.NewGuid

            nc.Value = Net.WebUtility.UrlEncode(g.ToString)
            nc.Expires = DateAdd(DateInterval.Year, 20, Now)
            Response.Cookies.Add(nc)
        Else

            If rp.Contains("object/") Then
                Dim pos As Int32 = 0
                While rp.IndexOf("-", pos + 1) <> -1
                    pos = rp.IndexOf("-", pos + 1)
                End While
                Dim id = rp.Substring(pos + 1, rp.Length - (pos + 1))



                Dim cmd1 As New SqlCommand("INSERT INTO [dbo].[ViewsCount]
                                                   ([IP],
                                                   [ObjectGUID]
                                                   ,[UserGUID])
                                             VALUES
                                                   (@IP,
                                                   (select guid from PropertyObjects where id = @ID)
                                                   ,@UserGUID)", c)
                cmd1.Parameters.AddWithValue("IP", Request.Cookies("sfIP").Value)
                cmd1.Parameters.AddWithValue("ID", id)
                cmd1.Parameters.AddWithValue("UserGUID", WebUtility.UrlDecode(Request.Cookies("G_S").Value))
                c.Open()
                cmd1.ExecuteNonQuery()
                c.Close()
                cmd1.Dispose()


            End If
        End If




        If rp = "/users/loginuser.aspx" Or rp = "/users/registration.aspx" Then

            'AuthorizationButton.Visible = False
            LKMenu.Visible = False

        Else

            If rp = "/propertyregister.aspx" Or rp = "/users/userslist.aspx" Then
                BottomPanel.Visible = False
            End If

            If rp.Contains("object/") And Request.Browser.IsMobileDevice = False Then
                LKMenu.Items.FindByName("PrintBtn").Visible = True
            End If


            If Request.IsAuthenticated = False Then
                'AuthorizationButton.Visible = True
                'LKMenu.Visible = False

                LKMenu.Items.FindByName("LK").Visible = False
                LKMenu.Items.FindByName("AuthorizationBtn").Visible = True

            Else

                ' Получаем данные Identity
                Dim id As FormsIdentity = CType(Page.User.Identity, FormsIdentity)
                Dim ticket As FormsAuthenticationTicket = id.Ticket

                ' Получаем актуальные данные пользователя из БД


                Dim cmd As New SqlCommand("select Status, Role, [FirstName] + ' ' + [LastName] as UserName from [dbo].[Users] where GUID = @GUID", c)
                cmd.Parameters.AddWithValue("GUID", ticket.Name.ToString)
                c.Open()
                Dim userStatus As String = ""
                Dim userRole As String = ""
                Dim userName As String = ""
                Dim RDR As SqlDataReader
                RDR = cmd.ExecuteReader
                RDR.Read()
                If RDR.HasRows Then
                    userStatus = RDR("Status").ToString
                    userRole = RDR("Role").ToString
                    userName = RDR("UserName").ToString
                End If
                RDR.Close()
                c.Close()
                cmd.Dispose()


                'AuthorizationButton.Visible = False
                'LKMenu.Visible = True

                'Обновляем ticket
                Dim cookie As HttpCookie = FormsAuthentication.GetAuthCookie(ticket.Name, True)
                Dim newticket As FormsAuthenticationTicket = New FormsAuthenticationTicket(ticket.Version, ticket.Name, ticket.IssueDate, ticket.Expiration, True, userStatus & "|" & userRole & "|" & userName, ticket.CookiePath)
                cookie.Value = FormsAuthentication.Encrypt(newticket)
                cookie.Expires = newticket.Expiration.AddMinutes(120)
                Response.Cookies.Set(cookie)

                'Обновляем сессии (?)
                Session("Status") = userStatus
                Session("Role") = userRole
                Session("UserName") = userName
                Session("UserGUID") = ticket.Name.ToUpper


                'Рисуем меню
                LKMenu.Items.FindByName("LK").Visible = True
                LKMenu.Items.FindByName("AuthorizationBtn").Visible = False
                LKMenu.Items.FindByName("LK").Text = userName

                If userRole = "60" Then
                    LKMenu.Items.FindByName("UsersList").Visible = True
                End If

            End If

        End If


    End Sub


    Protected Sub CBack_Callback(source As Object, e As DevExpress.Web.CallbackEventArgs)

        Session("GUID") = Nothing
        FormsAuthentication.SignOut()

    End Sub






End Class