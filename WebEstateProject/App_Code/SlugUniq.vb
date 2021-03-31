'Imports System.Data.SqlClient
Imports SlugGenerator

Public Class SlugUniq


    Public Shared Function GetSlug(Name As String, Type As SlugType, Dt As Int32) As String
        'Dim SlugStr As String = ""
        Dim SlgTxt As String = ""

        If Type = SlugType.PropertyObject Then
            SlgTxt = "Купить квартиру в Сочи вторичное недорого " + Name + " " + Dt.ToString
            SlgTxt = SlgTxt.GenerateSlug("-")
        ElseIf Type = SlugType.Post Then
            SlgTxt = Dt.ToString + " " + "Новости недвижимости в Сочи " + Name
            SlgTxt = SlgTxt.GenerateSlug("-")
        End If


        'Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)

        'If Type = SlugType.PropertyObject Then
        '    Dim cmd As New SqlCommand(" Select count(*) 
        '                            from [PropertyObjects]
        '                            where Slug = @Slug
        '                            ", c)
        '    cmd.Parameters.AddWithValue("Slug", SlgTxt)

        '    c.Open()
        '    Dim rdr = cmd.ExecuteScalar()

        '    If rdr = 1 Then

        '        SlugStr = SlugUniq.GetSlug(Name + " " + Now.Date.ToShortDateString, SlugType.PropertyObject)
        '    Else
        '        SlugStr = SlgTxt
        '    End If
        '    c.Close()
        '    cmd.Dispose()
        '    c.Dispose()
        'ElseIf Type = SlugType.Post Then

        '    Dim cmd As New SqlCommand(" Select count(*) 
        '                            from [Posts]
        '                            where Slug = @Slug
        '                            ", c)
        '    cmd.Parameters.AddWithValue("Slug", SlgTxt)

        '    c.Open()
        '    Dim rdr = cmd.ExecuteScalar()

        '    If rdr = 1 Then
        '        SlgTxt = +"-1"
        '        SlugStr = SlugUniq.GetSlug(SlgTxt, SlugType.Post)
        '    Else
        '        SlugStr = SlgTxt
        '    End If
        '    c.Close()
        '    cmd.Dispose()
        '    c.Dispose()
        'End If


        Return SlgTxt

    End Function
    Public Enum SlugType
        PropertyObject
        Post
    End Enum

End Class


