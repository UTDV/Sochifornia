<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="PropertyDetails.aspx.vb" Inherits="WebEstateProject.PropertyDetails" %>

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <dx:ASPxHiddenField ID="HiddenField" runat="server" />

    <dx:ASPxFormLayout ID="FormLayout" ClientInstanceName="FormLayout" runat="server" Width="100%" Paddings-PaddingTop="20" ColumnCount="2" UseDefaultPaddings="false"
        Style="margin-right: 10px">
        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="992" />
        <Items>

            <dx:LayoutItem ShowCaption="False" ColumnSpan="1" RowSpan="1" Paddings-PaddingBottom="10">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">

                        <dx:ASPxHeadline ID="HeadLine" runat="server" HorizontalAlign="Center" HeaderStyle-Wrap="True"
                            HeaderStyle-CssClass="FontClassComfortaa" />

                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>

            <dx:LayoutItem ShowCaption="False" ColumnSpan="1" RowSpan="1" Paddings-PaddingBottom="10" HorizontalAlign="Center">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">

                        <dx:ASPxHeadline ID="ActualStatusHeadline" runat="server" HorizontalAlign="Center" HeaderText=""
                            HeaderStyle-CssClass="FontClassCaveat" HeaderStyle-Paddings-Padding="10" HeaderStyle-Wrap="False" />

                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>

            <dx:LayoutItem ShowCaption="False" Paddings-PaddingTop="17" ColumnSpan="1" RowSpan="2">
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
                ColumnSpan="1" RowSpan="1" GroupBoxStyle-Caption-Font-Size="12" SettingsItemCaptions-VerticalAlign="Middle">
                <CellStyle Paddings-PaddingTop="10" CssClass="FontClassSize" />
                <Items>

                    <dx:LayoutItem ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="TypeLabel" runat="server" Wrap="False" CssClass="FontClassSize" Style="text-align: right; margin-bottom: 10px" Font-Bold="true" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Жилой комплекс" Name="Complex">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="ComplexLabel" runat="server" Wrap="False" CssClass="FontClassSize" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Район">
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
                                <dx:ASPxLabel ID="IpotekaLabel" runat="server" Wrap="False" CssClass="FontClassSize" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Актуальность">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="LastUpdateLabel" runat="server" Wrap="False" CssClass="FontClassSize" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>                    

                </Items>
            </dx:LayoutGroup>

            <dx:LayoutGroup Caption="Специалист" Name="CreatorLayoutGroup" GroupBoxDecoration="HeadingLine" SettingsItemCaptions-AllowWrapCaption="False" 
                ColumnSpan="1" RowSpan="1" GroupBoxStyle-Caption-Font-Size="12" SettingsItemCaptions-VerticalAlign="Middle">
                <CellStyle CssClass="FontClassSize" />

                <Items>

                    <dx:LayoutItem ShowCaption="False" Name="CreatorPhoneItem" ClientVisible="false" ParentContainerStyle-Paddings-PaddingTop="10" >
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxHeadline ID="CreatorPhone" runat="server" HeaderStyle-Wrap="False" HeaderStyle-CssClass="PhoneClassComfortaa" ShowHeaderAsLink="true" 
                                    HeaderStyle-Paddings-PaddingTop="7" Image-Url="~/Content/Icons/telephone.png" ShowImageAsLink="true" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem ShowCaption="False" Name="CallButtonItem" ParentContainerStyle-Paddings-PaddingTop="10" >
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxButton ID="CallButton" ClientInstanceName="CallButton" runat="server" Text="Показать телефон" AutoPostBack="false" Width="200">
                                    <ClientSideEvents Click="function(s,e){ FormLayout.GetItemByName('CreatorPhoneItem').SetVisible(1); FormLayout.GetItemByName('CallButtonItem').SetVisible(0); }" />
                                </dx:ASPxButton>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem ShowCaption="False" ParentContainerStyle-Paddings-PaddingTop="10" >
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxButton ID="SendMailButton" ClientInstanceName="SendMailButton" runat="server" Text="Написать" AutoPostBack="false" Width="200" 
                                    Image-Url="~/Content/Icons/envelope.png" ImageSpacing="10">
                                    <ClientSideEvents Click="function(s,e){ SendMailPopup.Show(); }" />
                                </dx:ASPxButton>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                </Items>

            </dx:LayoutGroup>

            <dx:LayoutGroup Caption="Описание" GroupBoxDecoration="Box" ColumnSpan="2" RowSpan="1" GroupBoxStyle-Caption-Font-Size="12" ParentContainerStyle-Paddings-Padding="10">
                <Items>
                    <dx:LayoutItem ShowCaption="False">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="DescriptionLabel" runat="server" CssClass="FontClassSize" Style="text-align: justify; line-height: 30px;" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>

            <dx:LayoutGroup Name="ServiceInfo" Caption="Служебная информация" GroupBoxDecoration="Box" ColumnSpan="2" RowSpan="1" ParentContainerStyle-Paddings-Padding="10"
                GroupBoxStyle-Caption-Font-Size="12" SettingsItemCaptions-AllowWrapCaption="False" SettingsItemCaptions-VerticalAlign="Middle" Visible="false">
                <CellStyle CssClass="FontClassSize" />

                <Items>

                    <dx:LayoutItem Caption="Посредник" Name="Posr" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="Posrednik" runat="server" CssClass="FontClassSize" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Комиссия" Name="Comiss" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxLabel ID="Comission" runat="server" CssClass="FontClassSize"  />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>

            </dx:LayoutGroup>

        </Items>

    </dx:ASPxFormLayout>

    <br />

    <script src="https://yastatic.net/share2/share.js"></script>


    <div class="ya-share2" data-size="l" data-services="vkontakte,facebook,odnoklassniki,telegram,viber,whatsapp" style="text-align:center"></div>


    <dx:ASPxPopupControl ID="SendMailPopup" ClientInstanceName="SendMailPopup" runat="server" HeaderText="Оставить сообщение" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" HeaderStyle-Paddings-PaddingLeft="30" >
        <SettingsAdaptivity Mode="Always" VerticalAlign="WindowCenter" MaxWidth="400" />
        <ClientSideEvents Closing="function(s,e){ ASPxClientEdit.ClearEditorsInContainer(SendMailPopup.GetMainElement()); ErrorLabel.SetText(''); SendMailFormLayout.GetItemByName('ErrorLabelItem').SetVisible(0); }" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">

                <dx:ASPxFormLayout ID="SendMailFormLayout" ClientInstanceName="SendMailFormLayout" runat="server" Width="100%" ColumnCount="1" Styles-LayoutItem-Paddings-Padding="10">
                    <Items>

                        <dx:LayoutItem ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="NameSendMail" ClientInstanceName="NameSendMail" runat="server" Width="100%" NullText="Ваше имя" />
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                        <dx:LayoutItem ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="PhoneSendMail" ClientInstanceName="PhoneSendMail" runat="server" Width="100%" NullText="Телефон" DisplayFormatString="+# (###) ###-##-##" >
                                        <ClientSideEvents GotFocus="function(s,e){ if(PhoneSendMail.GetText()==''){ PhoneSendMail.SetText('+7'); } }" 
                                            LostFocus="function(s,e){ if(PhoneSendMail.GetText()=='+7'){ PhoneSendMail.SetText(''); } }"    />
                                    </dx:ASPxTextBox>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                        <dx:LayoutItem ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxTextBox ID="EmailSendMail" ClientInstanceName="EmailSendMail" runat="server" Width="100%" NullText="E-mail" />
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                        <dx:LayoutItem ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxMemo ID="NoteSendMail" ClientInstanceName="NoteSendMail" runat="server" Width="100%" NullText="Меня заинтересовал этот объект. Пожалуйста, расскажите о нем подробнее." Rows="5" />
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                        <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    
                                    <dx:ASPxButton ID="SendButton" runat="server" Width="200" AutoPostBack="false" Text="Отправить">
                                        <ClientSideEvents Click="function(s,e){ SendButtonClick(); }" />
                                    </dx:ASPxButton>                                    

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                        <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center" ClientVisible="false" Name="ErrorLabelItem">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    

                                    <dx:ASPxLabel ID="ErrorLabel" ClientInstanceName="ErrorLabel" runat="server" Text="" ForeColor="Red" Font-Size="Smaller" />

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                    </Items>
                </dx:ASPxFormLayout>

            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>


    <dx:ASPxCallback ID="CBackSendMail" ClientInstanceName="CBackSendMail" runat="server" OnCallback="CBackSendMail_Callback">
        <ClientSideEvents CallbackComplete="function(s,e){ CBackSendMailResult(e.result); }" />
    </dx:ASPxCallback>

    <dx:ASPxLoadingPanel ID="LoadingPanel" ClientInstanceName="LoadingPanel" runat="server" Modal="true" />

    <script type="text/javascript">

        function SendButtonClick() {            

            ErrorLabel.SetText('');
            SendMailFormLayout.GetItemByName('ErrorLabelItem').SetVisible(0);

            if (NameSendMail.GetText() == '') {
                ErrorLabel.SetText('Пожалуйста, укажите Ваше имя');
                SendMailFormLayout.GetItemByName('ErrorLabelItem').SetVisible(1);
            }
            else if (PhoneSendMail.GetText() == '' && EmailSendMail.GetText() == '') {
                ErrorLabel.SetText('Пожалуйста, укажите телефон или e-mail');
                SendMailFormLayout.GetItemByName('ErrorLabelItem').SetVisible(1);
            }
            else if (PhoneSendMail.GetText() != '' && /^\d{10}$/.test(PhoneSendMail.GetText().substring(2)) == false) {
                ErrorLabel.SetText('Некорректный номер телефона');
                SendMailFormLayout.GetItemByName('ErrorLabelItem').SetVisible(1);
            }
            else if (EmailSendMail.GetText() != '' && /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/.test(EmailSendMail.GetText()) == false) {
                ErrorLabel.SetText('Некорректный e-mail');
                SendMailFormLayout.GetItemByName('ErrorLabelItem').SetVisible(1);
            }
            else {
                LoadingPanel.Show();
                CBackSendMail.PerformCallback();
            }

        }

        function CBackSendMailResult(vl) {
            LoadingPanel.Hide();
            if (vl == 1) {
                SendMailPopup.Hide();
            }
            else if (vl == 0) {
                ErrorLabel.SetText('Что-то пошло не так. Попробуйте еще раз.');
                SendMailFormLayout.GetItemByName('ErrorLabelItem').SetVisible(1);
            }
        }

    </script>

</asp:Content>
