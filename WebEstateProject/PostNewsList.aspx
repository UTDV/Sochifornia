<%@ Page Title="Новости Сочи" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="PostNewsList.aspx.vb" Inherits="WebEstateProject.PostNewsList" %>

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style type="text/css">

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
            }
        }

        @media screen and (max-width: 991.98px) {

            .VIPContainer {
                position: relative;
                width: 100%;
                overflow: hidden;
                padding-top: 35%;
                margin-top: 20px;
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

        td {
            min-width:0px !important;
        }

        .itemstyle {
            border-color:rgba(0,0,0,0.1);
        }

    </style>

    <dx:ASPxFormLayout ID="NewsForm" runat="server" Width="100%" ColumnCount="3" Paddings-PaddingTop="20">

        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="990" />

        <Items>

            <dx:LayoutItem ShowCaption="False" ColumnSpan="2">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">

                        <div class="FontClassComfortaa ml-2" style="color:black !important;">
                            Новости Сочи
                        </div>

                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>

            <dx:LayoutItem ShowCaption="False" ColumnSpan="2" >
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">

                        <dx:ASPxNewsControl ID="NewsList" ClientInstanceName="NewsList" runat="server" DataSourceID="PostNewsDS" 
                            DateField="Created" HeaderTextField="Header" ImageUrlField="ImageUrl" TextField="Text" 
                            NameField="Category" NavigateUrlField="NewsUrl" Width="100%" EnableViewState="false" 
                            OnItemDataBound="NewsList_ItemDataBound" RowPerPage="4" CssClass="mt-3" PagerSettings-EnableAdaptivity="true" >

                            <ItemHeaderStyle Font-Names="Comfortaa" LineHeight="22" CssClass="mb-2" />

                            <ItemContentStyle LineHeight="22" CssClass="text-justify" />

                            <ItemDateStyle CssClass="mb-3" />

                            <ItemSettings MaxLength="80" TailText="УЗНАТЬ БОЛЬШЕ" DateHorizontalPosition="Left" TailPosition="NewLine" Target="_blank" ShowHeaderAsLink="true" />

                            <ItemImage Width="200" Height="150" />

                            <ItemLeftPanelStyle CssClass="d-md-block d-none pr-4 "  />
                            
                            <PagerSettings EndlessPagingMode="OnClick" ShowMoreItemsText="Больше новостей..."  />

                            <ItemStyle BorderTop-BorderWidth="1" BorderBottom-BorderWidth="1" CssClass="itemstyle"  />

                        </dx:ASPxNewsControl>

                        <asp:SqlDataSource ID="PostNewsDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>'
                            SelectCommand=" Exec dbo.PostNewsList @Category , 'novosti'">
                            <SelectParameters>
                                <asp:QueryStringParameter QueryStringField="cat" Name="Category" DefaultValue="all" />
                            </SelectParameters>

                        </asp:SqlDataSource>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>

            <dx:LayoutItem ColumnSpan="1" ShowCaption="False" >                
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">

                        <div class="VIPContainer">                                
                            <iframe class="vip-iframe" src="../VIPList.aspx"></iframe>
                        </div>

                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>

            <dx:LayoutItem ColumnSpan="2" ShowCaption="False" >
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">

                        <div class="NewAdContainer">
                            <iframe class="responsive-iframe" src="../NewAdList.aspx"></iframe>
                        </div>
                        
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>

        </Items>
    </dx:ASPxFormLayout>

</asp:Content>
