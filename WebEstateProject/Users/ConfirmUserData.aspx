<%@ Page Title="Подтверждение данных" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="ConfirmUserData.aspx.vb" Inherits="WebEstateProject.ConfirmUserData" %>

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadButtonsContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <dx:ASPxFormLayout ID="ConfirmUserDataForm" runat="server" Width="100%">
        <ClientSideEvents Init="function(s,e){ s.SetHeight (window.innerHeight - TopPanel.GetHeight() - BottomPanel.GetHeight() - 60); }" />
        <Items>
            <dx:LayoutGroup Caption="Подтверждение данных" HorizontalAlign="center" Paddings-PaddingTop="20" Paddings-PaddingLeft="30" Paddings-PaddingRight="30">
                <GridSettings StretchLastItem="True" WrapCaptionAtWidth="500" />
                <Items>



                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>

</asp:Content>
