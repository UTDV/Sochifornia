﻿Imports System.IO
Imports System.Data.SqlClient


Public Class Site1
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Request.Path.ToLower = "/users/loginuser.aspx" Or Request.Path.ToLower = "/users/registration.aspx" Then

            'AuthorizationButton.Visible = False
            LKMenu.Visible = False

        Else

            If Request.Path.ToLower = "/propertyregister.aspx" Or Request.Path.ToLower = "/users/userslist.aspx" Then
                BottomPanel.Visible = False
            End If

            If Request.Path.Contains("object/") And Request.Browser.IsMobileDevice = False Then
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
                Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)

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
                c.Dispose()

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