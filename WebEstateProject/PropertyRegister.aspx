<%@ Page Title="Недвижимость Сочи" Language="vb" AutoEventWireup="false" MasterPageFile="~/DeepWeb.Master" CodeBehind="PropertyRegister.aspx.vb" Inherits="WebEstateProject.PropertyRegister" %>

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<asp:Content ID="ButtonsContent" ContentPlaceHolderID="HeadButtonsContent" runat="server">

</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <dx:ASPxHiddenField ID="HiddenField" ClientInstanceName="HiddenField" runat="server" />

    <dx:ASPxGridView ID="PropertyRegisterGrid" ClientInstanceName="PropertyRegisterGrid" runat="server" Width="100%"    
        DataSourceID="PropertyRegisterDS" KeyFieldName="ID" AutoGenerateColumns="False" Styles-Cell-Paddings-Padding="5px" CssClass="PropertyRegisterFontSize"   
        Settings-AutoFilterCondition="Contains"  SettingsBehavior-AllowEllipsisInText="true" OnRowDeleted="PropertyRegisterGrid_RowDeleted" 
        Styles-Header-Wrap="True" OnRowInserting="PropertyRegisterGrid_RowInserting" OnRowUpdating="PropertyRegisterGrid_RowUpdating" >

        <StylesToolbar>
            <Item CssClass="PropertyRegisterFontSize" />
        </StylesToolbar>

        <ClientSideEvents Init="function (s,e) {  }" 
            ToolbarItemClick="function (s,e) { 
            if(e.item.name == 'Foto') { if(PropertyRegisterGrid.GetFocusedRowIndex() == null || PropertyRegisterGrid.GetFocusedRowIndex() == -1) { alert('Выберите объект'); } else { OpenFoto(); } } 
            if(e.item.name == 'View') { if(PropertyRegisterGrid.GetFocusedRowIndex() == null || PropertyRegisterGrid.GetFocusedRowIndex() == -1) { alert('Выберите объект'); } else { fOpenPage(s,e); } } }" 
            RowDblClick="function (s,e) { fOpenPage(s,e); }" />

        <SettingsBehavior AllowFocusedRow="true" EnableCustomizationWindow="true" ConfirmDelete="true" />

        <SettingsContextMenu Enabled="true" EnableRowMenu="False" >
            <ColumnMenuItemVisibility ShowCustomizationDialog="true" ShowCustomizationWindow="true" />
        </SettingsContextMenu>

        <Settings VerticalScrollBarMode="Hidden" ShowHeaderFilterButton="True" ShowFilterRow="true" />

        <SettingsPager PageSize="15" />

        <SettingsEditing Mode="EditForm" />

        <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true" AllowHideDataCellsByColumnMinWidth="true"  />

        <EditFormLayoutProperties ColumnCount="3" >
            <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="1000" />
            <Items>
                
                <dx:GridViewLayoutGroup ColumnSpan="1" GroupBoxDecoration="None" >
                    <Items>
                        
                        <dx:GridViewColumnLayoutItem ColumnName="Type"  />
                        <dx:GridViewColumnLayoutItem ColumnName="District" />
                        <dx:GridViewColumnLayoutItem ColumnName="Complex" />
                        <dx:GridViewColumnLayoutItem ColumnName="Name" />
                        <dx:GridViewColumnLayoutItem ColumnName="Price" />
                        <dx:GridViewColumnLayoutItem ColumnName="ApartmentArea" Caption="Площадь" />
                        <dx:GridViewColumnLayoutItem ColumnName="Status" />
                        <dx:GridViewColumnLayoutItem ColumnName="Condition" />
                        <dx:GridViewColumnLayoutItem ColumnName="Registration" />
                        <dx:GridViewColumnLayoutItem ColumnName="Stove" />
                        <dx:GridViewColumnLayoutItem ColumnName="Street" />                        
                        
                    </Items>
                </dx:GridViewLayoutGroup>

                <dx:GridViewLayoutGroup ColumnSpan="2" GroupBoxDecoration="None" ColumnCount="2">
                    <Items>

                        <dx:GridViewColumnLayoutItem ColumnName="Description" ColumnSpan="2" Paddings-PaddingBottom="19" />

                        <dx:GridViewLayoutGroup ColumnSpan="1" GroupBoxDecoration="None">
                            <Items>
                                <dx:GridViewColumnLayoutItem ColumnName="WindowView" />
                                <dx:GridViewColumnLayoutItem ColumnName="ToSea" />
                                <dx:GridViewColumnLayoutItem ColumnName="RoomsNumber" />
                                <dx:GridViewColumnLayoutItem ColumnName="Floor" />
                                <dx:GridViewColumnLayoutItem ColumnName="TotalFloor" />
                                <dx:GridViewColumnLayoutItem ColumnName="LandArea" Caption="Площадь участка" />
                                <dx:GridViewColumnLayoutItem ColumnName="ActualUntil" />
                            </Items>
                        </dx:GridViewLayoutGroup>

                        <dx:GridViewLayoutGroup ColumnSpan="1" GroupBoxDecoration="None">
                            <Items>
                                  
                                <dx:GridViewColumnLayoutItem ColumnName="Ipoteka" />
                                <dx:GridViewColumnLayoutItem ColumnName="VIP" /> 
                                <dx:GridViewColumnLayoutItem ColumnName="ElitProperty" />
                                <dx:GridViewColumnLayoutItem ColumnName="Sale" />
                                <dx:GridViewColumnLayoutItem ColumnName="Hide" />
                                <dx:EditModeCommandLayoutItem HorizontalAlign="Right" VerticalAlign="Bottom" Paddings-PaddingTop="60"/>
                            </Items>
                        </dx:GridViewLayoutGroup>

                    </Items>
                </dx:GridViewLayoutGroup>         

            </Items>
        </EditFormLayoutProperties>

        <Columns>       
            
            <dx:GridViewDataTextColumn FieldName="ID" Width="10%" SortOrder="Descending" />            
            <dx:GridViewDataTextColumn FieldName="slug" Visible ="false" /> 
            <dx:GridViewDataComboBoxColumn FieldName="Type" Caption="Категория" MinWidth="150" Width="20%" AdaptivePriority="0" >
                <PropertiesComboBox DataSourceID="TypeDS" TextField="MetaName" ValueField="ID">
                    <ValidationSettings ValidateOnLeave="true" ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom" 
                        RequiredField-IsRequired="true" RequiredField-ErrorText="Поле не заполнено" ErrorFrameStyle-Font-Size="Smaller" 
                        SetFocusOnError="true" />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            
            <dx:GridViewDataComboBoxColumn FieldName="District" Caption="Район" MinWidth="150" Width="20%" AdaptivePriority="0" >
                <PropertiesComboBox DataSourceID="DistrictDS" TextField="MetaName" ValueField="ID" >
                    <ValidationSettings ValidateOnLeave="true" ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom" 
                        RequiredField-IsRequired="true" RequiredField-ErrorText="Поле не заполнено" ErrorFrameStyle-Font-Size="Smaller" 
                        SetFocusOnError="true" />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            
            <dx:GridViewDataTextColumn FieldName="Complex" Caption="ЖК" MinWidth="150"  Width="20%" AdaptivePriority="0" />
            
            <dx:GridViewDataTextColumn FieldName="Name" Caption="Название" MinWidth="160" Width="20%" AdaptivePriority="5">
                <PropertiesTextEdit>
                    <ValidationSettings ValidateOnLeave="true" ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom" 
                        RequiredField-IsRequired="true" RequiredField-ErrorText="Поле не заполнено" ErrorFrameStyle-Font-Size="Smaller" 
                        SetFocusOnError="true" />
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataSpinEditColumn FieldName="Price" Caption="Цена, руб." MinWidth="120" Width="10%" AdaptivePriority="1">
                <PropertiesSpinEdit NumberFormat="Currency" DisplayFormatInEditMode="true" SpinButtons-ShowIncrementButtons="false" >
                    <ValidationSettings ValidateOnLeave="true" ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom" 
                        RequiredField-IsRequired="true" RequiredField-ErrorText="Поле не заполнено" ErrorFrameStyle-Font-Size="Smaller" 
                        SetFocusOnError="true" />
                </PropertiesSpinEdit>
            </dx:GridViewDataSpinEditColumn>
          
            <dx:GridViewDataComboBoxColumn FieldName="Status" Caption="Статус" MinWidth="150" Width="10%" AdaptivePriority="6">
                <PropertiesComboBox DataSourceID="StatusDS" TextField="MetaName" ValueField="ID">
                    <ValidationSettings ValidateOnLeave="true" ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom" 
                        RequiredField-IsRequired="true" RequiredField-ErrorText="Поле не заполнено" ErrorFrameStyle-Font-Size="Smaller" 
                        SetFocusOnError="true" />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>            

            <dx:GridViewDataTextColumn FieldName="Rooms" Caption="Кол-во комнат, шт." MinWidth="100" Width="10%" AdaptivePriority="3"  />             
            
            <dx:GridViewDataColumn FieldName="FloorString" Caption="Этаж" UnboundType="String" UnboundExpression="[Floor]+'/'+[TotalFloor]" MinWidth="100" Width="10%" AdaptivePriority="4" />            

            <dx:GridViewDataSpinEditColumn FieldName="ApartmentArea" Caption="Площадь, м<sup>2</sup>" MinWidth="100" Width="10%" AdaptivePriority="2">
                <PropertiesSpinEdit NumberType="Float" SpinButtons-ShowIncrementButtons="false">
                    <ValidationSettings ValidateOnLeave="true" ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom" 
                        RequiredField-IsRequired="true" RequiredField-ErrorText="Поле не заполнено" ErrorFrameStyle-Font-Size="Smaller" 
                        SetFocusOnError="true" />
                </PropertiesSpinEdit>
            </dx:GridViewDataSpinEditColumn>

            <dx:GridViewDataCheckColumn FieldName="Foto" Caption="Фото" MinWidth="100" Width="10%" AdaptivePriority="2" />

            <dx:GridViewDataTextColumn FieldName="ActualStatus" Caption="Актуальность" MinWidth="120" Width="10%" AdaptivePriority="0" />









            <dx:GridViewDataSpinEditColumn FieldName="RoomsNumber" Caption="Кол-во комнат, шт." MinWidth="100" Width="10%" Visible="false" >
                <PropertiesSpinEdit MinValue="0" MaxValue="100" NumberType="Integer" />
            </dx:GridViewDataSpinEditColumn>
            
            <dx:GridViewDataSpinEditColumn FieldName="Floor" Caption="Этаж" MinWidth="100" Width="10%" Visible="false" PropertiesSpinEdit-NumberType="Integer" />

            <dx:GridViewDataSpinEditColumn FieldName="TotalFloor" Caption="Всего этажей" MinWidth="100" Width="10%" Visible="false" PropertiesSpinEdit-NumberType="Integer" />

            <dx:GridViewDataDateColumn FieldName="LastUpdate" Caption="Обновление" MinWidth="130" Width="10%" 
                PropertiesDateEdit-DisplayFormatString="dd.MM.yyyy HH:mm" Visible="false" />

            <dx:GridViewDataCheckColumn FieldName="Sale" Caption="Продано" MinWidth="100" Width="10%" PropertiesCheckEdit-AllowGrayed="false" Visible="false"  />

            <dx:GridViewDataDateColumn FieldName="ActualUntil" Caption="Актуально до" MinWidth="130" Width="10%" Visible="false" PropertiesDateEdit-NullText="По умолчанию +1 месяц" />

            <dx:GridViewDataTextColumn FieldName="Street"  Caption="Улица" MinWidth="150" Width="10%" Visible="false" />

            <dx:GridViewDataComboBoxColumn FieldName="Condition"  Caption="Условия" MinWidth="150" Width="10%" Visible="false">
                <PropertiesComboBox DataSourceID="ConditionDS" TextField="MetaName" ValueField="ID">
                    <ValidationSettings ValidateOnLeave="true" ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom" 
                        RequiredField-IsRequired="true" RequiredField-ErrorText="Поле не заполнено" ErrorFrameStyle-Font-Size="Smaller" 
                        SetFocusOnError="true" />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn FieldName="Registration" Caption="Оформление" MinWidth="150" Width="10%" Visible="false">
                <PropertiesComboBox DataSourceID="RegistrationDS" TextField="MetaName" ValueField="ID">
                    <ValidationSettings ValidateOnLeave="true" ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom" 
                        RequiredField-IsRequired="true" RequiredField-ErrorText="Поле не заполнено" ErrorFrameStyle-Font-Size="Smaller" 
                        SetFocusOnError="true" />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn FieldName="Stove" Caption="Плита" MinWidth="100" Width="10%" Visible="false">
                <PropertiesComboBox DataSourceID="StoveDS" TextField="MetaName" ValueField="ID" AllowNull="true" />
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn FieldName="WindowView" Caption="Вид из окна" MinWidth="100" Width="10%" Visible="false">
                <PropertiesComboBox DataSourceID="WindowViewDS" TextField="MetaName" ValueField="ID" />
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataSpinEditColumn FieldName="ToSea" Caption="До моря, м" MinWidth="100" Width="10%" Visible="false" >
                <PropertiesSpinEdit NumberType="Integer" SpinButtons-ShowIncrementButtons="false" />
            </dx:GridViewDataSpinEditColumn>

            <dx:GridViewDataSpinEditColumn FieldName="LandArea" Caption="Площадь участка, м<sup>2</sup>" MinWidth="100" Width="10%" Visible="false" >
                <PropertiesSpinEdit NumberType="Float" SpinButtons-ShowIncrementButtons="false" />
            </dx:GridViewDataSpinEditColumn>

            <dx:GridViewDataCheckColumn FieldName="Ipoteka" Caption="Ипотека" MinWidth="100" Width="10%" PropertiesCheckEdit-AllowGrayed="false" Visible="false"  />      

            <dx:GridViewDataCheckColumn FieldName="VIP" Caption="VIP объявление" MinWidth="100" Width="10%" PropertiesCheckEdit-AllowGrayed="false" Visible="false" />

            <dx:GridViewDataCheckColumn FieldName="ElitProperty" Caption="Элитная недвижимость" MinWidth="100" Width="10%" PropertiesCheckEdit-AllowGrayed="false" Visible="false" />

            <dx:GridViewDataCheckColumn FieldName="Hide" Caption="Скрыто" MinWidth="100" Width="10%" PropertiesCheckEdit-AllowGrayed="false" Visible="false" />

            <dx:GridViewDataMemoColumn FieldName="Description" Caption="Описание" MinWidth="100" Width="10%" Visible="false" >
                <PropertiesMemoEdit Rows="7">
                    <ValidationSettings ValidateOnLeave="true" ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom" 
                        RequiredField-IsRequired="true" RequiredField-ErrorText="Поле не заполнено" ErrorFrameStyle-Font-Size="Smaller" 
                        SetFocusOnError="true" />
                </PropertiesMemoEdit>
            </dx:GridViewDataMemoColumn>  
            

        
        </Columns>

        <Toolbars>            
            <dx:GridViewToolbar SettingsAdaptivity-EnableCollapseRootItemsToIcons="true">
                <Items>                    
                    <dx:GridViewToolbarItem Command="Refresh" Text="Обновить" />
                    <dx:GridViewToolbarItem Command="New" BeginGroup="true" Text="Добавить" />
                    <dx:GridViewToolbarItem Command="Edit" BeginGroup="true" Text="Редактировать" />
                    <dx:GridViewToolbarItem Command="Delete" BeginGroup="true" Text="Удалить" />
                    <dx:GridViewToolbarItem Name="Foto" Text="Фотографии" BeginGroup="true" Image-Url="Content/Icons/CameraIcon.png" />
                    <dx:GridViewToolbarItem Name="View" Text="Посмотреть" BeginGroup="true" Image-Url="Content/Icons/EyeIcon.png" />
                </Items>
            </dx:GridViewToolbar>
        </Toolbars>

        <FormatConditions>
            <dx:GridViewFormatConditionHighlight FieldName="ActualStatus" Expression="ActualStatus = 'Продано' " Format="YellowFillWithDarkYellowText"  />
            <dx:GridViewFormatConditionHighlight FieldName="ActualStatus" Expression="ActualStatus = 'Не актуально'" Format="LightRedFillWithDarkRedText"  />
            <dx:GridViewFormatConditionHighlight FieldName="ActualStatus" Expression="ActualStatus = 'Скрыто'" Format="Custom" RowStyle-ForeColor="LightGray" ApplyToRow="true"  />
        </FormatConditions>

    </dx:ASPxGridView>




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




    <asp:SqlDataSource ID="PropertyRegisterDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>' 
        
        SelectCommand="exec dbo.PropertyRegister" 
        
        InsertCommand=" " 
        
        DeleteCommand="delete from [dbo].[PropertyObjects] where ID = @ID
                       delete from [dbo].[PropertyObjectsMetaData] where ObjectID = @ID " 
        
        UpdateCommand=" " >

        <DeleteParameters>
            <asp:Parameter Name="ID" />
        </DeleteParameters>

    </asp:SqlDataSource>
 
    

    <dx:ASPxPopupControl ID="FotoPopup" ClientInstanceName="FotoPopup" runat="server" Modal="true"  
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" HeaderText="" AllowDragging="true"
        AutoUpdatePosition="true" HeaderStyle-HorizontalAlign="Center" ShowCloseButton="true" CloseAction="CloseButton">
        
        <ClientSideEvents Closing="function(s,e){ FileManager.SetCurrentFolderPath('Foto'); HiddenField.Set('OpenFotoID', ''); }" />

        <SettingsAdaptivity Mode="Always" VerticalAlign="WindowCenter" MaxWidth="900px"  />
        
        <ContentStyle Paddings-Padding="20px" />

        <ContentCollection>
            <dx:PopupControlContentControl runat="server">

                <dx:ASPxFileManager ID="FileManager" ClientInstanceName="FileManager" runat="server" Width="100%" OnCustomCallback="FileManager_CustomCallback"      
                    OnFilesUploaded="FileManager_FilesUploaded" OnItemsDeleted="FileManager_ItemsDeleted" OnFileUploading="FileManager_FileUploading">

                    <ClientSideEvents FilesUploaded="function(s,e){ PropertyRegisterGrid.Refresh(); }" 
                        ItemsDeleted="function(s,e){ PropertyRegisterGrid.Refresh(); }" 
                        SelectionChanged="function(s,e){ SelectionChanged(); }" 
                        CustomCommand="function(s,e){ if(e.commandName == 'CstmBtn'){ FileManager.PerformCallback(FileManager.GetSelectedFile().imageSrc); } }" 
                        EndCallback="function(s,e){ SelectionChanged(); }" />

                    <Settings RootFolder="~/Content/Foto" ThumbnailFolder="~\Content\Thumb\PropertyRegisterThumb"  AllowedFileExtensions=".jpg,.jpeg,.png" EnableMultiSelect="true" />
                    <SettingsFolders Visible="false" />
                    <SettingsEditing AllowDelete="true" AllowRename="true" AllowDownload="true" />
                    <SettingsAdaptivity Enabled="true" />
                    <SettingsToolbar ShowFilterBox="false" ShowPath="false" >                        
                        <Items>
                            <dx:FileManagerToolbarRefreshButton />
                            <dx:FileManagerToolbarDeleteButton />
                            <dx:FileManagerToolbarDownloadButton />
                            <dx:FileManagerToolbarUploadButton BeginGroup="true" Text="Загрузить" />
                            <dx:FileManagerToolbarCustomButton BeginGroup="true" Text="Назначить главное фото" CommandName="CstmBtn" ItemStyle-VerticalAlign="Middle" ClientEnabled="false" />
                        </Items>
                    </SettingsToolbar>
                    <SettingsUpload AdvancedModeSettings-EnableMultiSelect="true" AutoStartUpload="true" UseAdvancedUploadMode="true" ShowUploadPanel="false"/>
                    <SettingsContextMenu Enabled="true" />

                </dx:ASPxFileManager>


            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>


    <script type="text/javascript">

        function OpenFoto() {
            HiddenField.Set("OpenFotoID", PropertyRegisterGrid.GetRowKey(PropertyRegisterGrid.GetFocusedRowIndex()))
            FileManager.SetCurrentFolderPath(HiddenField.Get("OpenFotoID"));
            FotoPopup.Show();
            PropertyRegisterGrid.GetRowValues(PropertyRegisterGrid.GetFocusedRowIndex(), 'Name', fCheckCF)
        }

        function fCheckCF(vl) {

            FotoPopup.SetHeaderText(vl)
              
        }

        function fOpenPage(s, e) {
            PropertyRegisterGrid.GetRowValues(PropertyRegisterGrid.GetFocusedRowIndex(), 'slug', fRedirect)
            
        }

        function fRedirect(vl) {
            var redirectWindow = window.open('object/' + vl);
            redirectWindow.location;
        }

        function SelectionChanged() {
            if (FileManager.GetSelectedItems().length == 1) {
                FileManager.GetToolbar(0).GetItemByName('CstmBtn').SetEnabled(1);
            }
            else {
                FileManager.GetToolbar(0).GetItemByName('CstmBtn').SetEnabled(0);
            }
        }

    </script>



</asp:Content>
