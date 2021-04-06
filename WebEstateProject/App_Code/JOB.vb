
Imports System.Data.SqlClient



Public Class JOB

    Friend Shared Sub UpdateActualStatus()

        Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)
        Dim cmd As New SqlCommand("update [dbo].[PropertyObjects]
                                   set AdStatus = 76
                                   where ActualUntil < convert(date, getdate())
                                     and AdStatus = 73", c)
        c.Open()
        cmd.ExecuteNonQuery()
        c.Close()
        cmd.Dispose()

    End Sub

End Class
