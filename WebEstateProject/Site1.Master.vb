Imports System.IO
Imports System.Data.SqlClient

Public Class Site1
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Request.Path.ToLower = "/users/loginuser.aspx" Or Request.Path.ToLower = "/users/registration.aspx" Then

            AuthorizationButton.Visible = False
            LKMenu.Visible = False
            'BottomForm.FindItemOrGroupByName("PropertyRegisterButtonItem").Visible = False

        Else

            If Request.Path.ToLower = "/propertyregister.aspx" Or Request.Path.ToLower = "/users/userslist.aspx" Then
                BottomPanel.Visible = False
            End If

            'If Request.IsAuthenticated Then
            '    AuthorizationButton.Visible = False
            '    ExitButton.Visible = True
            '    BottomForm.FindItemOrGroupByName("PropertyRegisterButtonItem").Visible = True
            'Else
            '    AuthorizationButton.Visible = True
            '    ExitButton.Visible = False
            '    BottomForm.FindItemOrGroupByName("PropertyRegisterButtonItem").Visible = False
            'End If

            If Session("GUID") Is Nothing Then
                AuthorizationButton.Visible = True
                LKMenu.Visible = False
                'BottomForm.FindItemOrGroupByName("PropertyRegisterButtonItem").Visible = False
            Else

                'BottomForm.FindItemOrGroupByName("PropertyRegisterButtonItem").Visible = True

                Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)

                Dim cmd As New SqlCommand("select Status, Role, [FirstName] + ' ' + [LastName] as UserName from [dbo].[Users] where GUID = @GUID", c)
                cmd.Parameters.AddWithValue("GUID", Session("GUID").ToString)
                c.Open()
                Dim RDR As SqlDataReader
                RDR = cmd.ExecuteReader
                RDR.Read()
                If RDR.HasRows Then
                    Session("Status") = RDR("Status").ToString
                    Session("Role") = RDR("Role").ToString
                    Session("UserName") = RDR("UserName").ToString
                End If
                RDR.Close()
                c.Close()
                cmd.Dispose()
                c.Dispose()

                AuthorizationButton.Visible = False
                LKMenu.Visible = True
                LKMenu.Items.FindByName("LK").Text = Session("UserName").ToString

                If Session("Role").ToString = "60" Then
                    LKMenu.Items.FindByName("UsersList").Visible = True
                End If

            End If

        End If



    End Sub


    Protected Sub CBack_Callback(source As Object, e As DevExpress.Web.CallbackEventArgs)

        Session("GUID") = Nothing

    End Sub

    'Protected Sub ExitButton_Click(sender As Object, e As EventArgs)
    '    FormsAuthentication.SignOut()
    '    Response.Redirect("Default.aspx")
    'End Sub



End Class