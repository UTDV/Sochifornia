Public Class UsersList
    Inherits System.Web.UI.Page

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

                ' Если статус не Активный или Ролль не Админ
                If Session("Status") <> "64" Or Session("Role") <> "60" Then
                    Session("GUID") = Nothing
                    FormsAuthentication.SignOut()
                    Response.Redirect("~/Users/LoginUser.aspx")
                End If

            End If

        End If

    End Sub

End Class