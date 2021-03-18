<%@ Page Title="Личный кабинет" Language="vb" AutoEventWireup="false" MasterPageFile="~/DeepWeb.Master" CodeBehind="PersonalData.aspx.vb" Inherits="WebEstateProject.ConfirmUserData" %>

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <dx:ASPxGlobalEvents ID="ASPxGlobalEvents1" runat="server" ClientSideEvents-ControlsInitialized="function(s,e){ onControlsInitialized(); }" />

    <dx:ASPxFormLayout ID="FormLayout" ClientInstanceName="FormLayout" runat="server"  DataSourceID="PersonalDataDS" ColumnCount="2" Width="100%" >
        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="800" />
        <ClientSideEvents Init="function(s,e){ s.SetHeight (window.innerHeight - TopPanel.GetHeight() - BottomPanel.GetHeight() - 60); }" />
        <Items>

            <dx:LayoutGroup ShowCaption="False" GroupBoxDecoration="Box" ColumnSpan="1" HorizontalAlign="center" Width="20%"   >
                <Items>

                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                
                                <dx:ASPxCallbackPanel ID="ImageCallBack" ClientInstanceName="ImageCallBack" runat="server" EnableCallbackAnimation="true">
                                    <PanelCollection>
                                        <dx:PanelContent runat="server">


                                            <dx:ASPxBinaryImage ID="AvatarBI" runat="server" Width="200" Height="150" EnableServerResize="true" EmptyImage-Url="~/Content/UsersContent/DefaultAvatar.png" />

                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxCallbackPanel>                                

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                
                                <dx:ASPxUploadControl ID="AvatarUpload" runat="server" ShowTextBox="false" BrowseButton-Text="Изменить..." AutoStartUpload="true" 
                                    AdvancedModeSettings-EnableMultiSelect="false" OnFileUploadComplete="AvatarUpload_FileUploadComplete"   >
                                    <BrowseButtonStyle BackColor="Transparent" Border-BorderStyle="None" HoverStyle-ForeColor="#000066" ForeColor="#17293F" >
                                        <PressedStyle ForeColor="#3366cc" />
                                    </BrowseButtonStyle>
                                    <ValidationSettings AllowedFileExtensions=".png,.jpg,.jpeg" />
                                    <ClientSideEvents FileUploadComplete="function(s,e){ ImageCallBack.PerformCallback(); }" />
                                </dx:ASPxUploadControl>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    

                </Items>
            </dx:LayoutGroup>

            <dx:LayoutGroup ShowCaption="False" GroupBoxDecoration="None" ColumnSpan="1" HorizontalAlign="left" Width="60%"  >
                <Items>

                    <dx:LayoutItem Caption="E-mail" FieldName="Email"  >
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="EmailTB" runat="server" ReadOnly="true" EnableFocusedStyle="false" Cursor="auto" Enabled="false" CssClass="PersonalDataClass"   />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Телефон" FieldName="Phone">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="PhoneTB" runat="server" ReadOnly="true" EnableFocusedStyle="false" Cursor="auto" DisplayFormatString="+0 (000) 000-00-00" Enabled="false" CssClass="PersonalDataClass" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Роль" FieldName="Role">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="RoleTB" runat="server" ReadOnly="true" EnableFocusedStyle="false" Cursor="auto" Enabled="false" CssClass="PersonalDataClass" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Статус" FieldName="Status">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="StatusTB" runat="server" ReadOnly="true" EnableFocusedStyle="false" Cursor="auto" Enabled="false" CssClass="PersonalDataClass" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Фамилия" FieldName="LastName">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="LastNameTB" runat="server" CssClass="PersonalDataClass"  >
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                        <RequiredField IsRequired="True" ErrorText="Введите данные" />
                                        <ErrorFrameStyle Font-Size="Smaller" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Имя" FieldName="FirstName">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="FirstNameTB" runat="server" CssClass="PersonalDataClass"  >
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                        <RequiredField IsRequired="True" ErrorText="Введите данные" />
                                        <ErrorFrameStyle Font-Size="Smaller" />
                                    </ValidationSettings>
                                </dx:ASPxTextBox>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Отчество" FieldName="SecondName">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="SecondNameTB" runat="server" CssClass="PersonalDataClass"  />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Дата рождения" FieldName="BirthDate">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxDateEdit ID="BirthDateDE" runat="server"  ClearButton-DisplayMode="never" DropDownButton-ClientVisible="false" CssClass="PersonalDataClass" >
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="Text" ErrorTextPosition="Bottom">
                                        <RequiredField IsRequired="True" ErrorText="Введите данные" />
                                        <ErrorFrameStyle Font-Size="Smaller" />
                                    </ValidationSettings>
                                </dx:ASPxDateEdit>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="WhatsApp" FieldName="WhatsApp">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="WhatsAppTB" runat="server" MaxLength="10" DisplayFormatString="+7 (000) 000-00-00" SelectInputTextOnClick="true" CssClass="PersonalDataClass" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Telegram" FieldName="Telegram">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="TelegramTB" runat="server" CssClass="PersonalDataClass"  />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="ВКонтакте" FieldName="VK">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="VKTB" runat="server" CssClass="PersonalDataClass" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Facebook" FieldName="Facebook">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="FacebookTB" runat="server" CssClass="PersonalDataClass"  />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Instagram" FieldName="Instagram">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="InstagramTB" runat="server" CssClass="PersonalDataClass" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center" ParentContainerStyle-Paddings-PaddingTop="20">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxButton ID="SaveButton" ClientInstanceName="SaveButton" runat="server" AutoPostBack="false" Text="Сохранить изменения" ClientEnabled="false" OnClick="SaveButton_Click" 
                                    UseSubmitBehavior="true">
                                    <ClientSideEvents Click="function(s,e){ onSubmitForm(); }" />
                                </dx:ASPxButton>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                </Items>
            </dx:LayoutGroup>



        </Items>
    </dx:ASPxFormLayout>

    <asp:SqlDataSource ID="PersonalDataDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>' 
        SelectCommand="exec [dbo].GetPersonalData @GUID">
        <SelectParameters>
            <asp:SessionParameter SessionField="GUID" Name="GUID" DbType="Guid" />
        </SelectParameters>
    </asp:SqlDataSource>

    <script type="text/javascript">

        var isDirty = false;
        var initialState = {};

        function onControlsInitialized() {
            ASPxClientEdit.AttachEditorModificationListener(onEditorsChanged, function (control) {
                return control.GetParentControl() === FormLayout 
            });
            ASPxClientUtils.AttachEventToElement(window, "beforeunload", onBeforeUnload);
            initialState = ASPxClientUtils.GetEditorValuesInContainer(FormLayout.GetMainElement());
        }

        function onEditorsChanged(s, e) {
            SaveButton.SetEnabled(true);
            //CancelButton.SetEnabled(true);
            isDirty = true;
        }

        function cancelChanges(s, e) {
            ASPxClientUtils.SetEditorValues(initialState);
            isDirty = false;
            SaveButton.SetEnabled(false);
            CancelButton.SetEnabled(false);
        }

        function onBeforeUnload(e) {
            if (!isDirty)
                return;
            e.returnValue = "";
        }
        function onSubmitForm() {
            isDirty = false;
        }

    </script>

</asp:Content>
