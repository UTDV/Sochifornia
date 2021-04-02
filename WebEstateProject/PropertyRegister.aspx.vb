Imports System.Data.SqlClient
Imports System.IO
Imports DevExpress
Imports System.Drawing
Imports System.Drawing.Imaging
Imports DevExpress.Web
Imports System.Drawing.Text
Imports System.Drawing.Drawing2D




Public Class PropertyRegister
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

                ' Если статус не Активный
                If Session("Status") <> "64" Then
                    Session("GUID") = Nothing
                    FormsAuthentication.SignOut()
                    Response.Redirect("~/Users/LoginUser.aspx")
                End If

            End If



            'If Session("GUID") Is Nothing Or Session("Status") <> "64" Then
            '    Response.Redirect("~/Users/LoginUser.aspx")
            'End If
        End If

    End Sub

    'Protected Sub PropertyRegisterGrid_RowInserting(sender As Object, e As DevExpress.Web.Data.ASPxDataInsertingEventArgs)

    '    If e.NewValues.Item("ActualUntil") Is Nothing Then
    '        e.NewValues("ActualUntil") = DateAdd(DateInterval.Month, 1, Now())
    '    End If


    '    Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)

    '    Dim cmd As New SqlCommand("insert into [dbo].[PropertyObjects] (Creator, Name, Type, Complex, District, Street, Rooms, ApartmentArea, LandArea, Floor, TotalFloor, Status,
    '								Condition, Registration, WindowView, Stove, Ipoteka, ToSea, Sale, Description, VIP, ElitProperty, ActualUntil, Hide, LastUpdate, Posrednik, Comission)
    '                               values (@Creator, @Name, @Type, @Complex, @District, @Street, @RoomsNumber, @ApartmentArea, @LandArea, @Floor, @TotalFloor, @Status, @Condition, @Registration, 
    '                                       @WindowView, @Stove, isnull(@Ipoteka,0), @ToSea, isnull(@Sale,0), @Description, isnull(@VIP,0), isnull(@ElitProperty,0), @ActualUntil, isnull(@Hide,0)
    '                                        , getdate(), @Posrednik, @Comission)

    '                               declare @ID int = IDENT_CURRENT('[dbo].[PropertyObjects]')

    '                               insert into [dbo].[PropertyObjectsMetaData] (Creator, ObjectID, MetaNameID, MetaData)
    '                               values (@Creator, @ID, 54, @Price) 

    '                               select @ID", c)
    '    cmd.Parameters.AddWithValue("Creator", Session("GUID").ToString)
    '    cmd.Parameters.AddWithValue("Name", e.NewValues("Name"))
    '    cmd.Parameters.AddWithValue("Type", e.NewValues("Type"))
    '    cmd.Parameters.AddWithValue("Complex", IIf(e.NewValues("Complex") = Nothing, DBNull.Value, e.NewValues("Complex")))
    '    cmd.Parameters.AddWithValue("District", e.NewValues("District"))
    '    cmd.Parameters.AddWithValue("Street", IIf(e.NewValues("Street") = Nothing, DBNull.Value, e.NewValues("Street")))
    '    cmd.Parameters.AddWithValue("RoomsNumber", IIf(e.NewValues("RoomsNumber") = Nothing, DBNull.Value, e.NewValues("RoomsNumber")))
    '    cmd.Parameters.AddWithValue("ApartmentArea", e.NewValues("ApartmentArea"))
    '    cmd.Parameters.AddWithValue("LandArea", IIf(e.NewValues("LandArea") = Nothing, DBNull.Value, e.NewValues("LandArea")))
    '    cmd.Parameters.AddWithValue("Floor", IIf(e.NewValues("Floor") = Nothing, DBNull.Value, e.NewValues("Floor")))
    '    cmd.Parameters.AddWithValue("TotalFloor", IIf(e.NewValues("TotalFloor") = Nothing, DBNull.Value, e.NewValues("TotalFloor")))
    '    cmd.Parameters.AddWithValue("Status", e.NewValues("Status"))
    '    cmd.Parameters.AddWithValue("Condition", e.NewValues("Condition"))
    '    cmd.Parameters.AddWithValue("Registration", e.NewValues("Registration"))
    '    cmd.Parameters.AddWithValue("WindowView", IIf(e.NewValues("WindowView") = Nothing, DBNull.Value, e.NewValues("WindowView")))
    '    cmd.Parameters.AddWithValue("Stove", IIf(e.NewValues("Stove") = Nothing, DBNull.Value, e.NewValues("Stove")))
    '    cmd.Parameters.AddWithValue("Ipoteka", IIf(e.NewValues("Ipoteka") = Nothing, DBNull.Value, e.NewValues("Ipoteka")))
    '    cmd.Parameters.AddWithValue("ToSea", IIf(e.NewValues("ToSea") = Nothing, DBNull.Value, e.NewValues("ToSea")))
    '    cmd.Parameters.AddWithValue("Sale", IIf(e.NewValues("Sale") = Nothing, DBNull.Value, e.NewValues("Sale")))
    '    cmd.Parameters.AddWithValue("Description", e.NewValues("Description"))
    '    cmd.Parameters.AddWithValue("VIP", IIf(e.NewValues("VIP") = Nothing, DBNull.Value, e.NewValues("VIP")))
    '    cmd.Parameters.AddWithValue("ElitProperty", IIf(e.NewValues("ElitProperty") = Nothing, DBNull.Value, e.NewValues("ElitProperty")))
    '    cmd.Parameters.AddWithValue("ActualUntil", IIf(e.NewValues("ActualUntil") = Nothing, DBNull.Value, e.NewValues("ActualUntil")))
    '    cmd.Parameters.AddWithValue("Hide", IIf(e.NewValues("Hide") = Nothing, DBNull.Value, e.NewValues("Hide")))
    '    cmd.Parameters.AddWithValue("Price", e.NewValues("Price"))
    '    cmd.Parameters.AddWithValue("Posrednik", IIf(e.NewValues("Posrednik") = Nothing, DBNull.Value, e.NewValues("Posrednik")))
    '    cmd.Parameters.AddWithValue("Comission", IIf(e.NewValues("Comission") = Nothing, DBNull.Value, e.NewValues("Comission")))

    '    c.Open()
    '    Dim PropertyID = cmd.ExecuteScalar
    '    c.Close()
    '    cmd.Dispose()


    '    Directory.CreateDirectory(MapPath("~\Content\Foto\" & PropertyID.ToString))

    '    'здесь добавлени friendly url
    '    'Dim Nm As String =

    '    Dim slugTxt As String = SlugUniq.GetSlug(e.NewValues("Name"), SlugUniq.SlugType.PropertyObject, PropertyID)

    '    Dim cmd1 As New SqlCommand("update PropertyObjects
    '                                set slug = @Slug
    '                                where id = @id", c)
    '    cmd1.Parameters.AddWithValue("Slug", slugTxt)
    '    cmd1.Parameters.AddWithValue("id", PropertyID)
    '    c.Open()
    '    cmd1.ExecuteNonQuery()
    '    c.Close()
    '    cmd1.Dispose()
    '    c.Dispose()
    '    '-----------------
    'End Sub

    'Protected Sub PropertyRegisterGrid_RowUpdating(sender As Object, e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs)
    '    Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)
    '    'здесь добавление slug
    '    Dim slugTxt As String = SlugUniq.GetSlug(e.NewValues("Name"), SlugUniq.SlugType.PropertyObject, e.Keys.Values(0))

    '    '-----------------
    '    Dim ChgPrice = CInt(e.OldValues("Price").ToString = e.NewValues("Price").ToString)

    '    Dim cmd As New SqlCommand(" update [dbo].[PropertyObjects]
    '                                set Name = @Name,
    '                                    Type = @Type,
    '                                    Complex = @Complex,
    '                                    District = @District,
    '                                    Street = @Street,
    '                                    Rooms = @Rooms,
    '                                    ApartmentArea = @ApartmentArea,
    '                                    LandArea = @LandArea,
    '                                    Floor = @Floor,
    '                                    TotalFloor = @TotalFloor,
    '                                    Status = @Status,
    '                                    Condition = @Condition,
    '                                    Registration = @Registration,
    '                                    WindowView = @WindowView,
    '                                    Stove = @Stove,
    '                                    Ipoteka = @Ipoteka,
    '                                    ToSea = @ToSea,
    '                                    Sale = @Sale,
    '                                    Description = @Description,
    '                                    VIP = @VIP,
    '                                    ElitProperty = @ElitProperty,
    '                                    ActualUntil = @ActualUntil,
    '                                    Hide = @Hide,
    '                                    LastUpdate = getdate(),
    '                                    Slug = @Slug,
    '                                    Posrednik = @Posrednik,
    '                                    Comission = @Comission
    '                                where ID = @ID

    '                                if @ChgPrice = 0
    '                                begin
    '                                    insert into [dbo].[PropertyObjectsMetaData] (Creator, ObjectID, MetaNameID, MetaData)
    '                                    values (@Creator, @ID, 54, @Price)
    '                                end
    '                                ", c)
    '    cmd.Parameters.AddWithValue("Creator", Session("GUID").ToString)
    '    cmd.Parameters.AddWithValue("ID", e.Keys.Values(0))
    '    cmd.Parameters.AddWithValue("Name", e.NewValues("Name"))
    '    cmd.Parameters.AddWithValue("Type", e.NewValues("Type"))
    '    cmd.Parameters.AddWithValue("Complex", IIf(e.NewValues("Complex") = Nothing, DBNull.Value, e.NewValues("Complex")))
    '    cmd.Parameters.AddWithValue("District", e.NewValues("District"))
    '    cmd.Parameters.AddWithValue("Street", IIf(e.NewValues("Street") = Nothing, DBNull.Value, e.NewValues("Street")))
    '    cmd.Parameters.AddWithValue("Rooms", IIf(e.NewValues("RoomsNumber") = Nothing, DBNull.Value, e.NewValues("RoomsNumber")))
    '    cmd.Parameters.AddWithValue("ApartmentArea", e.NewValues("ApartmentArea"))
    '    cmd.Parameters.AddWithValue("LandArea", IIf(e.NewValues("LandArea") = Nothing, DBNull.Value, e.NewValues("LandArea")))
    '    cmd.Parameters.AddWithValue("Floor", IIf(e.NewValues("Floor") = Nothing, DBNull.Value, e.NewValues("Floor")))
    '    cmd.Parameters.AddWithValue("TotalFloor", IIf(e.NewValues("TotalFloor") = Nothing, DBNull.Value, e.NewValues("TotalFloor")))
    '    cmd.Parameters.AddWithValue("Status", e.NewValues("Status"))
    '    cmd.Parameters.AddWithValue("Condition", e.NewValues("Condition"))
    '    cmd.Parameters.AddWithValue("Registration", e.NewValues("Registration"))
    '    cmd.Parameters.AddWithValue("WindowView", IIf(e.NewValues("WindowView") = Nothing, DBNull.Value, e.NewValues("WindowView")))
    '    cmd.Parameters.AddWithValue("Stove", IIf(e.NewValues("Stove") = Nothing, DBNull.Value, e.NewValues("Stove")))
    '    cmd.Parameters.AddWithValue("Ipoteka", e.NewValues("Ipoteka"))
    '    cmd.Parameters.AddWithValue("ToSea", IIf(e.NewValues("ToSea") = Nothing, DBNull.Value, e.NewValues("ToSea")))
    '    cmd.Parameters.AddWithValue("Sale", e.NewValues("Sale"))
    '    cmd.Parameters.AddWithValue("Description", e.NewValues("Description"))
    '    cmd.Parameters.AddWithValue("VIP", e.NewValues("VIP"))
    '    cmd.Parameters.AddWithValue("ElitProperty", e.NewValues("ElitProperty"))
    '    cmd.Parameters.AddWithValue("ActualUntil", IIf(e.NewValues("ActualUntil") = Nothing, DBNull.Value, e.NewValues("ActualUntil")))
    '    cmd.Parameters.AddWithValue("Hide", e.NewValues("Hide"))
    '    cmd.Parameters.AddWithValue("Price", e.NewValues("Price"))
    '    cmd.Parameters.AddWithValue("ChgPrice", ChgPrice)
    '    cmd.Parameters.AddWithValue("Slug", slugTxt)
    '    cmd.Parameters.AddWithValue("Posrednik", IIf(e.NewValues("Posrednik") = Nothing, DBNull.Value,e.NewValues("Posrednik")))
    '    cmd.Parameters.AddWithValue("Comission", IIf(e.NewValues("Comission") = Nothing, DBNull.Value, e.NewValues("Comission")))

    '    c.Open()
    '    cmd.ExecuteNonQuery()
    '    c.Close()
    '    cmd.Dispose()
    '    c.Dispose()

    'End Sub



    'Чистим Content при удалении объекта
    Protected Sub PropertyRegisterGrid_RowDeleted(sender As Object, e As Web.Data.ASPxDataDeletedEventArgs)

        If Directory.Exists(MapPath("~\Content\Thumb\ImageGalleryThumb\" & e.Values("ID").ToString)) Then

            Directory.Delete(MapPath("~\Content\Thumb\ImageGalleryThumb\" & e.Values("ID").ToString), True)

        End If

        Directory.Delete(MapPath("~\Content\Foto\" & e.Values("ID").ToString), True)

    End Sub



    'Создание нового объекта
    Protected Sub CBackCreateNewObject_Callback(source As Object, e As CallbackEventArgs)

        Try

            Dim g As Guid
            g = Guid.NewGuid()

            Dim c As New SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)

            Dim cmd As New SqlCommand("insert into [dbo].[PropertyObjects] (Creator, GUID, Ipoteka, Sale, VIP, ElitProperty, Hide, LastUpdate, ActualUntil)
                                   values (@Creator, @GUID, 0, 0, 0, 0, 0, getdate(), convert(date, dateadd(m, 1, getdate())))

                                   select ID from [dbo].[PropertyObjects] where GUID = @GUID
                                   ", c)
            cmd.Parameters.AddWithValue("Creator", Session("GUID").ToString)
            cmd.Parameters.AddWithValue("GUID", g)
            c.Open()
            Dim PropertyID = cmd.ExecuteScalar
            c.Close()
            cmd.Dispose()

            Directory.CreateDirectory(MapPath("~\Content\Foto\" & PropertyID.ToString))

            e.Result = "1|" & PropertyID.ToString

        Catch ex As Exception
            e.Result = "0"
        End Try



    End Sub






End Class