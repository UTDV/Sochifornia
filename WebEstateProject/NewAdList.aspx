<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="NewAdList.aspx.vb" Inherits="WebEstateProject.NewAdList" %>

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <title></title>

    <link rel="stylesheet" href="~/Content/bootstrap.css" />
    <script src="../Scripts/jquery-3.0.0.js"></script>
    <script src="../Scripts/bootstrap.js"></script>

    <script type="text/javascript">



    </script>

    <style type="text/css">

        .textClass {
            line-height: 20px;
            font-size:small;
        }

        /*.itemClass:hover > .textClass {
            height:100%;
            padding-top:45%;
            font-size:medium;
        }*/

    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div class="m-0">


            <dx:ASPxImageGallery ID="NewAdGallery" ClientInstanceName="NewAdGallery" runat="server" DataSourceID="NewAdDS" EnableViewState="false" 
                NavigateUrlField="Slug" TextField="Name" TextVisibility="Always" Target="_blank" NameField="ID" AllowPaging="false"   
                OnItemDataBound="NewAdGallery_ItemDataBound" Layout="Breakpoints" ThumbnailImageSizeMode="FillAndCrop" Width="100%" ItemSpacing="20" >

                <ClientSideEvents Init="function(s,e){ if(NewAdGallery.itemsCount == 0) { NewAdGallery.SetClientVisible(0); } }" />

                <SettingsFolder ImageCacheFolder="~/Content/Thumb/NewAdThumb" />
                
                <SettingsBreakpointsLayout ItemsPerPage="3" ItemsPerRow="3">
                    <Breakpoints>
                        <dx:ImageGalleryBreakpoint MaxWidth="400"  ItemsPerRow="1" />

                    </Breakpoints>
                </SettingsBreakpointsLayout>

                <Styles>
                    <ThumbnailTextArea Wrap="True" HorizontalAlign="Center" CssClass="textClass" />
                    <Item CssClass="itemClass" />
                </Styles>                

            </dx:ASPxImageGallery>


                        <asp:SqlDataSource ID="NewAdDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>' 
                            SelectCommand="SELECT top(3) [ID]
                                                 , [Name]
                                                 , CONCAT('../object/', [Slug]) Slug, CONCAT('../Content/Foto/', ID, '/!Main.jpg') ImageURL
                                            FROM [dbo].[PropertyObjects] p
                                            where p.AdStatus = 73 
                                             -- and p.ActualUntil >= CONVERT(DATE, GETDATE())
                                              and p.Sale = 0
                                              and p.Hide = 0
                                            order by p.LastUpdate desc" />

        </div>
    </form>
</body>
</html>
