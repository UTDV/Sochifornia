<%@ Page Title="Регистрация" Language="vb" AutoEventWireup="false" MasterPageFile="~/DeepWeb.Master" CodeBehind="Registration.aspx.vb" Inherits="WebEstateProject.Registration" %>

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <dx:ASPxFormLayout ID="RegistrationForm" runat="server" Width="100%">
        <ClientSideEvents Init="function(s,e){ s.SetHeight (window.innerHeight - TopPanel.GetHeight() - 60); }" />
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
                                    <MaskSettings Mask="+7 (000) 000-00-00" IncludeLiterals="None" ErrorText="Некорректный номер телефона" />
                                    <ValidationSettings SetFocusOnError="true" Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom" >
                                        <ErrorFrameStyle Font-Size="Smaller" />
                                    </ValidationSettings>
                                    <ClientSideEvents TextChanged="function(s,e){ ConfirmPhoneButton.SetText('Подтвердить телефон');
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
                                    <ClientSideEvents Click="function(s,e){ ErrorLabel.SetText(''); if(PhoneTB.isValid) { LoadingPanel.Show(); ConfirmCBack.PerformCallback('2|' + PhoneTB.GetValue()) } }" />
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
                                    <ClientSideEvents TextChanged="function(s,e){ ConfirmEmailButton.SetText('Подтвердить e-mail');
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
                                    <ClientSideEvents Click="function(s,e){ ErrorLabel.SetText(''); if(LoginEmailTB.isValid) { LoadingPanel.Show(); ConfirmCBack.PerformCallback('1|' + LoginEmailTB.GetText()) } }" />
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

        <ClientSideEvents PopUp="function(s,e) { ConfirmEmailCodeTB.Focus(); }" Closing="function(s,e) { ConfirmEmailPopupClosing(); }" />

        <ContentCollection>
            <dx:PopupControlContentControl runat="server">

                <dx:ASPxLabel ID="ConfirmEmailLabel" runat="server" Width="250" 
                    Text="На электронную почту отправлен код подтверждения. Введите указанный в письме код и нажмите кнопку 'Подтвердить'" />

                <dx:ASPxTextBox ID="ConfirmEmailCodeTB" ClientInstanceName="ConfirmEmailCodeTB" runat="server" Width="250" Style="margin-top: 10px" NullText="Введите код" />

                <dx:ASPxButton ID="CheckEmailButton" runat="server" Text="Подтвердить" AutoPostBack="false" Width="250" Style="margin-top:10px" CausesValidation="false">
                    <ClientSideEvents Click="function(s,e){ if(ConfirmEmailCodeTB.GetValue() != null) { CheckEmailButtonClick(); } }" />
                </dx:ASPxButton>

                <span id="ErrorCheckCodeEmailText" style="color:red; text-align:center; font-size:smaller;"></span>

            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

    <dx:ASPxPopupControl ID="ConfirmPhonePopup" ClientInstanceName="ConfirmPhonePopup" runat="server" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
        HeaderText="Подтверждение телефона" Modal="true" AutoUpdatePosition="true" CloseAction="CloseButton" ContentStyle-Paddings-Padding="20">

        <ClientSideEvents PopUp="function(s,e) { ConfirmPhoneCodeTB.Focus(); }" Closing="function(s,e) { ConfirmPhonePopupCloseing(); }" />

        <ContentCollection>
            <dx:PopupControlContentControl runat="server">               

                <p style="text-align:justify">
                    На указанный номер телефона сейчас поступит звонок. Пожалуйста, введите ниже последние 6 цифр номера телефона
                </p>

                <dx:ASPxTextBox ID="ConfirmPhoneCodeTB" ClientInstanceName="ConfirmPhoneCodeTB" runat="server" Width="250">                   
                    <ClientSideEvents UserInput="function(s,e) { ConfirmPhoneCodeTBInput(); }" />
                </dx:ASPxTextBox>

                <span id="ErrorCheckCodeText" style="color:red; text-align:center; font-size:smaller;"></span>

                <section class="d-block text-center mt-2">
                    <dx:ASPxButton ID="GetSMSButton" runat="server" AutoPostBack="false" Text="Не поступил звонок?" RenderMode="Link" CausesValidation="false">
                        <ClientSideEvents Click="function(s,e) { GetSMSButtonClick(); }" />
                    </dx:ASPxButton>
                </section>                               

            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

    <dx:ASPxPopupControl ID="ConfirmSMSPopup" ClientInstanceName="ConfirmSMSPopup" runat="server" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
        HeaderText="Подтверждение телефона" Modal="true" AutoUpdatePosition="true" CloseAction="CloseButton" ContentStyle-Paddings-Padding="20">

        <ClientSideEvents PopUp="function(s,e) { ConfirmSMSCodeTB.Focus(); }" Closing="function(s,e) { ConfirmSMSPopupClosing(); }" />

        <ContentCollection>
            <dx:PopupControlContentControl runat="server">               

                <p style="text-align:justify">
                    На телефон отправлено СМС-сообщение. Введите код, указанный в СМС:
                </p>

                <dx:ASPxTextBox ID="ConfirmSMSCodeTB" ClientInstanceName="ConfirmSMSCodeTB" runat="server" Width="250">                   
                    <ClientSideEvents UserInput="function(s,e) { ConfirmSMSCodeTBInput(); }" />
                </dx:ASPxTextBox>

                <span id="ErrorCheckSMSCodeText" style="color:red; text-align:center; font-size:smaller;"></span>                                               

            </dx:PopupControlContentControl>
        </ContentCollection>

    </dx:ASPxPopupControl>


    <dx:ASPxLoadingPanel ID="LoadingPanel" ClientInstanceName="LoadingPanel" runat="server" Modal="true" />


    <dx:ASPxCallback ID="ConfirmCBack" ClientInstanceName="ConfirmCBack" runat="server" OnCallback="ConfirmCBack_Callback">
        <ClientSideEvents CallbackComplete="function(s,e){ ConfirmCBackResult(e.result); }" />
    </dx:ASPxCallback>

    <dx:ASPxCallback ID="CBackCheckCode" ClientInstanceName="CBackCheckCode" runat="server" OnCallback="CBackCheckCode_Callback">
        <ClientSideEvents CallbackComplete="function(s,e) { CBackCheckCodedResult(e.result); }" />
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

            LoadingPanel.Hide();

            // Подтверждение email
            if (vl.split("|")[0] == '1') {
                ConfirmEmailPopup.Show();
            }
            // Подтверждение телефона
            else if (vl.split("|")[0] == '2') {
                ConfirmPhonePopup.Show();
            }
            // Подтверждение телефона по СМС
            else if (vl.split("|")[0] == '3') {
                ConfirmPhonePopup.Hide();
                ConfirmSMSPopup.Show();
            }
            // Ошибка Подтверждение телефона по СМС
            else if (vl.split("|")[0] == '4') {
                document.getElementById("ErrorCheckCodeText").innerHTML = vl.split("|")[1];
            }
            // Ошибка
            else if (vl.split("|")[0] == '0') {
                ErrorLabel.SetText(vl.split("|")[1]);
            }
        }

        //Подтверждение email

        function ConfirmEmailPopupClosing() {

            ConfirmEmailCodeTB.SetValue(null);
            document.getElementById("ErrorCheckCodeEmailText").innerHTML = '';
        }

        function CheckEmailButtonClick() {

            document.getElementById("ErrorCheckCodeEmailText").innerHTML = '';
            LoadingPanel.Show();
            CBackCheckCode.PerformCallback('Email|' + ConfirmEmailCodeTB.GetText());
        }

        


        //Подтверждение телефона

        function ConfirmPhonePopupCloseing() {
            ConfirmPhoneCodeTB.SetValue(null);
            document.getElementById("ErrorCheckCodeText").innerHTML = '';
        }

        function ConfirmPhoneCodeTBInput() {           

            if (ConfirmPhoneCodeTB.GetText().length == 6) {

                ConfirmPhoneCodeTB.SetEnabled(0);
                document.getElementById("ErrorCheckCodeText").innerHTML = '';
                LoadingPanel.Show();
                CBackCheckCode.PerformCallback('PhoneCall|' + ConfirmPhoneCodeTB.GetText());
            }
        }        



        // Подтверждение телефона по СМС

        function GetSMSButtonClick() {

            document.getElementById("ErrorCheckCodeText").innerHTML = '';
            LoadingPanel.Show();
            ConfirmCBack.PerformCallback('3|' + PhoneTB.GetValue());
        }

        function ConfirmSMSPopupClosing() {

            ConfirmSMSCodeTB.SetValue(null);
            document.getElementById("ErrorCheckSMSCodeText").innerHTML = '';
        }

        function ConfirmSMSCodeTBInput() {

            if (ConfirmSMSCodeTB.GetText().length == 4) {

                ConfirmSMSCodeTB.SetEnabled(0);
                document.getElementById("ErrorCheckSMSCodeText").innerHTML = '';
                LoadingPanel.Show();
                CBackCheckCode.PerformCallback('PhoneSMS|' + ConfirmSMSCodeTB.GetText());
            }
        }



        //Результат проверки кода

        function CBackCheckCodedResult(vl) {
            
            LoadingPanel.Hide();

            //Результат проверки телефона
            if (vl.split("|")[0] == "PhoneCall") {

                if (vl.split("|")[1] == "1") {
                    ConfirmPhonePopup.Hide();
                    ConfirmPhoneButton.SetText('Телефон подтвержден');
                    ConfirmPhoneButton.SetEnabled(0);
                }
                else if (vl.split("|")[1] == "0") {
                    ConfirmPhoneCodeTB.SetEnabled(1);
                    document.getElementById("ErrorCheckCodeText").innerHTML = 'Неверный код!';
                }
            }
            //Результат проверки телефона по СМС
            else if (vl.split("|")[0] == 'PhoneSMS') {

                if (vl.split("|")[1] == "1") {
                    ConfirmSMSPopup.Hide();
                    ConfirmPhoneButton.SetText('Телефон подтвержден');
                    ConfirmPhoneButton.SetEnabled(0);
                }
                else if (vl.split("|")[1] == "0") {
                    ConfirmSMSCodeTB.SetEnabled(1);
                    document.getElementById("ErrorCheckSMSCodeText").innerHTML = 'Неверный код!';
                }
            }
            //Результат проверки Email
            else if (vl.split("|")[0] == 'Email') {

                if (vl.split("|")[1] == "1") {
                    ConfirmEmailPopup.Hide();
                    ConfirmEmailButton.SetText('e-mail подтвержден');
                    ConfirmEmailButton.SetEnabled(0);
                }
                else if (vl.split("|")[1] == "0") {

                    document.getElementById("ErrorCheckCodeEmailText").innerHTML = 'Неверный код!';
                }
            }

        }

    </script>

</asp:Content>
