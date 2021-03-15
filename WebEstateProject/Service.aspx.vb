Imports System.Data.SqlClient
Public Class Service
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)
        Dim c1 As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)
        Dim cmd As New SqlCommand(" Select ID, Name , Created
                                    from [PropertyObjects]
                                    
                                    ", c)


        c.Open()

        Dim rdr = cmd.ExecuteReader
        Dim id_ob As Int32 = 0
        Dim dt As Date
        Dim Slugstr As String = ""


        While rdr.Read
            dt = rdr.GetDateTime(2)
            id_ob = rdr.GetInt32(0)
            Slugstr = SlugUniq.GetSlug(rdr.GetString(1), SlugUniq.SlugType.PropertyObject, id_ob)

            Dim cmd1 As New SqlCommand(" update [PropertyObjects] 
                                            set Slug = @Slug
                                            where ID = @Id
                                    ", c1)

            cmd1.Parameters.AddWithValue("Slug", Slugstr)
            cmd1.Parameters.AddWithValue("Id", id_ob)
            c1.Open()
            cmd1.ExecuteNonQuery()
            c1.Close()
            cmd1.Dispose()

        End While



        c.Close()
        cmd.Dispose()
        c.Dispose()
        c1.Dispose()


    End Sub

End Class