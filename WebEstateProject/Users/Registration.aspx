<%@ Page Title="Регистрация" Language="vb" AutoEventWireup="false" MasterPageFile="~/DeepWeb.Master" CodeBehind="Registration.aspx.vb" Inherits="WebEstateProject.Registration" %>

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <dx:ASPxHiddenField ID="HiddenField" ClientInstanceName="HiddenField" runat="server" />

    <dx:ASPxFormLayout ID="RegistrationForm" runat="server" Width="100%">
        <ClientSideEvents Init="function(s,e){ s.SetHeight (window.innerHeight - TopPanel.GetHeight() - BottomPanel.GetHeight() - 60); }" />
        <Items>
            <dx:LayoutGroup Caption="Регистрация нового пользователя" HorizontalAlign="center" Paddings-PaddingTop="20" Paddings-PaddingLeft="30" Paddings-PaddingRight="30">
                <GridSettings StretchLastItem="True" WrapCaptionAtWidth="500" />
                <Items>

                    <dx:LayoutItem Caption="Фамилия">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="LastNameTB" runat="server" Width="100%">
                                    <ValidationSettings SetFocusOnError="true" Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                        <RequiredField IsRequired="True" ErrorText="Введите данные" />
                                        <ErrorFrameStyle Font-Size="Smaller" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Имя">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="FirstNameTB" runat="server"  Width="100%">
                                    <ValidationSettings SetFocusOnError="true" Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                        <RequiredField IsRequired="True" ErrorText="Введите данные" />
                                        <ErrorFrameStyle Font-Size="Smaller" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Отчество">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="SecondNameTB" runat="server"  Width="100%" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Дата рождения">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxDateEdit ID="BirthDateDE" runat="server" Width="100%">
                                    <ValidationSettings SetFocusOnError="true" Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                        <RequiredField IsRequired="True" ErrorText="Введите данные" />
                                        <ErrorFrameStyle Font-Size="Smaller" />
                                    </ValidationSettings>
                                </dx:ASPxDateEdit>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Телефон">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="PhoneTB" ClientInstanceName="PhoneTB" runat="server" SelectInputTextOnClick="true"  Width="100%" ValidationSettings-RequiredField-IsRequired="true">
                                    <MaskSettings Mask="+7 (999) 000-00-00" IncludeLiterals="None" ErrorText="Некорректный номер телефона" />
                                    <ValidationSettings SetFocusOnError="true" Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom" >
                                        <ErrorFrameStyle Font-Size="Smaller" />
                                    </ValidationSettings>
                                    <ClientSideEvents TextChanged="function(s,e){ HiddenField.Set('ConfirmPhoneStatus', '0'); 
                                        ConfirmPhoneButton.SetText('Подтвердить телефон');
                                        ConfirmPhoneButton.SetEnabled(1); }" />
                                </dx:ASPxTextBox>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Right">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxButton ID="ConfirmPhoneButton" ClientInstanceName="ConfirmPhoneButton" runat="server" RenderMode="Link" Text="Подтвердить телефон" 
                                    AutoPostBack="false" Font-Size="Smaller" ValidationContainerID="PhoneTB">
                                    <ClientSideEvents Click="function(s,e){ ErrorLabel.SetText(''); if(PhoneTB.isValid) { ConfirmCBack.PerformCallback('2|' + PhoneTB.GetValue()) } }" />
                                    <DisabledStyle ForeColor="Green" />
                                </dx:ASPxButton>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Электронная почта">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="LoginEmailTB" ClientInstanceName="LoginEmailTB" runat="server"  Width="100%" >
                                    <ValidationSettings SetFocusOnError="true" Display="Dynamic" ErrorTextPosition="Bottom" ErrorDisplayMode="Text">
                                        <RegularExpression ErrorText="Некорректные данные" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                        <RequiredField IsRequired="True" ErrorText="Введите e-mail" />
                                        <ErrorFrameStyle Font-Size="Smaller" />
                                    </ValidationSettings>
                                    <ClientSideEvents TextChanged="function(s,e){ HiddenField.Set('ConfirmEmailStatus', '0'); 
                                        ConfirmEmailButton.SetText('Подтвердить e-mail');
                                        ConfirmEmailButton.SetEnabled(1); }" />
                                </dx:ASPxTextBox>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Right">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxButton ID="ConfirmEmailButton" ClientInstanceName="ConfirmEmailButton" runat="server" RenderMode="Link" Text="Подтвердить e-mail" 
                                    AutoPostBack="false" Font-Size="Smaller" ValidationContainerID="LoginEmailTB">
                                    <ClientSideEvents Click="function(s,e){ ErrorLabel.SetText(''); if(LoginEmailTB.isValid) { ConfirmCBack.PerformCallback('1|' + LoginEmailTB.GetText()) } }" />
                                    <DisabledStyle ForeColor="Green" />
                                </dx:ASPxButton>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>


                    <dx:LayoutItem Caption="Пароль">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="PasswordTB" ClientInstanceName="PasswordTB" runat="server" Password="true"  Width="100%" >
                                    <ValidationSettings SetFocusOnError="true" Display="Dynamic" ErrorTextPosition="Bottom" ErrorDisplayMode="Text">
                                        <RequiredField IsRequired="True" ErrorText="Введите пароль" />
                                        <ErrorFrameStyle Font-Size="Smaller" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Подтвердите пароль">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="ConfirmPasswordTB" ClientInstanceName="ConfirmPasswordTB" runat="server" Password="true"  Width="100%" >
                                    <ValidationSettings SetFocusOnError="true" Display="Dynamic" ErrorTextPosition="Bottom" ErrorDisplayMode="Text">
                                        <RequiredField IsRequired="True" ErrorText="Введите пароль" />
                                        <ErrorFrameStyle Font-Size="Smaller" />                                        
                                    </ValidationSettings>
                                    <ClientSideEvents Validation="function(s,e){ OnPassValidation(s,e); }" />
                                </dx:ASPxTextBox>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem ShowCaption="False" ParentContainerStyle-Paddings-PaddingTop="20" HorizontalAlign="Center">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxCaptcha ID="Captcha" runat="server" TextBox-Position="Bottom"  >
                                    <ValidationSettings SetFocusOnError="true" ErrorDisplayMode="Text" Display="Dynamic" EnableValidation="true"  />
                                    <ChallengeImage  Height="70" />
                                    <RefreshButton ShowImage="false" />
                                    <TextBoxStyle  />
                                </dx:ASPxCaptcha>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center" Paddings-PaddingTop="20">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxButton ID="RegistrationButton" runat="server" Text="Зарегистрироваться" AutoPostBack="false" UseSubmitBehavior="true" OnClick="RegistrationButton_Click" />                                

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxLabel ID="ErrorLabel" ClientInstanceName="ErrorLabel" runat="server" Text="" Width="100%" ForeColor="Red" Font-Size="Smaller" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>

    <dx:ASPxPopupControl ID="ConfirmEmailPopup" ClientInstanceName="ConfirmEmailPopup" runat="server" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
        HeaderText="Подтверждение e-mail" Modal="true" AutoUpdatePosition="true" CloseAction="CloseButton" >
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">

                <dx:ASPxLabel ID="ConfirmEmailLabel" runat="server" Width="250" 
                    Text="На электронную почту отправлен код подтверждения. Введите указанный в письме код и нажмите кнопку 'Подтвердить'" />

                <dx:ASPxTextBox ID="ConfirmEmailCodeTB" ClientInstanceName="ConfirmEmailCodeTB" runat="server" Width="250" Style="margin-top: 10px" NullText="Введите код">
                    <ValidationSettings SetFocusOnError="true" Display="Dynamic" ErrorTextPosition="Bottom" ErrorDisplayMode="Text">
                        <ErrorFrameStyle Font-Size="Smaller" />
                    </ValidationSettings>
                    <ClientSideEvents Validation="function(s,e){ OnEmailCodeValidation(s,e); }" />
                </dx:ASPxTextBox>

                <dx:ASPxButton ID="CheckEmailButton" runat="server" Text="Подтвердить" AutoPostBack="false" Width="250" Style="margin-top:10px" ValidationContainerID="ConfirmEmailCodeTB">
                    <ClientSideEvents Click="function(s,e){ if(ConfirmEmailCodeTB.isValid) { CheckEmailButtonClick(); } }" />
                </dx:ASPxButton>

            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

    <dx:ASPxPopupControl ID="ConfirmPhonePopup" ClientInstanceName="ConfirmPhonePopup" runat="server" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
        HeaderText="Подтверждение телефона" Modal="true" AutoUpdatePosition="true" CloseAction="CloseButton">
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">

                <dx:ASPxLabel ID="ConfirmPopupLabel" runat="server" Width="250" 
                    Text="На указанный номер телефона сейчас поступит звонок. Пожалуйста, введите ниже последние 6 цифр номера телефона и нажмите кнопку 'Подтвердить'" />

                <dx:ASPxTextBox ID="ConfirmPhoneCodeTB" ClientInstanceName="ConfirmPhoneCodeTB" runat="server" Width="250" Style="margin-top: 10px" NullText="Введите код">
                    <ValidationSettings SetFocusOnError="true" Display="Dynamic" ErrorTextPosition="Bottom" ErrorDisplayMode="Text">
                        <ErrorFrameStyle Font-Size="Smaller" />
                    </ValidationSettings>
                    <ClientSideEvents Validation="function(s,e){ OnPhoneCodeValidation(s,e); }" />
                </dx:ASPxTextBox>

                <dx:ASPxButton ID="CheckPhoneButton" runat="server" Text="Подтвердить" AutoPostBack="false" Width="250" Style="margin-top:10px" ValidationContainerID="ConfirmPhoneCodeTB">
                    <ClientSideEvents Click="function(s,e){ if(ConfirmPhoneCodeTB.isValid) { CheckPhoneButtonClick(); } }" />
                </dx:ASPxButton>

            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>



    <dx:ASPxCallback ID="ConfirmCBack" ClientInstanceName="ConfirmCBack" runat="server" OnCallback="ConfirmCBack_Callback">
        <ClientSideEvents CallbackComplete="function(s,e){ ConfirmCBackResult(e.result); }" />
    </dx:ASPxCallback>

    <script type="text/javascript">

        //Подтверждение пароля
        function OnPassValidation(s, e) {

            if (PasswordTB.GetText() != ConfirmPasswordTB.GetText()) {
                e.isValid = false;
                e.errorText = "Пароли не совпадают!";
            }
        }

        function ConfirmCBackResult(vl) {

            // Подтверждение email
            if (vl.startsWith('1') == true) {
                HiddenField.Set("ConfirmEmailCode", vl.substring(2));
                ConfirmEmailPopup.Show();
            }
            // Подтверждение телефона
            else if (vl.startsWith('2') == true) {
                HiddenField.Set("ConfirmPhoneCode", vl.substring(2));
                ConfirmPhonePopup.Show();
            }
            // Ошибка
            else if (vl.startsWith('0') == true) {
                ErrorLabel.SetText(vl.substring(2));
            }
        }

        //Подтверждение email
        function CheckEmailButtonClick() {
            if (ConfirmEmailCodeTB.GetText() == HiddenField.Get('ConfirmEmailCode')) {
                HiddenField.Set("ConfirmEmailStatus", "1");
                ConfirmEmailPopup.Hide();
                ConfirmEmailButton.SetText('e-mail подтвержден');
                ConfirmEmailButton.SetEnabled(0);
            }
        }

        function OnEmailCodeValidation(s, e) {

            if (ConfirmEmailCodeTB.GetText() == "") {
                e.isValid = false;
                e.errorText = "Введите код";
            }
            else if (ConfirmEmailCodeTB.GetText() != HiddenField.Get('ConfirmEmailCode')) {
                e.isValid = false;
                e.errorText = "Неверный код!";
            }

        }


        //Подтверждение телефона

        function CheckPhoneButtonClick() {
            if (ConfirmPhoneCodeTB.GetText() == HiddenField.Get('ConfirmPhoneCode')) {
                HiddenField.Set("ConfirmPhoneStatus", "1");
                ConfirmPhonePopup.Hide();
                ConfirmPhoneButton.SetText('Телефон подтвержден');
                ConfirmPhoneButton.SetEnabled(0);
            }
        }

        function OnPhoneCodeValidation(s, e) {
            if (ConfirmPhoneCodeTB.GetText() == "") {
                e.isValid = false;
                e.errorText = "Введите код";
            }
            else if (ConfirmPhoneCodeTB.GetText() != HiddenField.Get('ConfirmPhoneCode')) {
                e.isValid = false;
                e.errorText = "Неверный код!";
            }
        }

    </script>

</asp:Content>
