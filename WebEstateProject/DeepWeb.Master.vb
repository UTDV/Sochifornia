Imports System.Data.SqlClient

Public Class DeepWeb
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Request.Path.ToLower = "/users/loginuser.aspx" Or Request.Path.ToLower = "/users/registration.aspx" Then

            LKMenu.Visible = False

        Else


            If Session("GUID") Is Nothing Then


                LKMenu.Items.FindByName("LK").Visible = False
                LKMenu.Items.FindByName("AuthorizationBtn").Visible = True

            Else

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


                LKMenu.Items.FindByName("LK").Visible = True
                LKMenu.Items.FindByName("AuthorizationBtn").Visible = False
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
End Class