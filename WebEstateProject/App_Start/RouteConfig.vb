﻿Imports System.Web.Routing
Imports Microsoft.AspNet.FriendlyUrls


Public Class RouteConfig
    Public Shared Sub RegisterRoutes(routes As RouteCollection)
        routes.EnableFriendlyUrls()

        routes.MapPageRoute("", "Default", "~/Default.aspx")
        'routes.MapPageRoute("", "Customers", "~/Customers.aspx")
        routes.MapPageRoute("Object", "object/{id}", "~/PropertyDetails.aspx")
        routes.MapPageRoute("Novosti", "novosti/{slug}", "~/PostNewsDetails.aspx")
        routes.MapPageRoute("About", "about/{slug}", "~/PostNewsDetails.aspx")
        routes.MapPageRoute("Jiloi-kompleks-sochi", "Jiloi-kompleks-sochi/{slug}", "~/PostNewsDetails.aspx")
        routes.MapPageRoute("Rajon-Sochi", "rajon-sochi/{slug}", "~/PostNewsDetails.aspx")

    End Sub


End Class
