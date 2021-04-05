<%@ Page Title="Недвижимость Сочи" Language="vb" AutoEventWireup="false" MasterPageFile="~/DeepWeb.Master" CodeBehind="PropertyRegister.aspx.vb" Inherits="WebEstateProject.PropertyRegister" %>

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">



    <dx:ASPxGridView ID="PropertyRegisterGrid" ClientInstanceName="PropertyRegisterGrid" runat="server" Width="100%" Style="margin-bottom:20px"    
        DataSourceID="PropertyRegisterDS" KeyFieldName="ID" AutoGenerateColumns="False" Styles-Cell-Paddings-Padding="5px" CssClass="PropertyRegisterFontSize"   
        Settings-AutoFilterCondition="Contains"  SettingsBehavior-AllowEllipsisInText="true" OnRowDeleted="PropertyRegisterGrid_RowDeleted" 
        Styles-Header-Wrap="True" >

        <StylesToolbar>
            <Item CssClass="PropertyRegisterFontSize" />
        </StylesToolbar>

        <ClientSideEvents 
            ToolbarItemClick="function (s,e) { 
            if(e.item.name == 'CustomNew') { LoadingPanel.Show(); CBackCreateNewObject.PerformCallback(); } 
            if(e.item.name == 'View') { if(PropertyRegisterGrid.GetFocusedRowIndex() == null || PropertyRegisterGrid.GetFocusedRowIndex() == -1) { alert('Выберите объект'); } else { fOpenPage(s,e); } }
            if(e.item.name == 'CustomEdit') { var redirectWindow = window.open('PropertyData.aspx?id=' + s.GetRowKey(s.GetFocusedRowIndex()) ); redirectWindow.location; }
            }" 
            RowDblClick="function (s,e) { fOpenPage(s,e); }" />

        <SettingsBehavior AllowFocusedRow="true" EnableCustomizationWindow="true" ConfirmDelete="true" />

        <SettingsContextMenu Enabled="true" EnableRowMenu="False" >
            <ColumnMenuItemVisibility ShowCustomizationDialog="true" ShowCustomizationWindow="true" />
        </SettingsContextMenu>

        <Settings VerticalScrollBarMode="Hidden" ShowHeaderFilterButton="True" ShowFilterRow="false" />

        <SettingsPager PageSize="15" />

        <SettingsEditing Mode="EditForm" />

        <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true" AllowHideDataCellsByColumnMinWidth="true"  />

        <SettingsSearchPanel Visible="true" />

        <SettingsDataSecurity AllowDelete="true" AllowEdit="false" AllowInsert="false" />      

        <Columns>       
            
            <dx:GridViewDataTextColumn FieldName="ID" Width="10%" SortOrder="Descending" /> 
            
            <dx:GridViewDataTextColumn FieldName="slug" Visible ="false" /> 

            <dx:GridViewDataTextColumn FieldName ="Type" Caption="Категория" MinWidth="150" Width="20%" AdaptivePriority="0" />

            <dx:GridViewDataTextColumn FieldName ="District" Caption="Район" MinWidth="150" Width="20%" AdaptivePriority="0" />            
            
            <dx:GridViewDataTextColumn FieldName="Complex" Caption="ЖК" MinWidth="150"  Width="20%" AdaptivePriority="0" />

            <dx:GridViewDataTextColumn FieldName ="Name" Caption="Название" MinWidth="160" Width="20%" AdaptivePriority="5" Visible="false" />

            <dx:GridViewDataSpinEditColumn FieldName="Price" Caption="Цена, руб." MinWidth="120" Width="10%" AdaptivePriority="1">
                <PropertiesSpinEdit NumberFormat="Currency" DisplayFormatInEditMode="true" SpinButtons-ShowIncrementButtons="false" />
            </dx:GridViewDataSpinEditColumn>
          
            <dx:GridViewDataTextColumn FieldName ="Status" Caption="Статус" MinWidth="150" Width="10%" AdaptivePriority="6"/>       

            <dx:GridViewDataTextColumn FieldName="Rooms" Caption="Кол-во комнат, шт." MinWidth="100" Width="10%" AdaptivePriority="3"  />   

            <dx:GridViewDataColumn FieldName="FloorString" Caption="Этаж" UnboundType="String" UnboundExpression="[Floor]+'/'+[TotalFloor]" MinWidth="100" Width="10%" AdaptivePriority="4" />            

            <dx:GridViewDataSpinEditColumn FieldName="ApartmentArea" Caption="Площадь, м<sup>2</sup>" MinWidth="100" Width="10%" AdaptivePriority="2">
                <PropertiesSpinEdit NumberType="Float" SpinButtons-ShowIncrementButtons="false" />
            </dx:GridViewDataSpinEditColumn>

            <dx:GridViewDataCheckColumn FieldName="Foto" Caption="Фото" MinWidth="100" Width="10%" AdaptivePriority="2" />

            <dx:GridViewDataTextColumn FieldName="AdStatus" Caption="Статус объявления" MinWidth="120" Width="10%" AdaptivePriority="0" />

            <dx:GridViewDataTextColumn FieldName="Creator" Caption="Создал" MinWidth="120" Width="10%" AdaptivePriority="5" />




                       
            
            
           

            <dx:GridViewDataDateColumn FieldName="LastUpdate" Caption="Обновление" MinWidth="130" Width="10%" 
                PropertiesDateEdit-DisplayFormatString="dd.MM.yyyy HH:mm" Visible="false" />

            <dx:GridViewDataDateColumn FieldName="ActualUntil" Caption="Актуально до" MinWidth="130" Width="10%" Visible="false" />

            <dx:GridViewDataTextColumn FieldName="Street"  Caption="Улица" MinWidth="150" Width="10%" Visible="false" />

            <dx:GridViewDataTextColumn FieldName="Condition"  Caption="Условия" MinWidth="150" Width="10%" Visible="false" />

            <dx:GridViewDataTextColumn FieldName="Registration"  Caption="Оформление" MinWidth="150" Width="10%" Visible="false" />

            <dx:GridViewDataTextColumn FieldName="Stove"  Caption="Плита" MinWidth="100" Width="10%" Visible="false" />

            <dx:GridViewDataTextColumn FieldName="WindowView"  Caption="Вид из окна" MinWidth="100" Width="10%" Visible="false" />

            <dx:GridViewDataSpinEditColumn FieldName="ToSea" Caption="До моря, м" MinWidth="100" Width="10%" Visible="false" >
                <PropertiesSpinEdit NumberType="Integer" SpinButtons-ShowIncrementButtons="false" />
            </dx:GridViewDataSpinEditColumn>

            <dx:GridViewDataSpinEditColumn FieldName="LandArea" Caption="Площадь участка, м<sup>2</sup>" MinWidth="100" Width="10%" Visible="false" >
                <PropertiesSpinEdit NumberType="Float" SpinButtons-ShowIncrementButtons="false" />
            </dx:GridViewDataSpinEditColumn>

            <dx:GridViewDataCheckColumn FieldName="Ipoteka" Caption="Ипотека" MinWidth="100" Width="10%" PropertiesCheckEdit-AllowGrayed="false" Visible="false"  />      

            <dx:GridViewDataCheckColumn FieldName="VIP" Caption="VIP объявление" MinWidth="100" Width="10%" PropertiesCheckEdit-AllowGrayed="false" Visible="false" />

            <dx:GridViewDataCheckColumn FieldName="ElitProperty" Caption="Элитная недвижимость" MinWidth="100" Width="10%" PropertiesCheckEdit-AllowGrayed="false" Visible="false" />

            <dx:GridViewDataMemoColumn FieldName="Description" Caption="Описание" MinWidth="100" Width="10%" Visible="false" >
                <PropertiesMemoEdit Rows="7">
                    <ValidationSettings ValidateOnLeave="true" ErrorDisplayMode="Text" Display="Dynamic" ErrorTextPosition="Bottom" 
                        RequiredField-IsRequired="true" RequiredField-ErrorText="Поле не заполнено" ErrorFrameStyle-Font-Size="Smaller" 
                        SetFocusOnError="true" />
                </PropertiesMemoEdit>
            </dx:GridViewDataMemoColumn>  
            
            <dx:GridViewDataTextColumn FieldName="posrednik"  Caption="Посредник" MinWidth="150" Width="10%" Visible="false" />            

            <dx:GridViewDataTextColumn FieldName="Comission" Caption="Комиссия" MinWidth="120" Width="10%" AdaptivePriority="5" Visible ="false" />
        
        </Columns>

        <Toolbars>            
            <dx:GridViewToolbar SettingsAdaptivity-EnableCollapseRootItemsToIcons="true">
                <Items>                    
                    <dx:GridViewToolbarItem Command="Refresh" Text="Обновить" />
                    <dx:GridViewToolbarItem Name="CustomNew" BeginGroup="true" Text="Добавить" Image-Url="Content/Icons/plus.png" />
                    <dx:GridViewToolbarItem Name="CustomEdit" BeginGroup="true" Text="Редактировать" Image-Url="Content/Icons/pencil.png" />
                    <dx:GridViewToolbarItem Command="Delete" BeginGroup="true" Text="Удалить" />
                    <dx:GridViewToolbarItem Name="View" Text="Посмотреть" BeginGroup="true" Image-Url="Content/Icons/EyeIcon.png" />                    
                </Items>
            </dx:GridViewToolbar>
        </Toolbars>

        <FormatConditions>
            <dx:GridViewFormatConditionHighlight FieldName="AdStatus" Expression="AdStatus = 'Черновик' " Format="Custom" CellStyle-BackColor="#66ccff" />
            <dx:GridViewFormatConditionHighlight FieldName="AdStatus" Expression="AdStatus = 'Продано' " Format="YellowFillWithDarkYellowText"  />
            <dx:GridViewFormatConditionHighlight FieldName="AdStatus" Expression="AdStatus = 'Архив'" Format="LightRedFillWithDarkRedText"  />
            <dx:GridViewFormatConditionHighlight FieldName="AdStatus" Expression="AdStatus = 'Скрыто'" Format="Custom" RowStyle-ForeColor="LightGray" ApplyToRow="true"  />
        </FormatConditions>

    </dx:ASPxGridView>






    <asp:SqlDataSource ID="PropertyRegisterDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>' 
        
        SelectCommand="exec dbo.PropertyRegister @GUID"        

        
        DeleteCommand="delete from [dbo].[PropertyObjects] where ID = @ID
                       delete from [dbo].[PropertyObjectsMetaData] where ObjectID = @ID " >

        <SelectParameters>
            <asp:SessionParameter Name="GUID" SessionField="GUID" DbType="Guid" />
        </SelectParameters>

        <DeleteParameters>
            <asp:Parameter Name="ID" />
        </DeleteParameters>

    </asp:SqlDataSource>
 
    

    <dx:ASPxCallback ID="CBackCreateNewObject" ClientInstanceName="CBackCreateNewObject" runat="server" OnCallback="CBackCreateNewObject_Callback">
        <ClientSideEvents CallbackComplete="function(s,e){ CBackCreateNewObjectResult(e.result); }" />
    </dx:ASPxCallback>

    <dx:ASPxLoadingPanel ID="LoadingPanel" ClientInstanceName="LoadingPanel" runat="server" Modal="true" Text="Создание..." />

    

    <script type="text/javascript">

        function fOpenPage(s, e) {
            PropertyRegisterGrid.GetRowValues(PropertyRegisterGrid.GetFocusedRowIndex(), 'slug', fRedirect)
            
        }

        function fRedirect(vl) {
            var redirectWindow = window.open('object/' + vl);
            redirectWindow.location;
        }


        function CBackCreateNewObjectResult(vl) {

            LoadingPanel.Hide();
            PropertyRegisterGrid.Refresh();

            if (vl == '0') {
                alert('Что-то пошло не так... Попробуйте еще раз или обратитесь к разработчику');
            }
            else if (vl.startsWith('1') == true) {
                var redirectWindow = window.open('PropertyData.aspx?id=' + vl.substring(2));
                redirectWindow.location;
            }
        }

    </script>


</asp:Content>
