<%@ Page Title="Вход" Language="vb" AutoEventWireup="false" MasterPageFile="~/DeepWeb.Master" CodeBehind="LoginUser.aspx.vb" Inherits="WebEstateProject.Login1" %>

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <dx:ASPxFormLayout ID="LoginForm" runat="server" Width="100%">
        <ClientSideEvents Init="function(s,e){ s.SetHeight (window.innerHeight - TopPanel.GetHeight() - 60); }" />
        <Items>
            <dx:LayoutGroup Caption="Авторизация пользователя" HorizontalAlign="center" Paddings-PaddingTop="20" Paddings-PaddingLeft="30" Paddings-PaddingRight="30" SettingsItemCaptions-Location="Top">
                <Items>

                    <dx:LayoutItem Caption="Электронная почта">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="LoginEmailTB" runat="server" Width="100%" >
                                    <ValidationSettings SetFocusOnError="true" Display="Dynamic" ErrorTextPosition="Bottom" ErrorDisplayMode="Text">
                                        <RegularExpression ErrorText="Некорректные данные" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                        <RequiredField IsRequired="True" ErrorText="Введите email" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Пароль">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="PasswordTB" runat="server" Password="true" Width="100%" >
                                    <ValidationSettings SetFocusOnError="true" Display="Dynamic" ErrorTextPosition="Bottom" ErrorDisplayMode="Text">
                                        <RequiredField IsRequired="True" ErrorText="Введите пароль" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxButton ID="ForgetPasswordButton" runat="server" Text="Забыли пароль?" RenderMode="Link" AutoPostBack="false" CausesValidation="false" UseSubmitBehavior="false">
                                    <ClientSideEvents Click="function(s,e) { ForgetPasswordPopup.Show(); }" />
                                </dx:ASPxButton>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center" Paddings-PaddingTop="20">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxButton ID="LoginButton" ClientInstanceName="LoginButton" runat="server" Text="Войти" Width="200" AutoPostBack="false" OnClick="LoginButton_Click" UseSubmitBehavior="true"  />
                                

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center" Paddings-PaddingTop="20" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxButton ID="RegButton" runat="server" Text="Регистрация" Width="200" AutoPostBack="false" RenderMode="Outline" CausesValidation="false" UseSubmitBehavior="false" >
                                    <ClientSideEvents Click="function(s,e){ var redirectWindow = window.open('/Users/Registration.aspx', '_self'); }" />
                                </dx:ASPxButton>
                                

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxLabel ID="ErrorLabel" runat="server" Text="" Width="100%" ForeColor="Red" Font-Size="Smaller"  />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    

                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>

    <dx:ASPxPopupControl ID="ForgetPasswordPopup" ClientInstanceName="ForgetPasswordPopup" runat="server" HeaderText="Восстановление пароля" 
        ShowFooter="true" AutoUpdatePosition="true" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" CloseAction="CloseButton">
        <SettingsAdaptivity Mode="Always" VerticalAlign="WindowTop" HorizontalAlign="WindowCenter"  MaxWidth="400" MinWidth="330" FixedFooter="false" FixedHeader="false"/>

        <ClientSideEvents PopUp="function(s,e) { LoginButton.SetEnabled(false); GetPasswordButton.SetEnabled(true); }" Closing="function(s,e) { ForgetPasswordPopupClosing(); }" />

        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
                
                <dx:ASPxFormLayout ID="ForgetPasswordForm" ClientInstanceName="ForgetPasswordForm" runat="server" Width="100%">
                    <Items>

                        <dx:LayoutItem Caption="Выберите способ восстановления пароля" CaptionSettings-Location="Top" CaptionStyle-CssClass="mb-0 mt-2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">

                                    <dx:ASPxRadioButtonList ID="NewPasswordRadioButtonList" ClientInstanceName="NewPasswordRadioButtonList" runat="server" 
                                        Width="100%" SelectedIndex="0" Border-BorderWidth="0">
                                        <ClientSideEvents SelectedIndexChanged="function(s,e){ NewPasswordRadioButtonListChanged(s,e); }" />
                                        <Items>
                                            <dx:ListEditItem Text="Отправить ссылку на почту" Value="0" />
                                            <dx:ListEditItem Text="Отправить код в SMS" Value="1" />
                                            <dx:ListEditItem Text="Позвонить по номеру телефона" Value="2" />
                                        </Items>
                                    </dx:ASPxRadioButtonList>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                        <dx:TabbedLayoutGroup ShowGroupDecoration="false" ClientInstanceName="TabbedGroup" Width="100%">
                            <ClientSideEvents Init="function(s,e) { s.SetActiveTabIndex(NewPasswordRadioButtonList.GetSelectedIndex()); }" />
                            <Items>

                                <dx:LayoutItem ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            
                                            <dx:ASPxTextBox ID="NewPasswordEmailTB" ClientInstanceName="NewPasswordEmailTB" runat="server" Width="100%" Caption="Введите Email" 
                                                CaptionSettings-Position="Top" CaptionStyle-ForeColor="#8E8E8E" >                                                
                                                <ValidationSettings Display="None" RegularExpression-ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                            </dx:ASPxTextBox>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                                <dx:LayoutItem ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            
                                            <dx:ASPxTextBox ID="NewPasswordSMSTB" ClientInstanceName="NewPasswordSMSTB" runat="server" Width="100%" Caption="Введите номер телефона" 
                                                CaptionSettings-Position="Top" CaptionStyle-ForeColor="#8E8E8E" MaskSettings-Mask="+7 (000) 000-00-00" MaskSettings-IncludeLiterals="None">
                                                <ValidationSettings Display="None" />
                                            </dx:ASPxTextBox>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                            </Items>
                        </dx:TabbedLayoutGroup>

                        <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">

                                    <dx:ASPxCaptcha ID="Captcha" ClientInstanceName="Captcha" runat="server" TextBox-Position="Bottom" CssClass="mt-2">                                          
                                        <ValidationSettings SetFocusOnError="true" ErrorDisplayMode="Text" Display="Dynamic" EnableValidation="true" />
                                        <ChallengeImage Height="70" />
                                        <RefreshButton ShowImage="false" />
                                        <TextBoxStyle />
                                    </dx:ASPxCaptcha>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                    </Items>
                </dx:ASPxFormLayout>

            </dx:PopupControlContentControl>
        </ContentCollection>

        <FooterStyle Border-BorderStyle="None" HorizontalAlign="Center" Paddings-PaddingBottom="10" Paddings-PaddingTop="10" />

        <FooterTemplate>
            
            <dx:ASPxButton ID="GetPasswordButton" ClientInstanceName="GetPasswordButton" runat="server" AutoPostBack="false" Text="Продолжить" CausesValidation="false" UseSubmitBehavior="true" >
                <ClientSideEvents Click="function(s,e){ GetPasswordButtonClick(); }" />
            </dx:ASPxButton>

            <section style="text-align:center; margin-top:10px;">
                <dx:ASPxLabel ID="ErrorLabel" ClientInstanceName="ErrorLabel" runat="server" Text="" ForeColor="Red" />
            </section>

        </FooterTemplate>

    </dx:ASPxPopupControl>



    <dx:ASPxLoadingPanel ID="LoadingPanel" ClientInstanceName="LoadingPanel" runat="server" Modal="true" />

    <dx:ASPxCallback ID="CBackNewPassword" ClientInstanceName="CBackNewPassword" runat="server" OnCallback="CBackNewPassword_Callback">
        <ClientSideEvents CallbackComplete="function(s,e) { CBackNewPasswordResult(e.result); }" />
    </dx:ASPxCallback>

    <script type="text/javascript">

        //Восстановление пароля

        function NewPasswordRadioButtonListChanged(s, e) {

            ErrorLabel.SetText('');
            Captcha.Refresh();

            if (s.GetSelectedIndex() == 0) {
                TabbedGroup.SetActiveTabIndex(s.GetSelectedIndex());
            }
            else {
                TabbedGroup.SetActiveTabIndex(1);
            }
        }

        function GetPasswordButtonClick() {

            if (NewPasswordRadioButtonList.GetSelectedIndex() == 0) {

                if (NewPasswordEmailTB.GetValue() == null) {
                    ErrorLabel.SetText('Введите Email');
                }
                else if (NewPasswordEmailTB.isValid == false) {
                    ErrorLabel.SetText('Введите корректный Email');
                }
                else {
                    SendRequestNewPassword(NewPasswordRadioButtonList.GetSelectedIndex());
                }
            }
            else if (NewPasswordRadioButtonList.GetSelectedIndex() > 0) {

                if (NewPasswordSMSTB.GetValue() == null) {
                    ErrorLabel.SetText('Введите номер телефона');
                }
                else if (NewPasswordSMSTB.isValid == false) {
                    ErrorLabel.SetText('Введите корректный номер телефона');
                }
                else {
                    SendRequestNewPassword(NewPasswordRadioButtonList.GetSelectedIndex());
                }
            }
            else {
                ErrorLabel.SetText('Выберите способ восстановления пароля');
            }
        }

        function SendRequestNewPassword(vl) {
            ErrorLabel.SetText('');
            LoadingPanel.Show();
            CBackNewPassword.PerformCallback(vl);
        }

        function CBackNewPasswordResult(vl) {

            LoadingPanel.Hide();

            if (vl.split('|')[0] == '0') {
                ErrorLabel.SetText(vl.split('|')[1]);
                //Captcha.Refresh();
            }
            else if (vl.split('|')[0] == '1') {
                ForgetPasswordPopup.Hide();
                alert(vl.split('|')[1]);
            }

        }

        //Закрытие popup
        function ForgetPasswordPopupClosing() {
            NewPasswordRadioButtonList.SetSelectedIndex(0);
            TabbedGroup.SetActiveTabIndex(0);
            NewPasswordEmailTB.SetValue(null);
            NewPasswordSMSTB.SetValue(null);
            ErrorLabel.SetText('');
            Captcha.Refresh();

            LoginButton.SetEnabled(true);
            GetPasswordButton.SetEnabled(false);
        }

    </script>

</asp:Content>
