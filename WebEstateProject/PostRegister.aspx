<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/DeepWeb.Master" CodeBehind="PostRegister.aspx.vb" Inherits="WebEstateProject.PostRegister" %>

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
            RowDblClick="function (s,e) { fOpenPage(s,e); }" />

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
        AutoUpdatePosition="true" HeaderStyle-HorizontalAlign="Center" ShowCloseButton="true" CloseAction="CloseButton" >
        

        <SettingsAdaptivity Mode="Always" VerticalAlign="WindowCenter" MaxWidth="250px" />

        <ContentStyle Paddings-Padding="20px" />

        <ContentCollection>
            <dx:PopupControlContentControl runat="server">

                <dx:ASPxComboBox ID ="PostCategory" runat ="server" ClientInstanceName ="PostCategory" DataSourceID ="PostCategoryDS" ValueField ="ID" TextField ="MetaName">

                </dx:ASPxComboBox>
                <p />
                <dx:ASPxButton ID ="CreateBtn" ClientInstanceName ="CreateBtn" runat ="server" AutoPostBack ="false" Text ="Создать">
                    <ClientSideEvents Click ="function (s,e) {
                                                                var redirectWindow = window.open('PostEditPage.aspx?slug=new&type='+PostCategory.GetValue()); 
                                                                PostCategory.SetValue('');
                                                                TypePopup.HideWindow(); 
                                                                redirectWindow.location;  
                                                                    }" />

                </dx:ASPxButton>
                <dx:ASPxButton ID ="CancelBtn" ClientInstanceName ="CancelBtn" runat ="server" AutoPostBack ="false" Text ="Отмена" RenderMode ="Secondary"  >
                    <ClientSideEvents Click ="function (s,e) { PostCategory.SetValue(''); TypePopup.HideWindow(); }" />
                </dx:ASPxButton>


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

    <script type="text/javascript">


        function fOpenPage(s, e) {

            if (e.item.name == 'New') {
                TypePopup.Show();
            }
            else {
                PostsRegisterGrid.GetRowValues(PostsRegisterGrid.GetFocusedRowIndex(), 'ID', fRedirect)
            }

        }

        function fRedirect(vl) {
            var redirectWindow = window.open('PostEditPage.aspx?id=' + vl);
            redirectWindow.location;
        }

    </script>



</asp:Content>
