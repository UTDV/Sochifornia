 <%@ Page Title="Список пользователей" Language="vb" AutoEventWireup="false" MasterPageFile="~/DeepWeb.Master" CodeBehind="UsersList.aspx.vb" Inherits="WebEstateProject.UsersList" %>

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <dx:ASPxGridView ID="UseresListGrid" ClientInstanceName="UseresListGrid" runat="server" Width="100%"    
        DataSourceID="UseresListDS" KeyFieldName="id" AutoGenerateColumns="False" Styles-Cell-Paddings-Padding="5px" CssClass="PropertyRegisterFontSize"   
        Settings-AutoFilterCondition="Contains"  SettingsBehavior-AllowEllipsisInText="true" Styles-Header-Wrap="True" >

        <StylesToolbar>
            <Item CssClass="PropertyRegisterFontSize" />
        </StylesToolbar>

        <Settings VerticalScrollBarMode="Hidden" ShowHeaderFilterButton="True" ShowFilterRow="true" />

        <SettingsPager PageSize="15" />

        <SettingsBehavior AllowFocusedRow="true" EnableCustomizationWindow="true" />

        <SettingsEditing Mode="EditForm" />

        <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true" AllowHideDataCellsByColumnMinWidth="true"  />

        <SettingsDataSecurity AllowDelete="false" AllowEdit="true"/>

        <EditFormLayoutProperties ColumnCount="3">
            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="1000" />
            <Items>

                <dx:GridViewLayoutGroup ColumnSpan="1" GroupBoxDecoration="None">
                    <Items>

                        <dx:GridViewColumnLayoutItem ColumnName="LastName" />
                        <dx:GridViewColumnLayoutItem ColumnName="FirstName" />
                        <dx:GridViewColumnLayoutItem ColumnName="SecondName" />
                        <dx:GridViewColumnLayoutItem ColumnName="BirthDate" />
                        <dx:GridViewColumnLayoutItem ColumnName="Role" />

                    </Items>
                </dx:GridViewLayoutGroup>

                <dx:GridViewLayoutGroup ColumnSpan="1" GroupBoxDecoration="None">
                    <Items>

                        <dx:GridViewColumnLayoutItem ColumnName="WhatsApp" />
                        <dx:GridViewColumnLayoutItem ColumnName="Telegram" />
                        <dx:GridViewColumnLayoutItem ColumnName="VK" />
                        <dx:GridViewColumnLayoutItem ColumnName="Facebook" />
                        <dx:GridViewColumnLayoutItem ColumnName="Instagram" />
                        <dx:GridViewColumnLayoutItem ColumnName="Phone" />
                        <dx:GridViewColumnLayoutItem ColumnName="Email" />

                    </Items>
                </dx:GridViewLayoutGroup>

                <dx:GridViewLayoutGroup ColumnSpan="1" GroupBoxDecoration="None">
                    <Items>
                        
                        <dx:GridViewColumnLayoutItem ColumnName="Status" />
                        <dx:GridViewColumnLayoutItem ColumnName="AccountConfirm" />
                        <dx:EditModeCommandLayoutItem HorizontalAlign="Right" />

                    </Items>
                </dx:GridViewLayoutGroup>

            </Items>
        </EditFormLayoutProperties>

        <Columns>

            <dx:GridViewDataTextColumn FieldName="id" Caption="ID" Width="10%" SortOrder="Descending" />

            <dx:GridViewDataTextColumn FieldName="Email" Width="15%" MinWidth="150" AdaptivePriority="0" />

            <dx:GridViewDataTextColumn FieldName="Phone" Caption="Телефон" Width="15%" MinWidth="150" AdaptivePriority="0" PropertiesTextEdit-DisplayFormatString ="+# (###) ###-##-##" />

            <dx:GridViewDataTextColumn FieldName="LastName" Caption="Фамилия" Width="15%" MinWidth="120" AdaptivePriority="0" />

            <dx:GridViewDataTextColumn FieldName="FirstName" Caption="Имя" Width="15%" MinWidth="120" AdaptivePriority="1" />

            <dx:GridViewDataTextColumn FieldName="SecondName" Caption="Отчество" Width="15%" MinWidth="120" AdaptivePriority="1" />

            <dx:GridViewDataDateColumn FieldName="BirthDate" Caption="Дата рождения" Width="15%" MinWidth="100" AdaptivePriority="2" />

            <dx:GridViewDataComboBoxColumn FieldName="Role" Caption="Роль" Width="15%" MinWidth="120" AdaptivePriority="3">
                <PropertiesComboBox DataSourceID="RoleDS" TextField="MetaName" ValueField="ID" />
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn FieldName="Status" Caption="Статус" Width="15%" MinWidth="120" AdaptivePriority="4">
                <PropertiesComboBox DataSourceID="StatusDS" TextField="MetaName" ValueField="ID" />
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataCheckColumn FieldName="AccountConfirm" Caption="Аккаунт подтвержден" Width="10%" AdaptivePriority="5" />




            <dx:GridViewDataTextColumn FieldName="WhatsApp" Visible="false" >
                <PropertiesTextEdit MaxLength="10" NullText="Введите 10 цифр номера телефона" />
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Telegram" Visible="false" />

            <dx:GridViewDataTextColumn FieldName="VK" Visible="false" />

            <dx:GridViewDataTextColumn FieldName="Facebook" Visible="false" />

            <dx:GridViewDataTextColumn FieldName="Instagram" Visible="false" />


        </Columns>


        <Toolbars>
            <dx:GridViewToolbar>
                <Items>
                    <dx:GridViewToolbarItem Command="Refresh" />
                    <dx:GridViewToolbarItem Command="Edit" />
                    <dx:GridViewToolbarItem Command ="New" BeginGroup ="true" />
                </Items>
            </dx:GridViewToolbar>
        </Toolbars>

    </dx:ASPxGridView>

    <asp:SqlDataSource ID="StatusDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>' 
        SelectCommand=" SELECT ID, MetaName
                        FROM [dbo].[PropertyMetaNames]
                        where MetaCategory = @Category
                          and NoShow = 0 
                        order by OrderBy" >
        <SelectParameters>
            <asp:Parameter Name="Category" DefaultValue="Статус пользователя"  DbType="String"  />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="RoleDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>' 
        SelectCommand=" SELECT ID, MetaName
                        FROM [dbo].[PropertyMetaNames]
                        where MetaCategory = @Category
                          and NoShow = 0 
                        order by OrderBy" >
        <SelectParameters>
            <asp:Parameter Name="Category" DefaultValue="Роль"  DbType="String"  />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="UseresListDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>' 
        SelectCommand=" SELECT [id]
                              ,[Email]
                              , Phone --FORMAT(convert(bigint, [Phone]), '+# (###) ###-##-##') [Phone]
                              ,[LastName]
                              ,[FirstName]
                              ,[SecondName]
                              ,[BirthDate]
                              ,[Role]
                              ,[EmailConfirm]
                              ,[PhoneConfirm]
                              ,[AccountConfirm]
                              ,[Status]
                              ,[WhatsApp]
                              ,[Telegram]
                              ,[VK]
                              ,[Facebook]
                              ,[Instagram]
                        FROM [dbo].[Users]" 
        
        UpdateCommand=" update [dbo].[Users]
                        set LastName = @LastName,
                            FirstName = @FirstName,
                            SecondName = @SecondName,
                            BirthDate = @BirthDate,
                            Role = @Role,
                            Status = @Status,
                            WhatsApp = @WhatsApp,
                            Telegram = @Telegram,
                            VK = @VK,
                            Facebook = @Facebook,
                            Instagram = @Instagram,
                            AccountConfirm = @AccountConfirm,
                            Phone = @Phone,
                            Email = @Email
                        where id = @id" 
         InsertCommand = "INSERT INTO [dbo].[Users]
                                   ([Email]
                                   ,[Phone]
                                   ,[LastName]
                                   ,[FirstName]
                                   ,[SecondName]
                                   ,[BirthDate]
                                   ,[Role]
                                   
                                   ,[Status]
                                   ,[WhatsApp]
                                   ,[Telegram]
                                   ,[VK]
                                   ,[Facebook]
                                   ,[Instagram]
                                   )
                             VALUES
                                   (@Email
                                   ,@Phone
                                   ,@LastName
                                   ,@FirstName
                                   ,@SecondName
                                   ,@BirthDate
                                   ,@Role
                                   ,@Status
                                   ,@WhatsApp
                                   ,@Telegram
                                   ,@VK
                                   ,@Facebook
                                   ,@Instagram
                                   )"
        >
        
        <UpdateParameters>
            <asp:Parameter Name="LastName" />
            <asp:Parameter Name="FirstName" />
            <asp:Parameter Name="SecondName" />
            <asp:Parameter Name="BirthDate" />
            <asp:Parameter Name="Role" />
            <asp:Parameter Name="Status" />
            <asp:Parameter Name="WhatsApp" />
            <asp:Parameter Name="Telegram" />
            <asp:Parameter Name="VK" />
            <asp:Parameter Name="Facebook" />
            <asp:Parameter Name="Instagram" />
            <asp:Parameter Name="AccountConfirm" />
            <asp:Parameter Name="id" />
            <asp:Parameter Name="Phone" />
            <asp:Parameter Name="Email" />
        </UpdateParameters>
        <InsertParameters >
            <asp:Parameter Name="LastName" />
            <asp:Parameter Name="FirstName" />
            <asp:Parameter Name="SecondName" />
            <asp:Parameter Name="BirthDate" />
            <asp:Parameter Name="Role" />
            <asp:Parameter Name="Status" />
            <asp:Parameter Name="WhatsApp" />
            <asp:Parameter Name="Telegram" />
            <asp:Parameter Name="VK" />
            <asp:Parameter Name="Facebook" />
            <asp:Parameter Name="Instagram" />
            <asp:Parameter Name="AccountConfirm" />
           
            <asp:Parameter Name="Phone" />
            <asp:Parameter Name="Email" />
        </InsertParameters>
    </asp:SqlDataSource>

</asp:Content>
