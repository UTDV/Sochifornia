<%@ Page Title="Список публикаций" Language="vb" AutoEventWireup="false" MasterPageFile="~/DeepWeb.Master" CodeBehind="PostRegister.aspx.vb" Inherits="WebEstateProject.PostRegister" %>

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <dx:ASPxGridView ID="PostsRegisterGrid" ClientInstanceName="PostsRegisterGrid" runat="server" Width="100%" Style="margin-bottom: 20px"
        DataSourceID="PostsRegisterDS" KeyFieldName="ID" AutoGenerateColumns="False" Styles-Cell-Paddings-Padding="5px" CssClass="PropertyRegisterFontSize"
        Settings-AutoFilterCondition="Contains" SettingsBehavior-AllowEllipsisInText="true"
        Styles-Header-Wrap="True">


        <StylesToolbar>
            <Item CssClass="PropertyRegisterFontSize" />
        </StylesToolbar>

        <ClientSideEvents Init="function (s,e) {  }"
            ToolbarItemClick="function (s,e) { 
            
            if(e.item.name == 'New') {  fOpenPage(s,e);  } 
            if(e.item.name == 'Edit') { if(PostsRegisterGrid.GetFocusedRowIndex() == null || PostsRegisterGrid.GetFocusedRowIndex() == -1) { alert('Выберите объект'); } else { fOpenPage(s,e); } } 
            if(e.item.name == 'View') { if(PostsRegisterGrid.GetFocusedRowIndex() == null || PostsRegisterGrid.GetFocusedRowIndex() == -1) { alert('Выберите объект'); } else { fOpenPage(s,e); } } }"
            RowDblClick="function (s,e) {  }" />

        <SettingsBehavior AllowFocusedRow="true" EnableCustomizationWindow="true" ConfirmDelete="true" />

        <SettingsContextMenu Enabled="true" EnableRowMenu="False">
            <ColumnMenuItemVisibility ShowCustomizationDialog="true" ShowCustomizationWindow="true" />
        </SettingsContextMenu>

        <Settings VerticalScrollBarMode="Hidden" ShowHeaderFilterButton="True" ShowFilterRow="false" />

        <SettingsPager PageSize="15"  />

        <SettingsAdaptivity AdaptivityMode="HideDataCells"  AllowHideDataCellsByColumnMinWidth="true" />

        <SettingsSearchPanel Visible="true" />


        <Columns>
            <dx:GridViewDataTextColumn Name="ID" FieldName="ID" Caption="№" VisibleIndex="0" MaxWidth="50" />
            <dx:GridViewDataTextColumn Name="Creator" FieldName="Created" Caption="Дата" VisibleIndex="1" MaxWidth="150"  />
            <dx:GridViewDataTextColumn Name="Header" FieldName="Header" Caption="Заголовок" VisibleIndex="3"  />
            <dx:GridViewDataTextColumn Name="Creator" FieldName="CreatorName" Caption="Автор" VisibleIndex="2" MaxWidth="200" />
            <dx:GridViewDataTextColumn Name="Status" FieldName="Status" Caption="Статус" VisibleIndex="4" MaxWidth="250" />
            <dx:GridViewDataTextColumn Name="Category" FieldName="Category" Caption="Категория" VisibleIndex="5" MaxWidth="250"  />
            <dx:GridViewDataTextColumn Name="Slug" FieldName="Slug" Caption="Slug" VisibleIndex="6" Visible="false" />
        </Columns>

        <Toolbars>
            <dx:GridViewToolbar SettingsAdaptivity-EnableCollapseRootItemsToIcons="true">
                <Items>
                    <dx:GridViewToolbarItem Command="Refresh" Text="Обновить" />
                    <dx:GridViewToolbarItem Name="New" BeginGroup="true" Text="Добавить" />
                    <dx:GridViewToolbarItem Name="Edit" BeginGroup="true" Text="Редактировать" />
                    <dx:GridViewToolbarItem Command="Delete" BeginGroup="true" Text="Удалить" />

                    <dx:GridViewToolbarItem Name="View" Text="Предпросмотр" BeginGroup="true" Image-Url="Content/Icons/EyeIcon.png" />
                </Items>
            </dx:GridViewToolbar>
        </Toolbars>

    </dx:ASPxGridView>


    <asp:SqlDataSource ID="PostsRegisterDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>'
        SelectCommand="EXEC  dbo.PostsRegister @UserGUID"
        DeleteCommand="delete from [dbo].[Posts] where ID = @ID
                       delete from [dbo].[PostsMetaData] where PostID = @ID ">

        <SelectParameters>
            <asp:SessionParameter Name="UserGUID" SessionField="UserGUID" />
        </SelectParameters>

        <DeleteParameters>
            <asp:Parameter Name="ID" />
        </DeleteParameters>

    </asp:SqlDataSource>


    <dx:ASPxPopupControl ID="PostCategoryPopup" ClientInstanceName="TypePopup" runat="server" Modal="true"
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" HeaderText="Выберите тип страницы" AllowDragging="true"
        AutoUpdatePosition="true" HeaderStyle-HorizontalAlign="Center" ShowCloseButton="false" CloseAction="None" >
        

        <SettingsAdaptivity Mode="Always" VerticalAlign="WindowCenter" MaxWidth="300px" />

        <ContentStyle Paddings-Padding="20px" />

        <ContentCollection>
            <dx:PopupControlContentControl runat="server">

                <dx:ASPxComboBox ID="PostCategory" ClientInstanceName="PostCategory" runat="server" DataSourceID="PostCategoryDS" 
                    ValueField ="ID" TextField ="MetaName" Width="100%" CssClass="mb-3" />

                <div class="row justify-content-around">

                    <dx:ASPxButton ID="CancelBtn" ClientInstanceName="CancelBtn" runat="server" AutoPostBack="false" Text="Отмена" RenderMode="Secondary">
                        <ClientSideEvents Click="function (s,e) { PostCategory.SetValue(''); TypePopup.HideWindow(); }" />
                    </dx:ASPxButton>

                    <dx:ASPxButton ID="CreateBtn" ClientInstanceName="CreateBtn" runat="server" AutoPostBack="false" Text="Создать" >
                        <ClientSideEvents Click="function (s,e) {
                            if(PostCategory.GetValue() != null) {
                                                                var redirectWindow = window.open('PostEditPage.aspx?slug=new&type='+PostCategory.GetValue()); 
                                                                PostCategory.SetValue('');
                                                                TypePopup.HideWindow(); 
                                                                redirectWindow.location;  
                                                                    }
                            }" />

                    </dx:ASPxButton>
                    
                </div>

                <asp:SqlDataSource ID="PostCategoryDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>'
                    SelectCommand=" SELECT ID, MetaName
                                    FROM [dbo].[PostsMetaNames]
                                    where MetaCategory = @Category 
                                      and NoShow = 0
                                    order by OrderBy">
                    <SelectParameters>
                        <asp:Parameter Name="Category" DefaultValue="Категория" DbType="String" />
                    </SelectParameters>
                </asp:SqlDataSource>

            </dx:PopupControlContentControl>
        </ContentCollection>


    </dx:ASPxPopupControl>

    <dx:ASPxCallback ID="CBackView" ClientInstanceName="CBackView" runat="server" OnCallback="CBackView_Callback">
        <ClientSideEvents CallbackComplete="function(s,e) { CBackViewResult(e.result); }" />
    </dx:ASPxCallback>

    <script type="text/javascript">


        function fOpenPage(s, e) {

            if (e.item.name == 'New') {
                TypePopup.Show();
            }
            else if (e.item.name == 'Edit') {
                PostsRegisterGrid.GetRowValues(PostsRegisterGrid.GetFocusedRowIndex(), 'ID', fEditRedirect)
            }
            else if (e.item.name == 'View') {
                PostsRegisterGrid.GetRowValues(PostsRegisterGrid.GetFocusedRowIndex(), 'ID', fViewRedirect)
            }

        }

        function fEditRedirect(vl) {
            var redirectWindow = window.open('PostEditPage.aspx?id=' + vl);
            redirectWindow.location;
        }

        function fViewRedirect(vl) {
            CBackView.PerformCallback(vl);
        }

        function CBackViewResult(vl) {
            if (vl == 'error') {
                alert('Что-то пошло не так...');
            }
            else if (vl == 'noslug') {
                alert('Не указан slug');
            }
            else {
                var redirectWindow = window.open(vl + '?ViewType=view');
                redirectWindow.location;
            }
        }

    </script>



</asp:Content>
