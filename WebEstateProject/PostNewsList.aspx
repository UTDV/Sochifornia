<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="PostNewsList.aspx.vb" Inherits="WebEstateProject.PostNewsList" %>

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <dx:ASPxFormLayout ID="NewsForm" runat="server" Width="100%" ColumnCount="2">
        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="990"></SettingsAdaptivity>
        <Items>
            <dx:LayoutItem ShowCaption="False" Width="60%" ColumnSpan="1" >
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxNewsControl ID="NewsList" runat="server" ClientInstanceName="NewsList" PagerSettings-EndlessPagingMode="OnClick" DataSourceID="PostNewsDS" DateField="Created"
                            HeaderTextField="Header" ImageUrlField="ImageUrl" TextField="Text" NameField="Category" EncodeHtml="false" NavigateUrlField="NewsUrl" Width="100%" ItemSettings-MaxLength="50" ItemSettings-TailText ="Узнать больше">
                            <ItemSettings ShowHeaderAsLink="true" ShowImageAsLink="true"></ItemSettings>
                            <ItemImage Width="150" />
                            <ItemContentStyle BorderBottom-BorderWidth="1px"></ItemContentStyle>
                        </dx:ASPxNewsControl>

                        <asp:SqlDataSource ID="PostNewsDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>'
                            SelectCommand=" Exec dbo.PostNewsList @Category">
                            <SelectParameters>
                                <asp:QueryStringParameter QueryStringField="cat" Name="Category" DefaultValue="all" />

                            </SelectParameters>

                        </asp:SqlDataSource>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
            <dx:LayoutItem ShowCaption="False" ColumnSpan="1">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server" Width="20%">
                        <%--<div ID="objectsContent" runat="server" >
                            <!-- #Include virtual="/ObjectsCardView.aspx" -->
                        </div>--%>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
        </Items>
    </dx:ASPxFormLayout>

</asp:Content>
