<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="VIPList.aspx.vb" Inherits="WebEstateProject.VIPList" %>

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <title></title>

    <link rel="stylesheet" href="~/Content/bootstrap.css" />
    <script src="../Scripts/jquery-3.0.0.js"></script>
    <script src="../Scripts/bootstrap.js"></script>

    <style type="text/css">

        .textClass {
            line-height: 20px;
            font-size:small;          
            
        } 

    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div class="m-0">



            <dx:ASPxImageGallery ID="VIPGallery" ClientInstanceName="VIPGallery" runat="server" DataSourceID="VIPDS" EnableViewState="false"
                NavigateUrlField="Slug" TextField="Name" TextVisibility="Always" Target="_blank" NameField="ID" AllowPaging="false" ItemSpacing="20"
                OnItemDataBound="VIPGallery_ItemDataBound" Layout="Breakpoints" ThumbnailImageSizeMode="FillAndCrop" Width="100%" >

                <SettingsFolder ImageCacheFolder="~/Content/Thumb/VIPThumb" />

                <SettingsBreakpointsLayout ItemsPerPage="3" ItemsPerRow="3">
                    <Breakpoints>
                        <dx:ImageGalleryBreakpoint MaxWidth="400" ItemsPerRow="1" />
                    </Breakpoints>
                </SettingsBreakpointsLayout>

                <Styles>
                    <ThumbnailTextArea Wrap="True" HorizontalAlign="Center" CssClass="textClass" />
                    <Item CssClass="itemClass" />
                </Styles>

            </dx:ASPxImageGallery>


            <asp:SqlDataSource ID="VIPDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>' 
                            SelectCommand="SELECT top(3) [ID]
                                                 , [Name]
                                                 , CONCAT('../object/', [Slug]) Slug
                                            FROM [dbo].[PropertyObjects] p
                                            where p.AdStatus = 73 
                                              and p.VIP = 1
                                              and p.ActualUntil >= CONVERT(DATE, GETDATE()) --and id in (127, 138,139,140)
                                              and p.Sale = 0
                                              and p.Hide = 0
                                            order by NEWID()" />

        </div>
    </form>
</body>
</html>
