<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/DeepWeb.Master" CodeBehind="PropertyData.aspx.vb" Inherits="WebEstateProject.PropertyData" %>

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">




    <dx:ASPxFormLayout ID="PropertyDataForm" ClientInstanceName="PropertyDataForm" runat="server" Width="100%" ColumnCount="3" Paddings-PaddingBottom="20" DataSourceID="PropertyDataDS" >
        <SettingsAdaptivity SwitchToSingleColumnAtWindowInnerWidth="850" >            
            <GridSettings >
                <Breakpoints>
                    <dx:LayoutBreakpoint MaxWidth="1200" ColumnCount="2" Name="M" />
                    <dx:LayoutBreakpoint MaxWidth="800" ColumnCount="1" Name="S" />
                </Breakpoints>
            </GridSettings>
        </SettingsAdaptivity>
        <Items>

            <dx:LayoutGroup GroupBoxDecoration="None" ColumnSpan="1" Width="35%">
                <SpanRules>
                    <dx:SpanRule BreakpointName="S" ColumnSpan="1" />
                    <dx:SpanRule BreakpointName="M" ColumnSpan="2" />
                </SpanRules>
                <Items>

                    <dx:LayoutGroup GroupBoxDecoration="Box" Caption="Фото">
                        <Items>

                            <dx:LayoutItem ShowCaption="False">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">

                                        <dx:ASPxFileManager ID="FileManager" ClientInstanceName="FileManager" runat="server" Width="100%" Height="350" 
                                            OnCustomCallback="FileManager_CustomCallback" OnFilesUploaded="FileManager_FilesUploaded" OnItemsDeleted="FileManager_ItemsDeleted" 
                                            OnFileUploading="FileManager_FileUploading" >
                                            
                                            <SettingsAdaptivity Enabled="true" EnableCollapseFolderContainer="true" CollapseFolderContainerAtWindowInnerWidth="900" />
                                            
                                            <ClientSideEvents SelectionChanged="function(s,e){ SelectionChanged(); }"
                                                CustomCommand="function(s,e){ if(e.commandName == 'CstmBtn'){ FileManager.PerformCallback(FileManager.GetSelectedFile().imageSrc); } }"
                                                EndCallback="function(s,e){ SelectionChanged(); }"  />

                                            <Settings ThumbnailFolder="~\Content\Thumb\PropertyRegisterThumb" AllowedFileExtensions=".jpg,.jpeg,.png" EnableMultiSelect="true" />
                                            <SettingsFolders Visible="false" />
                                            <SettingsEditing AllowDelete="true" AllowRename="true" AllowDownload="true" />
                                            <SettingsAdaptivity Enabled="true" />
                                            <SettingsToolbar ShowFilterBox="false" ShowPath="false">
                                                <Items>
                                                    <dx:FileManagerToolbarRefreshButton AdaptivePriority="0" />
                                                    <dx:FileManagerToolbarDeleteButton AdaptivePriority="2" />
                                                    <dx:FileManagerToolbarDownloadButton AdaptivePriority="3" />
                                                    <dx:FileManagerToolbarUploadButton BeginGroup="true" AdaptivePriority="1" />
                                                    <dx:FileManagerToolbarCustomButton BeginGroup="true" Text="Назначить главное фото" CommandName="CstmBtn" ItemStyle-VerticalAlign="Middle" ClientEnabled="false" AdaptivePriority="4" />
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

                                        <dx:ASPxMemo ID="DescriptionMemo" ClientInstanceName="DescriptionMemo" runat="server" Width="100%" Rows="5" Border-BorderStyle="None">
                                            <ValidationSettings ValidateOnLeave="true" ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom" 
                                                RequiredField-IsRequired="true" RequiredField-ErrorText="Заполните описание" ErrorFrameStyle-Font-Size="Smaller"/>                                            
                                        </dx:ASPxMemo>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                        </Items>
                    </dx:LayoutGroup>

                    <dx:LayoutGroup GroupBoxDecoration="Box" Caption="Опубликовать у партнеров">
                        <Items>

                            <dx:LayoutItem Caption="Yandex" FieldName="YandexFeed">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">

                                        <dx:ASPxCheckBox ID="YandexFeedCheckBox" ClientInstanceName="YandexFeedCheckBox" runat="server" AllowGrayed="false">
                                            <ClientSideEvents CheckedChanged="function(s,e){ if(YandexFeedCheckBox.GetValue() == true) { if(CheckYandex() == 0){ YandexFeedCheckBox.SetValue(false); } } }" />
                                        </dx:ASPxCheckBox>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                        </Items>
                    </dx:LayoutGroup>

                </Items>
            </dx:LayoutGroup>                       

            <dx:LayoutGroup GroupBoxDecoration="None" ColumnSpan="1" Width="32%" >
                <SpanRules>
                    <dx:SpanRule BreakpointName="S" ColumnSpan="1" />
                    <dx:SpanRule BreakpointName="M" ColumnSpan="1" />
                </SpanRules>
                <Items>

                    <dx:LayoutItem FieldName="Created" ShowCaption="False" ClientVisible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxDateEdit ID="CreatedDE" runat="server" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="AgentName" ShowCaption="False" ClientVisible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="AgentNameTB" ClientInstanceName="AgentNameTB" runat="server" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="AgentPhone" ShowCaption="False" ClientVisible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="AgentPhoneTB" ClientInstanceName="AgentPhoneTB" runat="server" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="AdStatus" Caption="Объявление">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxComboBox ID="AdStatusCB" ClientInstanceName="AdStatusCB" runat="server" Width="100%" DataSourceID="AdStatusDS" ValueField="ID" TextField="MetaName" 
                                    AllowNull="false" Border-BorderWidth="3"   >
                                  <ClientSideEvents ValueChanged="function(s,e){ AdStatusColor(s.GetText()); }" Init="function(s,e){ AdStatusColor(s.GetText()); }" />
                                </dx:ASPxComboBox>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="Name" Caption="Название">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxMemo ID="NameMemo" ClientInstanceName="NameMemo" runat="server" Width="100%" Rows="3">
                                    <ValidationSettings ValidateOnLeave="true" ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom"
                                        RequiredField-IsRequired="true" RequiredField-ErrorText="Обязательное поле" ErrorFrameStyle-Font-Size="Smaller"/>
                                </dx:ASPxMemo>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="Type" Caption="Категория">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxComboBox ID="TypeCB" ClientInstanceName="TypeCB" runat="server" Width="100%" DataSourceID="TypeDS" ValueField="ID" TextField="MetaName" >
                                    <ValidationSettings ValidateOnLeave="true" ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom" 
                                        RequiredField-IsRequired="true" RequiredField-ErrorText="Обязательное поле" ErrorFrameStyle-Font-Size="Smaller"/>
                                </dx:ASPxComboBox>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="District" Caption="Район">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxComboBox ID="DistrictCB" ClientInstanceName="DistrictCB" runat="server" Width="100%" DataSourceID="DistrictDS" ValueField="ID" TextField="MetaName" >
                                    <ValidationSettings ValidateOnLeave="true" ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom" 
                                        RequiredField-IsRequired="true" RequiredField-ErrorText="Обязательное поле" ErrorFrameStyle-Font-Size="Smaller"/>
                                </dx:ASPxComboBox>

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
                                    SpinButtons-ShowIncrementButtons="false" DisplayFormatString="C0" >
                                    <ValidationSettings ValidateOnLeave="true" ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom" 
                                        RequiredField-IsRequired="true" RequiredField-ErrorText="Обязательное поле" ErrorFrameStyle-Font-Size="Smaller"/>
                                </dx:ASPxSpinEdit>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="ApartmentArea" Caption="Площадь, кв.м.">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxSpinEdit ID="ApartmentAreaSpin" ClientInstanceName="ApartmentAreaSpin" runat="server" Width="100%" NumberType="Float" SpinButtons-ShowIncrementButtons="false" >
                                    <ValidationSettings ValidateOnLeave="true" ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom" 
                                        RequiredField-IsRequired="true" RequiredField-ErrorText="Обязательное поле" ErrorFrameStyle-Font-Size="Smaller"/>
                                </dx:ASPxSpinEdit>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="Status" Caption="Статус объекта">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxComboBox ID="StatusCB" ClientInstanceName="StatusCB" runat="server" Width="100%" DataSourceID="StatusDS" ValueField="ID" TextField="MetaName" >
                                    <ValidationSettings ValidateOnLeave="true" ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom" 
                                        RequiredField-IsRequired="true" RequiredField-ErrorText="Обязательное поле" ErrorFrameStyle-Font-Size="Smaller"/>
                                </dx:ASPxComboBox>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="Condition" Caption="Условия">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxComboBox ID="ConditionCB" ClientInstanceName="ConditionCB" runat="server" Width="100%" DataSourceID="ConditionDS" ValueField="ID" TextField="MetaName" >
                                    <ValidationSettings ValidateOnLeave="true" ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom" 
                                        RequiredField-IsRequired="true" RequiredField-ErrorText="Обязательное поле" ErrorFrameStyle-Font-Size="Smaller"/>
                                </dx:ASPxComboBox>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="Registration" Caption="Оформление">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxComboBox ID="RegistrationCB" ClientInstanceName="RegistrationCB" runat="server" Width="100%" DataSourceID="RegistrationDS" ValueField="ID" TextField="MetaName" >
                                    <ValidationSettings ValidateOnLeave="true" ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom" 
                                        RequiredField-IsRequired="true" RequiredField-ErrorText="Обязательное поле" ErrorFrameStyle-Font-Size="Smaller"/>
                                </dx:ASPxComboBox>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem FieldName="Stove" Caption="Плита">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxComboBox ID="StoveCB" ClientInstanceName="StoveCB" runat="server" Width="100%" DataSourceID="StoveDS" ValueField="ID" TextField="MetaName" AllowNull="true" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

<%--                    <dx:LayoutItem FieldName="Street" Caption="Улица">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxTextBox ID="StreetTB" ClientInstanceName="StreetTB" runat="server" Width="100%"></dx:ASPxTextBox>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>--%>

                    <dx:LayoutItem FieldName="WindowView" Caption="Вид из окна">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxComboBox ID="WindowViewCB" ClientInstanceName="WindowViewCB" runat="server" Width="100%" DataSourceID="WindowViewDS" ValueField="ID" TextField="MetaName" AllowNull="true" />

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

                </Items>
            </dx:LayoutGroup>

            <dx:LayoutGroup GroupBoxDecoration="None" ColumnSpan="1" Width="32%">
                <SpanRules>
                    <dx:SpanRule BreakpointName="S" ColumnSpan="1" />
                    <dx:SpanRule BreakpointName="M" ColumnSpan="1" />
                </SpanRules>
                <Items>

                    <dx:LayoutGroup GroupBoxDecoration="Box" Caption="Адрес объекта">
                        <Items>

                            <dx:LayoutItem ShowCaption="False">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">

                                        <label for="address">Начните вводить адрес для поиска:</label><br>
                                        <input id="address" name="address" type="text" style="line-height:25px"  />

                                        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
                                        <link href="https://cdn.jsdelivr.net/npm/suggestions-jquery@20.3.0/dist/css/suggestions.min.css" rel="stylesheet" />
                                        <script src="https://cdn.jsdelivr.net/npm/suggestions-jquery@20.3.0/dist/js/jquery.suggestions.min.js"></script>


                                        <script>

                                            $("#address").suggestions({
                                                token: "ef658f0261b64dfea6077ff246d9337cdaab6a5a",
                                                type: "ADDRESS",
                                                /* Вызывается, когда пользователь выбирает одну из подсказок */
                                                onSelect: function (suggestion) {
                                                    //console.log(suggestion.data.country);
                                                    CountryTB.SetText(suggestion.data.country);
                                                    RegionTB.SetText(suggestion.data.region_with_type);

                                                    if (suggestion.data.area_with_type == null) {
                                                        RegionDistrictTB.SetText('нет');
                                                    }
                                                    else {
                                                        RegionDistrictTB.SetText(suggestion.data.area_with_type);
                                                    }                                                                                                       

                                                    if (suggestion.data.settlement == null) {
                                                        LocalityNameTB.SetText(suggestion.data.city);
                                                    }
                                                    else {
                                                        LocalityNameTB.SetText(suggestion.data.settlement);
                                                    }
                                                    StreetNameTB.SetText(suggestion.data.street_with_type);

                                                    if (suggestion.data.block == null) {
                                                        HouseTB.SetText(suggestion.data.house_type + ' ' + suggestion.data.house);
                                                    }
                                                    else {
                                                        HouseTB.SetText(suggestion.data.house_type + ' ' + suggestion.data.house + ' ' + suggestion.data.block_type_full + ' ' + suggestion.data.block);
                                                    }
                                                    
                                                    ApartmentTB.SetText(suggestion.data.flat);

                                                    console.log(suggestion.data.area_with_type);

                                                    address.value = '';
                                                }
                                            });
                                        </script>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="Страна" FieldName="Country">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox ID="CountryTB" ClientInstanceName="CountryTB" runat="server" />
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="Субъект РФ" FieldName="Region">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox ID="RegionTB" ClientInstanceName="RegionTB" runat="server" />
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="Район субъекта РФ" FieldName="RegionDistrict">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox ID="RegionDistrictTB" ClientInstanceName="RegionDistrictTB" runat="server" />
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="Нас.пункт" FieldName="LocalityName">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox ID="LocalityNameTB" ClientInstanceName="LocalityNameTB" runat="server" />
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="Улица" FieldName="StreetName">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox ID="StreetNameTB" ClientInstanceName="StreetNameTB" runat="server" />
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="Дом" FieldName="House">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox ID="HouseTB" ClientInstanceName="HouseTB" runat="server" />
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="Квартира" FieldName="Apartment">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer runat="server">
                                        <dx:ASPxTextBox ID="ApartmentTB" ClientInstanceName="ApartmentTB" runat="server" />
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                        </Items>
                    </dx:LayoutGroup>


                    

                    <dx:LayoutItem FieldName="ActualUntil" Caption="Актуально до">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxDateEdit ID="ActualUntilDE" ClientInstanceName="ActualUntilDE" runat="server" Width="100%" NullText="По умолчанию +1 месяц" AllowNull="false">
                                    <ClientSideEvents DateChanged="function(s,e){ ActualUntilChange(); }" />
                                </dx:ASPxDateEdit>

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

                    <dx:LayoutItem FieldName="ElitProperty" Caption="Элитная недвижимость">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxCheckBox ID="ElitPropertyCheckBox" ClientInstanceName="ElitPropertyCheckBox" runat="server" AllowGrayed="false" />

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

<%--                    <dx:LayoutItem FieldName="Sale" Caption="Продано">
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
                    </dx:LayoutItem>--%>
                    


                    <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center" ParentContainerStyle-Paddings-PaddingTop="20">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">

                                <dx:ASPxButton ID="SaveButton" ClientInstanceName="SaveButton" runat="server" AutoPostBack="false" Text="Сохранить" >
                                    <ClientSideEvents Click="function(s,e){ SaveButtonClick();  }" />
                                </dx:ASPxButton>

                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>


                </Items>
            </dx:LayoutGroup>




        </Items>
    </dx:ASPxFormLayout>


    <asp:SqlDataSource ID="AdStatusDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>' 
        SelectCommand=" SELECT ID, MetaName
                        FROM [dbo].[PropertyMetaNames]
                        where MetaCategory = @Category
                          and NoShow = 0 
                        order by OrderBy" >
        <SelectParameters>
            <asp:Parameter Name="Category" DefaultValue="Статус объявления"  DbType="String"  />
        </SelectParameters>
    </asp:SqlDataSource>

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
        SelectCommand="[dbo].[GetPropertyObjectDataForUpdate] @ID">
        <SelectParameters>
            <asp:QueryStringParameter Name="ID" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>


    <dx:ASPxPopupControl ID="SuccessSavePopup" ClientInstanceName="SuccessSavePopup" runat="server" ShowHeader="false" CloseAction="OuterMouseClick"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" BackColor="#ccffcc" Border-BorderColor="#ccffcc" >
        <SettingsAdaptivity Mode="Always" VerticalAlign="WindowCenter" MaxWidth="300" MaxHeight="100" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">

                <div class="row" style="justify-content:center; vertical-align:middle; color:#003300">
                    Данные успешно сохранены!
                </div>                            

            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>


    <dx:ASPxCallback ID="CBackSave" ClientInstanceName="CBackSave" runat="server" OnCallback="CBackSave_Callback">
        <ClientSideEvents CallbackComplete="function(s,e){ CBackSaveResult(e.result); }" />
    </dx:ASPxCallback>

    <dx:ASPxLoadingPanel ID="LoadingPanel" ClientInstanceName="LoadingPanel" runat="server" Modal="true" Text="Сохранение..." />





    <script type="text/javascript">

        function SelectionChanged() {
            if (FileManager.GetSelectedItems().length == 1) {
                FileManager.GetToolbar(0).GetItemByName('CstmBtn').SetEnabled(1);
            }
            else {
                FileManager.GetToolbar(0).GetItemByName('CstmBtn').SetEnabled(0);
            }
        }

        function CBackSaveResult(vl) {
            LoadingPanel.Hide();
            if (vl == 0) {
                alert('Что-то пошло не так... Попробуйте еще раз или обратитесь к разработчику');
            }
            else if (vl == 1) {
                SuccessSavePopup.Show();
            }
        }

        function SaveButtonClick() {

            if (DescriptionMemo.isValid && NameMemo.isValid && TypeCB.isValid && DistrictCB.isValid && PriceSpin.isValid && ApartmentAreaSpin.isValid && StatusCB.isValid && ConditionCB.isValid && RegistrationCB.isValid) {

                var n = new Date();
                var d = ActualUntilDE.GetValue();

                if (AdStatusCB.GetText() == 'Опубликовано' && d < n) {
                    alert('Невозможно опубликовать объявление: истек срок актуальности');
                }
                else {
                    if (AdStatusCB.GetValue() == 73 && YandexFeedCheckBox.GetValue() == true) { //если объявление в статусе Опубликовано + опубликовать на Yandex
                        if (CheckYandex() == 1) {
                            LoadingPanel.Show();
                            CBackSave.PerformCallback();
                        }                        
                    }
                    else {
                        LoadingPanel.Show();
                        CBackSave.PerformCallback();
                    }
                    
                }                
            }           

        }

        //Корректировка цвета в зависимости от статуса объявления
        function AdStatusColor(vl) {

            var cmbElement = AdStatusCB.GetMainElement();

            if (vl == 'Опубликовано') {
                cmbElement.style.borderColor = '#1DD300	';
            }
            else if (vl == 'Черновик') {
                cmbElement.style.borderColor = 'Gray';
            }
            else if (vl == 'Продано') {
                cmbElement.style.borderColor = '#FFE400';
            }
            else {
                cmbElement.style.borderColor = '#FF3100	';
            }
        }

        //Корректирвока статуса объявления в зависимости от изменения актуальности
        function ActualUntilChange() {

            var now = new Date();
            var dt = ActualUntilDE.GetValue();

            if (dt < now) {
                AdStatusCB.SetValue(76);                
            }
            else {
                if (AdStatusCB.GetValue() != 73) {
                    if (confirm('Исправить статус объявления на ОПУБЛИКОВАН?')) {
                        AdStatusCB.SetValue(73);
                    }
                    else {
                        AdStatusCB.SetValue(72);
                    }
                }               
            }
            AdStatusColor(AdStatusCB.GetText());
        }


        function CheckYandex() {
            if (TypeCB.GetValue() != 1) {
                alert('Публикация на Yandex возможна только для Вторичного рынка');
                return 0;
            }
            else if (CountryTB.GetText() == '' || RegionTB.GetText() == '' || RegionDistrictTB.GetText() == '' || LocalityNameTB.GetText() == '' || StreetNameTB.GetText() == '' || HouseTB.GetText() == '' || ApartmentTB.GetText() == '') {
                alert('Для публикации на Yandex необходимо заполнить все поля в Адресе объекта');
                return 0;
            }
            else if (AgentNameTB.GetText() == '' || AgentPhoneTB.GetText() == '') {
                alert('Для публикации на Yandex необходимы данные агента. Обратитесь к разработчику');
                return 0;
            }
            else if (PriceSpin.GetValue() == null) {
                alert('Для публикации на Yandex необходимо указать стоимость объекта');
                return 0;
            }
            else if (RegistrationCB.GetValue() != 47) {
                alert('Публикация на Yandex возможна только для объявлений с оформлением ПРАВО СОБСТВЕННОСТИ (ПРЯМАЯ ПРОДАЖА)');
                return 0;
            }
            else if (ApartmentAreaSpin.GetValue() == null) {
                alert('Для публикации на Yandex необходимо указать площадь объекта');
                return 0;
            }
            else if (RoomsSpin.GetValue() == null) {
                alert('Для публикации на Yandex необходимо указать количество комнат');
                return 0;
            }
            else if (FloorSpin.GetValue() == null) {
                alert('Для публикации на Yandex необходимо указать этаж');
                return 0;
            }
            else if (FileManager.GetItems().length < 4) {
                alert('Для публикации на Yandex необходимо загрузить минимум 4 фотографии объекта');
                return 0;
            }
            else {
                return 1
            }
        }



    </script>

</asp:Content>
