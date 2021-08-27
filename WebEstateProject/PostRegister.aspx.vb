Imports System.Data.SqlClient

Public Class PostRegister
    Inherits System.Web.UI.Page

    Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then


            If Request.IsAuthenticated = False Then

                Response.Redirect("~/Users/LoginUser.aspx")

            Else

                Dim id As FormsIdentity = CType(User.Identity, FormsIdentity)
                Dim ticket As FormsAuthenticationTicket = id.Ticket
                Dim userData As String() = ticket.UserData.Split("|")

                Session("GUID") = ticket.Name
                Session("Status") = userData(0)
                Session("Role") = userData(1)


                ' Если статус не Активный
                If Session("Status") <> "64" Then
                    Session("GUID") = Nothing
                    FormsAuthentication.SignOut()
                    Response.Redirect("~/Users/LoginUser.aspx")
                End If

            End If



        End If
    End Sub

    Protected Sub CBackView_Callback(source As Object, e As DevExpress.Web.CallbackEventArgs)

        Try

            Dim cmd As New SqlCommand("select Slug from [dbo].[Posts] where ID = @ID", c)
            cmd.Parameters.AddWithValue("ID", e.Parameter)
            c.Open()
            Dim res As String = cmd.ExecuteScalar.ToString
            c.Close()
            cmd.Dispose()

            If res = "" Then
                e.Result = "noslug"
            Else
                e.Result = res
            End If

        Catch ex As Exception
            e.Result = "error"
        End Try

    End Sub

End Class