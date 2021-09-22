<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="PostNewsDetails.aspx.vb" Inherits="WebEstateProject.PostNewsDetails" %>

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">       

    <style type="text/css">

        .dxigControl_MaterialCompact td.dxigCtrl {
            padding: 0 !important;
        }

        .responsive-iframe {
            position: absolute;
            top: 0;
            left: 0;
            bottom: 0;
            right: 0;
            width: 100%;
            height: 100%;
            border: none;
        }

        .vip-iframe {
            position: absolute;
            top: 0;
            left: 0;
            bottom: 0;
            right: 0;
            width: 100%;
            height: 100%;
            border: none;
        }

        .textClass {
            line-height: 20px;
            font-size:small;          
            
        } 

        @media screen and (min-width: 992px) {
            .VIPContainer {
                position: relative;
                width: 70%;
                overflow: hidden;
                padding-top: 200%;
                margin-top: 20px;
                margin-bottom: 0;
                margin-left: auto;
                margin-right: 0;
            }

            .NewAdContainer {
                position: relative;
                width: 100%;
                overflow: hidden;
                padding-top: 35%;
                margin:0 auto;
            }
        }

        @media screen and (max-width: 991.98px) {

            .VIPContainer {
                position: relative;
                width: 100%;
                overflow: hidden;
                padding-top: 35%;
                margin-top: 0;
                margin-bottom: 0;
                margin-left: auto;
                margin-right: auto;
            }

            .NewAdContainer {
                position: relative;
                width: 100%;
                overflow: hidden;
                padding-top: 35%;
            }
        }

        @media screen and (max-width: 454px) {
            
            .VIPContainer {
                position: relative;
                width: 100%;
                overflow: hidden;
                padding-top: 300%;
                margin-top: 0;
                margin-bottom: 0;
                margin-left: auto;
                margin-right: auto;
            }

            .NewAdContainer {
                position: relative;
                width: 100%;
                overflow: hidden;
                padding-top: 300%;
            }
        }


    </style>

    <dx:ASPxHiddenField ID="HiddenField" ClientInstanceName="HiddenField" runat="server" />


    <dx:ASPxFormLayout ID="NewsFormLayout" ClientInstanceName="NewsFormLayout" runat="server" ColumnCount="3"  >

        <ClientSideEvents Init="function(s,e) { NewsFormInit(); }" />

        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="990" />

        <Items>

            <dx:LayoutGroup GroupBoxDecoration="None" ColumnSpan="2" ColumnCount="1" >
                <Items>

                    <dx:LayoutItem ShowCaption="False" Name="HeaderItem">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxLabel ID="HeaderLabel" runat="server" CssClass="FontClassComfortaa mb-3 mt-3" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem ShowCaption="False" Name="DateItem">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxLabel ID="DateLabel" runat="server" ForeColor="Gray" CssClass="mb-3" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem ShowCaption="False" Name="MainFotoLayoutItem" Paddings-PaddingBottom="0" >
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxBinaryImage ID="MainFotoBI" runat="server" EnableServerResize="true" Style="width: 100%; height: auto" CssClass="mb-3"/>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem ShowCaption="False" Name="NewsGallery" HorizontalAlign="Center">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxImageGallery ID="NewsImageGallegy" ClientInstanceName="NewsImageGallegy" runat="server" Theme="MetropolisBlue"
                                    Layout="Breakpoints" ThumbnailHeight="100" ThumbnailWidth="100" >

                                    <SettingsFullscreenViewer NavigationBarVisibility="Always" AnimationType="Fade" EnablePagingGestures="true"
                                        AllowMouseWheel="true" EnablePagingByClick="true" />

                                    <StylesFullscreenViewerNavigationBar NavigationBar-Margins-MarginBottom="20" />

                                    <PagerSettings EndlessPagingMode="OnClick" ShowMoreItemsText="Загрузить больше..." />

                                    <SettingsBreakpointsLayout ItemsPerRow="6" ItemsPerPage="6">
                                        <Breakpoints>
                                            <dx:ImageGalleryBreakpoint DeviceSize="XSmall" ItemsPerRow="2" />
                                        </Breakpoints>
                                    </SettingsBreakpointsLayout>

                                </dx:ASPxImageGallery>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxHeadline ID="NewsHeadline" runat="server" EncodeHtml="false"  EnableViewState="false" HorizontalAlign="Justify"/>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    

                    <dx:LayoutGroup GroupBoxDecoration="HeadingLine" Caption="Похожие новости" GroupBoxStyle-Caption-CssClass="mt-4" GroupBoxStyle-CssClass="p-0 mb-0" Name="SimilarPostsGroup">
                        <Items>

                            <dx:LayoutItem ShowCaption="False" Width="100%" >
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">



                                        <dx:ASPxImageGallery ID="SimilarNewsGallery" ClientInstanceName="SimilarNewsGallery" runat="server" DataSourceID="SimilarNewsDS" EnableViewState="false"
                                            NavigateUrlField="Slug" TextField="Header" TextVisibility="Always" Target="_blank" NameField="ImageURL" AllowPaging="false" ItemSpacing="20"
                                            OnItemDataBound="SimilarNewsGallery_ItemDataBound" Layout="Breakpoints" ThumbnailImageSizeMode="FillAndCrop" Width="100%">

                                            <SettingsFolder ImageCacheFolder="~/Content/Thumb/SimilarThumb" />

                                            <SettingsBreakpointsLayout ItemsPerPage="3" ItemsPerRow="3">
                                                <Breakpoints>
                                                    <dx:ImageGalleryBreakpoint MaxWidth="800" ItemsPerRow="2" />
                                                    <dx:ImageGalleryBreakpoint MaxWidth="500" ItemsPerRow="1" />
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
                                                <asp:ControlParameter Name="slug" ControlID="HiddenField" PropertyName="['slug']" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>



                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                        </Items>
                    </dx:LayoutGroup>

                    <dx:LayoutItem ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <hr class="mt-0" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                </Items>
            </dx:LayoutGroup>

            <dx:LayoutItem ColumnSpan="1" ShowCaption="False" Name="VipItem" >                
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">                        

                        <div class="VIPContainer">                                
                            <iframe id="vipiframe" class="vip-iframe" src="../VIPList.aspx"></iframe>
                        </div>

                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>

            <dx:LayoutItem ColumnSpan="2" ShowCaption="False" Name="NewAdItem" >
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">

                        <div class="NewAdContainer">
                            <iframe id="respiframe" class="responsive-iframe" src="../NewAdList.aspx"></iframe>
                        </div>
                        
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>



        </Items>
    </dx:ASPxFormLayout>

    <script type="text/javascript"> 


        function NewsFormInit() {
            if ($.trim($('#vipiframe').contents().find("#VIPGallery").text().includes('Нет данных для отображения')) == "true" || $.trim($('#vipiframe').contents().find("#VIPGallery").text().includes('No data to display')) == "true") { 
                NewsFormLayout.GetItemByName('VipItem').SetVisible(0);
            }
            if ($.trim($('#respiframe').contents().find("#NewAdGallery").text().includes('Нет данных для отображения')) == "true" || $.trim($('#respiframe').contents().find("#NewAdGallery").text().includes('No data to display')) == "true") {
                NewsFormLayout.GetItemByName('NewAdItem').SetVisible(0);
            }
        }

        
    </script>


</asp:Content>
