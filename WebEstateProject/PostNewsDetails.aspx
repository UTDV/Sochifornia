<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="PostNewsDetails.aspx.vb" Inherits="WebEstateProject.PostNewsDetails" %>

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <asp:FormView ID="BasicForm" runat="server" DataSourceID="NewsDetailsDS">
        <ItemTemplate>
            <dx:ASPxFormLayout ID ="Newsform" runat ="server" ColumnCount ="2" >
                <SettingsAdaptivity AdaptivityMode ="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth ="990" />
                <Items >
                    
                    <dx:LayoutGroup ShowCaption="False">
                        <Items>

                        </Items>
                    </dx:LayoutGroup>
                </Items>

            </dx:ASPxFormLayout>
        </ItemTemplate>
    </asp:FormView>


    <asp:SqlDataSource ID="NewsDetailsDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>'
        SelectCommand=" Exec dbo.[GetPostInfoShow] @Slug">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="slug" Name="Slug" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
