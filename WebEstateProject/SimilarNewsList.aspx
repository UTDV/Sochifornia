<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SimilarNewsList.aspx.vb" Inherits="WebEstateProject.SimilarNewsList" %>

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
        <div>

            <dx:ASPxHiddenField ID="SimilarHiddenField" ClientInstanceName="SimilarHiddenField" runat="server" />

            <dx:ASPxImageGallery ID="SimilarNewsGallery" ClientInstanceName="SimilarNewsGallery" runat="server" DataSourceID="SimilarNewsDS" EnableViewState="false"
                NavigateUrlField="Slug" TextField="Header" TextVisibility="Always" Target="_blank" NameField="ImageURL" AllowPaging="false" ItemSpacing="20"
                OnItemDataBound="SimilarNewsGallery_ItemDataBound" Layout="Breakpoints" ThumbnailImageSizeMode="FillAndCrop" Width="100%">

                <SettingsFolder ImageCacheFolder="~/Content/Thumb/SimilarThumb" />

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


            <asp:SqlDataSource ID="SimilarNewsDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>'
                SelectCommand="select p.ID
                                    , p.Header
                                    , CONCAT('~/novosti/', p.Slug) Slug
                                    , p.ImageURL
                                    --, iif(p.ImageURL is null, '~/Content/Foto/007/News/News.jpg', '~/Content/PostsFoto/' + p.ImageURL) ImageURL
                               from [dbo].[Posts] cur_p join [dbo].[PostsMetaData] pmd on pmd.PostId = cur_p.ID and pmd.MetaNameID = 4
                                                     join [dbo].[Posts] p on p.ID = TRY_CONVERT(int, pmd.MetaData)
                               where cur_p.Slug = @slug">
                <SelectParameters>
                    <asp:ControlParameter Name="slug" ControlID="SimilarHiddenField" PropertyName="['slug']" />
                </SelectParameters>
            </asp:SqlDataSource>

        </div>
    </form>
</body>
</html>
