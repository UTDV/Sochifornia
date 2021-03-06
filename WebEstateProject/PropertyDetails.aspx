<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="PropertyDetails.aspx.vb" Inherits="WebEstateProject.PropertyDetails" %>

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="ButtonsContent" ContentPlaceHolderID="HeadButtonsContent" runat="server">

    <dx:ASPxButton ID="PrintButton" ClientInstanceName="PrintButton" runat="server" AutoPostBack="false" RenderMode="Link"
        Image-Url="~/Content/Icons/printer.png" Text="Печать" ToolTip="Печать" CssClass="PrintButtonClass">
        <ClientSideEvents Click=" function(s,e) {window.print(); } " />        
    </dx:ASPxButton>

</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <dx:ASPxFormLayout ID="FormLayout" ClientInstanceName="FormLayout" runat="server" Width="100%" Paddings-PaddingTop="20" ColumnCount="2" UseDefaultPaddings="false"
        Style="margin-right: 10px">
        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="992" />
        <Items>

            <dx:LayoutItem ShowCaption="False" ColumnSpan="1" RowSpan="1" Paddings-PaddingBottom="10">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">

                        <dx:ASPxHeadline ID="HeadLine" runat="server" HorizontalAlign="Center" HeaderStyle-Wrap="True" 
                            HeaderStyle-CssClass="FontClassComfortaa"  />

                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>

            <dx:LayoutItem ShowCaption="False" ColumnSpan="1" RowSpan="1" Paddings-PaddingBottom="10" HorizontalAlign="Center">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">

                        <dx:ASPxHeadline ID="ActualStatusHeadline" runat="server" HorizontalAlign="Center" HeaderText="" 
                            HeaderStyle-CssClass="FontClassCaveat"  HeaderStyle-Paddings-Padding="10" HeaderStyle-Wrap="False" />

                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>

            <dx:LayoutItem ShowCaption="False" Paddings-PaddingTop="17" ColumnSpan="1" RowSpan="1">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">

                        <dx:ASPxImageGallery ID="FotoGallary" ClientInstanceName="FotoGallary" runat="server" Theme="MetropolisBlue"
                            Layout="Breakpoints" ThumbnailHeight="200" ThumbnailWidth="200">

                            <SettingsFullscreenViewer NavigationBarVisibility="Always" AnimationType="Fade" EnablePagingGestures="true"
                                AllowMouseWheel="true" EnablePagingByClick="true" />

                            <StylesFullscreenViewerNavigationBar NavigationBar-Margins-MarginBottom="20" />

                            <PagerSettings EndlessPagingMode="OnClick" ShowMoreItemsText="Загрузить больше..." />

                            <SettingsBreakpointsLayout ItemsPerRow="3" ItemsPerPage="6">
                                <Breakpoints>
                                    <dx:ImageGalleryBreakpoint DeviceSize="XSmall" ItemsPerRow="2" />
                                </Breakpoints>
                            </SettingsBreakpointsLayout>                            

                            <EmptyDataTemplate>
                                <dx:ASPxLabel ID="EmptyLabel" runat="server" Text="Нет фотографий :(" />
                            </EmptyDataTemplate>

                        </dx:ASPxImageGallery>

                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>

            <dx:LayoutGroup Caption="Информация" GroupBoxDecoration="HeadingLine" SettingsItemCaptions-AllowWrapCaption="False"   
                ColumnSpan="1" RowSpan="1" GroupBoxStyle-Caption-Font-Size="12" SettingsItemCaptions-VerticalAlign="Middle" >
                <CellStyle Paddings-PaddingTop="10" CssClass="FontClassSize" />
                <Items>

                    <dx:LayoutItem ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="TypeLabel" runat="server" Wrap="False" CssClass="FontClassSize" Style="text-align:right; margin-bottom:10px" Font-Bold="true" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Жилой комплекс" Name="Complex">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="ComplexLabel" runat="server" Wrap="False" CssClass="FontClassSize"  />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Район" >
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="DistrictLabel" runat="server" Wrap="False" CssClass="FontClassSize" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Улица" Name="Street">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="StreetLabel" runat="server" Wrap="False" CssClass="FontClassSize" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Кол-во комнат" Name="Rooms">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="RoomsLabel" runat="server" Wrap="False" CssClass="FontClassSize" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Цена">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="PriceLabel" runat="server" Wrap="False" CssClass="FontClassSize" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Площадь">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="AreaLabel" runat="server" Wrap="False" CssClass="FontClassSize" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Цена за кв.метр">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="PriceForMetrLabel" runat="server" Wrap="False" CssClass="FontClassSize" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Площадь участка" Name="LandArea">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="LandAreaLabel" runat="server" Wrap="False" CssClass="FontClassSize" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Плита" Name="Stove">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="StoveLabel" runat="server" Wrap="False" CssClass="FontClassSize" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Этаж" Name="Floor">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="FloorLabel" runat="server" Wrap="False" CssClass="FontClassSize" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="До моря" Name="ToSea">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="ToSeaLabel" runat="server" Wrap="False" CssClass="FontClassSize" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Статус">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="StatusLabel" runat="server" Wrap="False" CssClass="FontClassSize" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Состояние">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="ConditionLabel" runat="server" Wrap="False" CssClass="FontClassSize" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Оформление">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="RegistrationLabel" runat="server" Wrap="False" CssClass="FontClassSize" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Вид из окна" Name="WindowView">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="ViewLabel" runat="server" Wrap="False" CssClass="FontClassSize" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Ипотека">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="IpotekaLabel" runat="server" Wrap="False" CssClass="FontClassSize"  />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Обновление">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="LastUpdateLabel" runat="server" Wrap="False" CssClass="FontClassSize"  />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                </Items>
            </dx:LayoutGroup>
            
            <dx:LayoutGroup Caption="Описание" GroupBoxDecoration="Box" ColumnSpan="2" RowSpan="1" GroupBoxStyle-Caption-Font-Size="12" ParentContainerStyle-Paddings-Padding="10" >                
                <Items>
                    <dx:LayoutItem ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="DescriptionLabel" runat="server" CssClass="FontClassSize" Style="text-align:justify; line-height: 30px;" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>

        </Items>

    </dx:ASPxFormLayout>








</asp:Content>
