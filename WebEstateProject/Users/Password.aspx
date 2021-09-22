<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/DeepWeb.Master" CodeBehind="Password.aspx.vb" Inherits="WebEstateProject.Password" %>

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style type="text/css">
        .www{
            max-width: 200px !important;
        }
    </style>

    <section style="text-align: center; margin-top:20px;">
        <dx:ASPxLabel ID="InfoLabel" runat="server" Text="" />
    </section>

    <dx:ASPxFormLayout ID="ChangePasswordForm" runat="server" Width="100%" >
        <Items>

            <dx:LayoutGroup Name="group" Caption="" HorizontalAlign="center" Paddings-PaddingLeft="30" Paddings-PaddingRight="30" SettingsItemCaptions-Location="Top">
                <Items>

                    <dx:LayoutItem Caption="Введите новый пароль">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="PasswordOneTB" ClientInstanceName="PasswordOneTB" runat="server" Password="true" Width="200">
                                    <ValidationSettings SetFocusOnError="true" Display="Dynamic" ErrorTextPosition="Bottom" ErrorDisplayMode="Text">
                                        <RegularExpression ValidationExpression="^.{5,}$" ErrorText="Пароль должен быть не менее 5 символов" />
                                        <RequiredField IsRequired="True" ErrorText="Введите новый пароль" />
                                        <ErrorFrameStyle Font-Size="Smaller" Wrap="True" CssClass="www"  />
                                    </ValidationSettings>                                    
                                </dx:ASPxTextBox>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Повторите пароль">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="PasswordTwoTB" ClientInstanceName="PasswordTwoTB" runat="server" Password="true" Width="200">
                                    <ClientSideEvents Validation="function(s,e) { PasswordTwoTBValidation(s,e); }" />
                                    <ValidationSettings SetFocusOnError="true" Display="Dynamic" ErrorTextPosition="Bottom" ErrorDisplayMode="Text" 
                                        ErrorText="Пароли не совпадают">
                                        
                                        <RequiredField IsRequired="True" ErrorText="Повторите пароль" />
                                        <ErrorFrameStyle Font-Size="Smaller" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center" Paddings-PaddingTop="20">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxButton ID="ChangePasswordButton" ClientInstanceName="ChangePasswordButton" runat="server" Text="Изменить"
                                    Width="200" AutoPostBack="false" UseSubmitBehavior="true" >
                                    <ClientSideEvents Click="function(s,e) { ChangePasswordButtonClick(); }" />
                                </dx:ASPxButton>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxLabel ID="ErrorLabel" ClientInstanceName="ErrorLabel" runat="server" Text="" Width="100%" ForeColor="Red" Font-Size="Smaller"  />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                </Items>
            </dx:LayoutGroup>

        </Items>
    </dx:ASPxFormLayout>


    <dx:ASPxPopupControl ID="RequestResultPopup" ClientInstanceName="RequestResultPopup" runat="server" HeaderText="" AutoUpdatePosition="true"
        CloseAction="None" Modal="true" ShowCloseButton="false">
        <SettingsAdaptivity Mode="Always" VerticalAlign="WindowTop" HorizontalAlign="WindowCenter" MaxWidth="400" FixedFooter="false" FixedHeader="false" />
        
        <ClientSideEvents PopUp="function(s,e) { Timer.SetEnabled(true); }" />
        
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">

                <p style="text-align: center; font-size: medium; margin-top: -20px;">
                    Пароль успешно изменен!
                    <br />
                    <br />
                    Вы будете перенаправлены на страницу входа через <span id="demoCountdown"
                        style="color: #59A1E9;">&nbsp;</span> секунд
                </p>

            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>


    <dx:ASPxTimer ID="Timer" ClientInstanceName="Timer" runat="server" Interval="1000" Enabled="false">
        <ClientSideEvents Init="function(s,e){  }" Tick="function(s,e){ demoTick(); }" />
    </dx:ASPxTimer>

    <dx:ASPxLoadingPanel ID="LoadingPanel" ClientInstanceName="LoadingPanel" runat="server" Modal="true" />


    <dx:ASPxCallback ID="CBackChangePassword" ClientInstanceName="CBackChangePassword" runat="server" OnCallback="CBackChangePassword_Callback">
        <ClientSideEvents CallbackComplete="function(s,e){ CBackChangePasswordResult(e.result); }" />
    </dx:ASPxCallback>



    <script type="text/javascript">

        var demoCounter;
        demoCounter = 5;
        document.getElementById("demoCountdown").innerHTML = demoCounter;

        function PasswordTwoTBValidation(s,e) {
            var name = e.value;
            if (name == null)
                return;
            if (name != PasswordOneTB.GetValue())
                e.isValid = false;
        }

        function ChangePasswordButtonClick() {

            ErrorLabel.SetText('');

            if (PasswordOneTB.isValid && PasswordTwoTB.isValid) {

                LoadingPanel.Show();
                CBackChangePassword.PerformCallback();
            }
        }

        function CBackChangePasswordResult(vl) {

            LoadingPanel.Hide();

            if (vl == '1') {

                RequestResultPopup.Show();
            }
            else {

                ErrorLabel.SetText('Что-то пошло не так...');
            }
        }



        //Таймер
        function demoInit() {
            demoCounter = 5;
            demoUpdate();
        }

        function demoUpdate() {
            if (demoCounter > 0) {
                document.getElementById("demoCountdown").innerHTML = demoCounter;
            }
            else {
                Timer.SetEnabled(false);
                window.open('/Users/LoginUser.aspx', '_self');
            }
        }

        function demoTick() {
            demoCounter -= 1;
            demoUpdate();
        }

    </script>

</asp:Content>
