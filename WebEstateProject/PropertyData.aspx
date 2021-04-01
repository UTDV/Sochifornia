<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/DeepWeb.Master" CodeBehind="PropertyData.aspx.vb" Inherits="WebEstateProject.PropertyData" %>

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <dx:ASPxFormLayout ID="PropertyDataForm" ClientInstanceName="PropertyDataForm" runat="server" Width="100%" ColumnCount="3" Paddings-PaddingTop="10" DataSourceID="PropertyDataDS" >
        <SettingsAdaptivity SwitchToSingleColumnAtWindowInnerWidth="900" >            
            <GridSettings >
                <Breakpoints>
                    <dx:LayoutBreakpoint MaxWidth="3000" ColumnCount="3" Name="L" />
                    <dx:LayoutBreakpoint MaxWidth="2000" ColumnCount="2" Name="M" />
                    <dx:LayoutBreakpoint MaxWidth="1000" ColumnCount="1" Name="S" />
                </Breakpoints>
            </GridSettings>
        </SettingsAdaptivity>
        <Items>

            <dx:LayoutGroup GroupBoxDecoration="None" ColumnSpan="1" Width="39%">
                <SpanRules>
                    <dx:SpanRule BreakpointName="L" ColumnSpan="1" />
                    <dx:SpanRule BreakpointName="S" ColumnSpan="1" />
                    <dx:SpanRule BreakpointName="M" ColumnSpan="2" />
                </SpanRules>
                <Items>

                    <dx:LayoutGroup GroupBoxDecoration="Box" Caption="Фото" >
                        <Items>

                            <dx:LayoutItem ShowCaption="False">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">

                                        <dx:ASPxFileManager ID="FileManager" ClientInstanceName="FileManager" runat="server" Width="100%" Height="320">

                                            <ClientSideEvents FilesUploaded="function(s,e){  }"
                                                ItemsDeleted="function(s,e){  }"
                                                SelectionChanged="function(s,e){  }"
                                                CustomCommand="function(s,e){  }"
                                                EndCallback="function(s,e){  }" />

                                            <Settings ThumbnailFolder="~\Content\Thumb\PropertyRegisterThumb" AllowedFileExtensions=".jpg,.jpeg,.png" EnableMultiSelect="true" />
                                            <SettingsFolders Visible="false" />
                                            <SettingsEditing AllowDelete="true" AllowRename="true" AllowDownload="true" />
                                            <SettingsAdaptivity Enabled="true" />
                                            <SettingsToolbar ShowFilterBox="false" ShowPath="false">
                                                <Items>
                                                    <dx:FileManagerToolbarRefreshButton />
                                                    <dx:FileManagerToolbarDeleteButton />
                                                    <dx:FileManagerToolbarDownloadButton />
                                                    <dx:FileManagerToolbarUploadButton BeginGroup="true" Text="Загрузить" />
                                                    <dx:FileManagerToolbarCustomButton BeginGroup="true" Text="Назначить главное фото" CommandName="CstmBtn" ItemStyle-VerticalAlign="Middle" ClientEnabled="false" />
                                                </Items>
                                            </SettingsToolbar>
                                            <SettingsUpload AdvancedModeSettings-EnableMultiSelect="true" AutoStartUpload="true" UseAdvancedUploadMode="true" ShowUploadPanel="false" />
                                            <SettingsContextMenu Enabled="true" />

                                        </dx:ASPxFileManager>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                        </Items>
                    </dx:LayoutGroup>

                    <dx:LayoutGroup GroupBoxDecoration="Box" Caption="Описание" >
                        <Items>

                            <dx:LayoutItem FieldName="Description" ShowCaption="False">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">

                                        <dx:ASPxMemo ID="DescriptionMemo" ClientInstanceName="DescriptionMemo" runat="server" Width="100%" Rows="5" Border-BorderStyle="None"></dx:ASPxMemo>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                        </Items>
                    </dx:LayoutGroup>

                </Items>
            </dx:LayoutGroup>                       

            <dx:LayoutGroup GroupBoxDecoration="None" ColumnSpan="1" Width="29%" >
                <SpanRules>
                    <dx:SpanRule BreakpointName="L" ColumnSpan="1" />
                    <dx:SpanRule BreakpointName="S" ColumnSpan="1" />
                    <dx:SpanRule BreakpointName="M" ColumnSpan="1" />
                </SpanRules>
                <Items>

                    <dx:LayoutItem FieldName="Name" Caption="Название">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxMemo ID="NameMemo" ClientInstanceName="NameMemo" runat="server" Width="100%" Rows="3"></dx:ASPxMemo>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="Type" Caption="Категория">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxComboBox ID="TypeCB" ClientInstanceName="TypeCB" runat="server" Width="100%" DataSourceID="TypeDS" ValueField="ID" TextField="MetaName" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="District" Caption="Район">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxComboBox ID="DistrictCB" ClientInstanceName="DistrictCB" runat="server" Width="100%" DataSourceID="DistrictDS" ValueField="ID" TextField="MetaName" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="Complex" Caption="ЖК">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="ComplexTB" ClientInstanceName="ComplexTB" runat="server" Width="100%"></dx:ASPxTextBox>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="Price" Caption="Цена, руб.">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxSpinEdit ID="PriceSpin" ClientInstanceName="PriceSpin" runat="server" Width="100%" NumberFormat="Currency" DisplayFormatInEditMode="true"
                                    SpinButtons-ShowIncrementButtons="false" DisplayFormatString="C0" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="ApartmentArea" Caption="Площадь, кв.м.">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxSpinEdit ID="ApartmentAreaSpin" ClientInstanceName="ApartmentAreaSpin" runat="server" Width="100%" NumberType="Float" SpinButtons-ShowIncrementButtons="false" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="Status" Caption="Статус">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxComboBox ID="StatusCB" ClientInstanceName="StatusCB" runat="server" Width="100%" DataSourceID="StatusDS" ValueField="ID" TextField="MetaName" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="Condition" Caption="Условия">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxComboBox ID="ConditionCB" ClientInstanceName="ConditionCB" runat="server" Width="100%" DataSourceID="ConditionDS" ValueField="ID" TextField="MetaName" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="Registration" Caption="Оформление">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxComboBox ID="RegistrationCB" ClientInstanceName="RegistrationCB" runat="server" Width="100%" DataSourceID="RegistrationDS" ValueField="ID" TextField="MetaName" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="Stove" Caption="Плита">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxComboBox ID="StoveCB" ClientInstanceName="StoveCB" runat="server" Width="100%" DataSourceID="StoveDS" ValueField="ID" TextField="MetaName" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="Street" Caption="Улица">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="StreetTB" ClientInstanceName="StreetTB" runat="server" Width="100%"></dx:ASPxTextBox>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="WindowView" Caption="Вид из окна">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxComboBox ID="WindowViewCB" ClientInstanceName="WindowViewCB" runat="server" Width="100%" DataSourceID="WindowViewDS" ValueField="ID" TextField="MetaName" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="ToSea" Caption="До моря, м">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxSpinEdit ID="ToSeaSpin" ClientInstanceName="ToSeaSpin" runat="server" Width="100%" NumberType="Integer" SpinButtons-ShowIncrementButtons="false" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="Rooms" Caption="Кол-во комнат, шт.">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxSpinEdit ID="RoomsSpin" ClientInstanceName="RoomsSpin" runat="server" Width="100%" MinValue="0" MaxValue="100" NumberType="Integer" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                </Items>
            </dx:LayoutGroup>

            <dx:LayoutGroup GroupBoxDecoration="None" ColumnSpan="1" Width="29%">
                <SpanRules>
                    <dx:SpanRule BreakpointName="L" ColumnSpan="1" />
                    <dx:SpanRule BreakpointName="S" ColumnSpan="1" />
                    <dx:SpanRule BreakpointName="M" ColumnSpan="1" />
                </SpanRules>
                <Items>

                    <dx:LayoutItem FieldName="Floor" Caption="Этаж">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxSpinEdit ID="FloorSpin" ClientInstanceName="FloorSpin" runat="server" Width="100%" NumberType="Integer" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="TotalFloor" Caption="Всего этажей">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxSpinEdit ID="TotalFloorSpin" ClientInstanceName="TotalFloorSpin" runat="server" Width="100%" NumberType="Integer" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="LandArea" Caption="Площадь участка">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxSpinEdit ID="LandAreaSpin" ClientInstanceName="LandAreaSpin" runat="server" Width="100%" NumberType="Float" SpinButtons-ShowIncrementButtons="false" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="ActualUntil" Caption="Актуально до">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxDateEdit ID="ActualUntilDE" ClientInstanceName="ActualUntilDE" runat="server" Width="100%" NullText="По умолчанию +1 месяц"></dx:ASPxDateEdit>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="Posrednik" Caption="Посредник">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxComboBox ID="PosrednikCB" ClientInstanceName="PosrednikCB" runat="server" Width="100%" DataSourceID="PosrednikDS" ValueField="ID" TextFormatString="{3} {1}" AllowNull="true">
                                    <Columns>
                                        <dx:ListBoxColumn FieldName="ID" ClientVisible="false" />
                                        <dx:ListBoxColumn Caption="Имя" FieldName="FirstName" />
                                        <dx:ListBoxColumn Caption="Фамилия" FieldName="LastName" />
                                        <dx:ListBoxColumn Caption="Телефон" FieldName="Phone" />
                                    </Columns>
                                </dx:ASPxComboBox>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="Comission" Caption="Комиссия">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="ComissionTB" ClientInstanceName="ComissionTB" runat="server" Width="100%"></dx:ASPxTextBox>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="Ipoteka" Caption="Ипотека">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxCheckBox ID="IpotekaCheckBox" ClientInstanceName="IpotekaCheckBox" runat="server" AllowGrayed="false" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="VIP" Caption="VIP объявление">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxCheckBox ID="VIPCheckBox" ClientInstanceName="VIPCheckBox" runat="server" AllowGrayed="false" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="ElitProperty" Caption="Элетная недвижимость">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxCheckBox ID="ElitPropertyCheckBox" ClientInstanceName="ElitPropertyCheckBox" runat="server" AllowGrayed="false" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="Sale" Caption="Продано">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxCheckBox ID="SaleCheckBox" ClientInstanceName="SaleCheckBox" runat="server" AllowGrayed="false" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="Hide" Caption="Скрыто">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxCheckBox ID="HideCheckBox" ClientInstanceName="HideCheckBox" runat="server" AllowGrayed="false" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                </Items>
            </dx:LayoutGroup>




        </Items>
    </dx:ASPxFormLayout>

    <asp:SqlDataSource ID="PosrednikDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>' 
        SelectCommand=" SELECT ID, FirstName, LastName, Phone
                        FROM [dbo].[Users]
                        " />

    <asp:SqlDataSource ID="WindowViewDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>' 
        SelectCommand=" SELECT ID, MetaName
                        FROM [dbo].[PropertyMetaNames]
                        where MetaCategory = @Category
                          and NoShow = 0 
                        order by OrderBy" >
        <SelectParameters>
            <asp:Parameter Name="Category" DefaultValue="Вид из окна"  DbType="String"  />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="StoveDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>' 
        SelectCommand=" SELECT ID, MetaName
                        FROM [dbo].[PropertyMetaNames]
                        where MetaCategory = @Category
                          and NoShow = 0 
                        order by OrderBy" >
        <SelectParameters>
            <asp:Parameter Name="Category" DefaultValue="Плита"  DbType="String"  />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="RegistrationDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>' 
        SelectCommand=" SELECT ID, MetaName
                        FROM [dbo].[PropertyMetaNames]
                        where MetaCategory = @Category
                          and NoShow = 0
                        order by OrderBy" >
        <SelectParameters>
            <asp:Parameter Name="Category" DefaultValue="Оформление" DbType="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="ConditionDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>' 
        SelectCommand=" SELECT ID, MetaName
                        FROM [dbo].[PropertyMetaNames]
                        where MetaCategory = @Category
                          and NoShow = 0
                        order by OrderBy" >
        <SelectParameters>
            <asp:Parameter Name="Category" DefaultValue="Состояние" DbType="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="StatusDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>' 
        SelectCommand=" SELECT ID, MetaName
                        FROM [dbo].[PropertyMetaNames]
                        where MetaCategory = @Category
                          and NoShow = 0
                        order by OrderBy" >
        <SelectParameters>
            <asp:Parameter Name="Category" DefaultValue="Статус" DbType="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="DistrictDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>' 
        SelectCommand=" SELECT ID, MetaName
                        FROM [dbo].[PropertyMetaNames]
                        where MetaCategory = @Category 
                          and NoShow = 0
                        order by OrderBy" >
        <SelectParameters>
            <asp:Parameter Name="Category" DefaultValue="Район" DbType="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="TypeDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>' 
        SelectCommand=" SELECT ID, MetaName
                        FROM [dbo].[PropertyMetaNames]
                        where MetaCategory = @Category
                          and NoShow = 0
                        order by OrderBy" >
        <SelectParameters>
            <asp:Parameter Name="Category" DefaultValue="Категория недвижимости" DbType="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="PropertyDataDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>' 
        SelectCommand="select p.*, price.MetaData Price
                       from dbo.PropertyObjects p LEFT JOIN [dbo].[PropertyObjectsMetaData] price ON price.ObjectID = p.ID
                                                                                        AND price.MetaNameID = 54
                                                                                        AND price.Created =
																					                        (
																						                        SELECT MAX(Created)
																						                        FROM [dbo].[PropertyObjectsMetaData] maxprice
																						                        WHERE maxprice.ObjectID = price.ObjectID
																							                          AND maxprice.MetaNameID = price.MetaNameID
																					                        )
                       where p.id = @ID">
        <SelectParameters>
            <asp:QueryStringParameter Name="ID" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
