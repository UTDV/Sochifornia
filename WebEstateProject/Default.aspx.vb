Imports DevExpress.Data
Imports System.Web.Security

Public Class _Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If (Not PropertyCardView.IsCallback) Then
            SetPropertyCardViewSorting("ByDate")
        End If

    End Sub

    Protected Sub ItemTextLabel_Init(sender As Object, e As EventArgs)

        Dim lb As DevExpress.Web.ASPxLabel = DirectCast(sender, DevExpress.Web.ASPxLabel)
        lb.Text = Eval("Type").ToString

    End Sub

    Private Sub SetPropertyCardViewSorting(ByVal sortPrm As String)

        PropertyCardView.ClearSort()

        Select Case sortPrm
            Case "ByDate"
                PropertyCardView.SortBy(PropertyCardView.Columns("LastUpdate"), ColumnSortOrder.Descending)
            Case "ByPriceAsc"
                PropertyCardView.SortBy(PropertyCardView.Columns("Price"), ColumnSortOrder.Ascending)
            Case "ByPriceDesc"
                PropertyCardView.SortBy(PropertyCardView.Columns("Price"), ColumnSortOrder.Descending)
        End Select

    End Sub

    Private Sub SetPropertyCardViewFiltering(ByVal FltrExpr As String)

        PropertyCardView.FilterExpression = FltrExpr

    End Sub

    Protected Sub PropertyCardView_CustomCallback(sender As Object, e As DevExpress.Web.ASPxCardViewCustomCallbackEventArgs)

        Dim data() As String = e.Parameters.Split("|")

        If data(0) = "filter" Then
            SetPropertyCardViewFiltering(data(1))
        End If

        If data(0) = "sort" Then
            SetPropertyCardViewSorting(data(1))
        End If


    End Sub

End Class