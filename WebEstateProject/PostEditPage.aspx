<%@ Page Title="Редактор страницы" Language="vb" AutoEventWireup="false" MasterPageFile="~/DeepWeb.Master" CodeBehind="PostEditPage.aspx.vb" Inherits="WebEstateProject.PostEditPage" %>

<%@ Register Assembly="DevExpress.Web.ASPxHtmlEditor.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxHtmlEditor" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web.ASPxSpellChecker" Assembly="DevExpress.Web.ASPxSpellChecker.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <dx:ASPxCallbackPanel ID="MN_Panel" runat="server" Width="100%" 
        OnCallback="MN_Panel_Callback" OnPreRender="MN_Panel_PreRender" OnBeforeGetCallbackResult="MN_Panel_BeforeGetCallbackResult" 
        ClientInstanceName="MN_Panel" EnableCallbackAnimation="true" SettingsLoadingPanel-Text="Сохранение">
        <PanelCollection>
            <dx:PanelContent runat="server">

                <dx:ASPxFormLayout ID="PostForm" runat="server" ClientInstanceName="PostFormIN" DataSourceID="PostDS" ColumnCount="3" Width="100%">

                    <SettingsAdaptivity GridSettings-StretchLastItem="True" AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="1200" />

                    <Items>

                        <dx:LayoutGroup ShowCaption="False" ColumnSpan="2">
                            <Items>

                                <dx:LayoutItem FieldName="Header" Caption="Заголовок">                                    
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            
                                            <dx:ASPxTextBox runat="server" Width="100%" ID="Header_TB" ClientInstanceName="Header_TB">
                                                <ClientSideEvents TextChanged="function (s,e) {CBack_TB.PerformCallback(Header_TB.GetText());}" />
                                            </dx:ASPxTextBox>

                                            <dx:ASPxCallback ID="CBack_TB" runat="server" ClientInstanceName="CBack_TB" OnCallback="CBack_Callback_TB">
                                                <ClientSideEvents CallbackComplete="function (s,e) {Slug_TB.SetText(e.result);}"/>
                                            </dx:ASPxCallback>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                                <dx:LayoutItem FieldName="Text" Caption="Содержание">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">

                                            <dx:ASPxHtmlEditor runat="server" Width="100%" ID="HTML_TB" />

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                            </Items>
                        </dx:LayoutGroup>

                        <dx:LayoutGroup ShowCaption="False" ColumnSpan="1" RowSpan="2">
                            <Items>

                                <dx:LayoutItem FieldName="ID" ColSpan="1" Caption="№">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">

                                            <dx:ASPxSpinEdit runat="server" Number="0" ID="ID_TB" ClientReadOnly="true" Width="100%" Enabled="false" />

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                                <dx:LayoutItem FieldName="Created" ColSpan="1" Caption="Дата и время">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">

                                            <dx:ASPxDateEdit runat="server" ID="Created_DE" TimeSectionProperties-Visible="true" Width="100%" />

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                                <dx:LayoutItem FieldName="Status" ColSpan="1" Caption="Статус">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">

                                            <dx:ASPxComboBox ID="Status_CB" runat="server" DataSourceID="StatusDS" TextField="MetaName" ValueField="ID" Width="100%" />

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                                <dx:LayoutItem FieldName="Creator" ColSpan="1" Caption="Автор">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">

                                            <dx:ASPxComboBox ID="Creator_CB" runat="server" DataSourceID="UsersDS" TextField="FIO" ValueField="id" Width="100%" Enabled="false" />

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                                <dx:LayoutItem FieldName="ImageURL" Name="ImageURL" ColSpan="1" Caption="Главная картинка">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            
                                            <dx:ASPxCallbackPanel ID="ImageCallBack" ClientInstanceName="ImageCallBack" runat="server" EnableCallbackAnimation="true" OnCallback="ImageCallBack_Callback">
                                                <PanelCollection>
                                                    <dx:PanelContent runat="server">

                                                        <dx:ASPxBinaryImage ID="AvatarBI" runat="server" Width="200" Height="150" EnableServerResize="true" EmptyImage-Url="~/Content/UsersContent/DefaultAvatar.png" />

                                                    </dx:PanelContent>
                                                </PanelCollection>
                                            </dx:ASPxCallbackPanel>

                                            <dx:ASPxUploadControl ID="AvatarUpload" runat="server" ShowTextBox="false" BrowseButton-Text="Изменить..." AutoStartUpload="true"
                                                AdvancedModeSettings-EnableMultiSelect="false" OnFileUploadComplete="ImageUpload_FileUploadComplete">
                                                <BrowseButtonStyle BackColor="Transparent" Border-BorderStyle="None" HoverStyle-ForeColor="#000066" ForeColor="#17293F">
                                                    <PressedStyle ForeColor="#3366cc" />
                                                </BrowseButtonStyle>
                                                <ValidationSettings AllowedFileExtensions=".png,.jpg,.jpeg" />
                                                <ClientSideEvents FileUploadComplete="function(s,e){ ImageCallBack.PerformCallback(); }" />
                                            </dx:ASPxUploadControl>


                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                                <dx:LayoutItem FieldName="Slug" Caption="Slug">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">

                                            <dx:ASPxTextBox runat="server" Width="100%" ID="Slug_TB" ClientInstanceName="Slug_TB" />

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                                <dx:LayoutItem FieldName="Category" ColSpan="1" Caption="Тип" Visible="true">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">

                                            <dx:ASPxComboBox ID="Category_CB" runat="server" DataSourceID="CategoryDS" TextField="MetaName" ValueField="ID" Width="100%" Enabled="false" />

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                                <dx:LayoutItem FieldName="SubCategory" Name="SubCategory" ColSpan="1" Caption="Категория" Visible="false">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">

                                            <dx:ASPxComboBox ID="SubCategory_CB" runat="server" DataSourceID="SubCategoryDS" TextField="MetaName" ValueField="ID" Width="100%" />

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                                <dx:LayoutItem FieldName="Region" Name="Region" ColSpan="1" Caption="Район" Visible="false">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">

                                            <dx:ASPxComboBox ID="Region_CB" runat="server" DataSourceID="RegionDS" TextField="MetaName" ValueField="ID" Width="100%" />

                                            <asp:SqlDataSource ID="RegionDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>'
                                                SelectCommand=" SELECT ID, MetaName
                                                                    FROM [dbo].[PropertyMetaNames]
                                                                    where MetaCategory = @Category 
                                                                      and NoShow = 0
                                                                    order by OrderBy">
                                                <SelectParameters>
                                                    <asp:Parameter Name="Category" DefaultValue="Район" DbType="String" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                                <dx:LayoutItem ColSpan="1" ShowCaption="False" CssClass="mt-3">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">

                                            <dx:ASPxButton ID="SaveBtn" runat="server" Width="100%" Text="Сохранить" AutoPostBack="false">
                                                <ClientSideEvents Click="function (s,e) {MN_Panel.PerformCallback();}" />
                                            </dx:ASPxButton>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:LayoutGroup>

                        <dx:LayoutGroup ColumnSpan="2" ColumnCount="1" Caption="Галерея">
                            <Items>

                                <dx:LayoutItem ShowCaption="False" ColumnSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">

                                            <dx:ASPxButton ID="AddFoto" runat="server" Text="Управление фото" AutoPostBack="false" HorizontalAlign="Left" Width ="150" >
                                                <ClientSideEvents Click="function (s,e){FotoPopup.Show();}" />
                                            </dx:ASPxButton>

                                </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                                <dx:LayoutItem  ShowCaption="False" ColumnSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            
                                            <dx:ASPxImageGallery ID="PostGallegy" ClientInstanceName="PostGallegy" runat="server" Theme="MetropolisBlue"
                                                Layout="Breakpoints" ThumbnailHeight="100" ThumbnailWidth="100">

                                                <SettingsFullscreenViewer NavigationBarVisibility="Always" AnimationType="Fade" EnablePagingGestures="true"
                                                    AllowMouseWheel="true" EnablePagingByClick="true" />

                                                <StylesFullscreenViewerNavigationBar NavigationBar-Margins-MarginBottom="20" />

                                                <PagerSettings EndlessPagingMode="OnClick" ShowMoreItemsText="Загрузить больше..." />

                                                <SettingsBreakpointsLayout ItemsPerRow="6" ItemsPerPage="6">
                                                    <Breakpoints>
                                                        <dx:ImageGalleryBreakpoint DeviceSize="XSmall" ItemsPerRow="2" />
                                                    </Breakpoints>
                                                </SettingsBreakpointsLayout>

                                                <EmptyDataTemplate>
                                                    <dx:ASPxLabel ID="EmptyLabel" runat="server" Text="Нет фотографий :(" />
                                                </EmptyDataTemplate>

                                            </dx:ASPxImageGallery>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                 </Items>
                        </dx:LayoutGroup>

                        <dx:LayoutGroup Caption="Похожие публикации" ColumnSpan="2" ColumnCount="1" >
                            <Items>
                                <dx:LayoutItem ShowCaption="False" ColumnSpan="1">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">

                                            <dx:ASPxCardView ID="PostsLike" runat="server" DataSourceID="CardDS" AutoGenerateColumns="False" KeyFieldName="ID">

                                                <SettingsBehavior ConfirmDelete="true" AllowFocusedCard="true" />

                                                <SettingsDataSecurity AllowDelete="true" AllowEdit="true" AllowInsert="true" />

                                                <Columns>
                                                    <dx:CardViewTextColumn FieldName="ID" ReadOnly="True" Visible="False"/>
                                                    <dx:CardViewComboBoxColumn FieldName="PostID" PropertiesComboBox-DataSourceID="PostLikeDS"
                                                        PropertiesComboBox-ValueField="ID" PropertiesComboBox-TextField="Header" />
                                                    <dx:CardViewDateColumn FieldName="Created" VisibleIndex="0"/>
                                                    <dx:CardViewTextColumn FieldName="Creator" VisibleIndex="1"/>
                                                    <dx:CardViewTextColumn FieldName="Category" VisibleIndex="6"/>
                                                </Columns>                                                

                                                <Toolbars>
                                                    <dx:CardViewToolbar Name="New">
                                                        <Items>
                                                            <dx:CardViewToolbarItem Command="New" Text="Добавить" />
                                                            <dx:CardViewToolbarItem Command="Edit" Text="Изменить" />
                                                            <dx:CardViewToolbarItem Command="Delete" Text="Удалить" />
                                                            <dx:CardViewToolbarItem Command="Refresh" Text="Обновить" BeginGroup="true" />
                                                        </Items>
                                                    </dx:CardViewToolbar>
                                                </Toolbars>

                                                <EditFormLayoutProperties>
                                                    <Items>
                                                        <dx:CardViewColumnLayoutItem ColumnName="PostID" ColSpan="1" Caption="Выберите новость" CaptionSettings-Location="Top" Width="100%"/>
                                                        <dx:EditModeCommandLayoutItem ColSpan="1" HorizontalAlign="Right"/>
                                                    </Items>
                                                </EditFormLayoutProperties>

                                                <CardLayoutProperties>
                                                    <Items>
                                                        <dx:CardViewCommandLayoutItem ColSpan="1" HorizontalAlign="Right"/>
                                                        <dx:CardViewColumnLayoutItem ColumnName="Created" ColSpan="1" Caption="Дата"/>
                                                        <dx:CardViewColumnLayoutItem ColumnName="Creator" ColSpan="1" Caption="Автор"/>
                                                        <dx:CardViewColumnLayoutItem ColumnName="PostID" ColSpan="1" Caption="Заголовок"/>
                                                        <dx:CardViewColumnLayoutItem ColumnName="Category" ColSpan="1" Caption="Категория"/>
                                                        <dx:EditModeCommandLayoutItem ColSpan="1" HorizontalAlign="Right"/>
                                                    </Items>
                                                </CardLayoutProperties>

                                            </dx:ASPxCardView>

                                            <asp:SqlDataSource ID="CardDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>'
                                                SelectCommand="exec GetPostsLike @ID"
                                                InsertCommand=" insert into PostsMetaData (PostID, MetaNameID, MetaData) 
                                                                Values (@ID, 4, @PostID) "
                                                DeleteCommand="Delete from PostsMetaData 
                                                                Where ID = @ID">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="ID" QueryStringField="id" />
                                                </SelectParameters>

                                                <InsertParameters>
                                                    <asp:QueryStringParameter Name="ID" QueryStringField="id" />
                                                    <asp:Parameter Name="PostID" />
                                                </InsertParameters>

                                                <DeleteParameters>
                                                    <asp:Parameter Name="ID" />
                                                </DeleteParameters>
                                            </asp:SqlDataSource>

                                            <asp:SqlDataSource ID="PostLikeDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>'
                                                SelectCommand="SELECT p.ID, 
                                                                           p.Header
                                                                    FROM Posts p
                                                                         CROSS APPLY
                                                                    (
                                                                        SELECT MetaData
                                                                        FROM PostsMetaData pmd
                                                                        WHERE pmd.PostId = p.id
                                                                              AND pmd.MetaNameID = 17
                                                                              AND pmd.Created =
                                                                        (
                                                                            SELECT MAX(created)
                                                                            FROM PostsMetaData pmd1
                                                                            WHERE pmd1.PostId = p.ID
                                                                                  AND pmd1.MetaNameID = 17
                                                                        )
                                                                    ) st
                                                                    WHERE st.MetaData = 12;" />


                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:LayoutGroup>

                    </Items>

                </dx:ASPxFormLayout>

                <asp:SqlDataSource ID="PostDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>'
                    SelectCommand=" Exec dbo.GetPostInfoEdit @id">
                    <SelectParameters>
                        <asp:QueryStringParameter QueryStringField="id" Name="id" />

                    </SelectParameters>

                </asp:SqlDataSource>

                <asp:SqlDataSource ID="UsersDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>'
                    SelectCommand=" SELECT [id], 
                               CONCAT(LastName, ' ', LEFT([FirstName], 1), '.', iif(SecondName is null, '', CONCAT(LEFT([SecondName], 1), '.'))) FIO
                        FROM [dbo].[Users]
                        WHERE LastName IS NOT NULL
                        ORDER BY LastName">
                    <SelectParameters>
                        <asp:Parameter Name="Category" DefaultValue="Вид из окна" DbType="String" />
                    </SelectParameters>
                </asp:SqlDataSource>


                <asp:SqlDataSource ID="StatusDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>'
                    SelectCommand=" SELECT  [ID]
                          ,[MetaName]
                      FROM [dbo].[PostsMetaNames]
                      where NoShow = 0 
	                    and MetaCategory = @MetaCategory
                      order by OrderBy">
                    <SelectParameters>
                        <asp:Parameter Name="MetaCategory" DefaultValue="Статус" DbType="String" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:SqlDataSource ID="CategoryDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>'
                    SelectCommand=" SELECT  [ID]
                          ,[MetaName]
                      FROM [dbo].[PostsMetaNames]
                      where NoShow = 0 
	                    and MetaCategory = @MetaCategory
                      order by OrderBy">
                    <SelectParameters>
                        <asp:Parameter Name="MetaCategory" DefaultValue="Категория" DbType="String" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:SqlDataSource ID="SubCategoryDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>'
                    SelectCommand=" SELECT  [ID]
                          ,[MetaName]
                      FROM [dbo].[PostsMetaNames]
                      where NoShow = 0 
	                    and MetaCategory = @MetaCategory
                      order by OrderBy">
                    <SelectParameters>
                        <asp:Parameter Name="MetaCategory" DefaultValue="КатегорияНовости" DbType="String" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <dx:ASPxPopupControl ID="FotoPopup" ClientInstanceName="FotoPopup" runat="server" Modal="true"
                    PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" HeaderText="Загрузка фотографий к публикации" AllowDragging="true"
                    AutoUpdatePosition="true" HeaderStyle-HorizontalAlign="Center" ShowCloseButton="true" CloseAction="CloseButton">

                    <ClientSideEvents Closing="function(s,e){ FileManager.SetCurrentFolderPath('Foto');  }" />

                    <SettingsAdaptivity Mode="Always" VerticalAlign="WindowCenter" MaxWidth="900px" />

                    <ContentStyle Paddings-Padding="20px" />

                    <ContentCollection>
                        <dx:PopupControlContentControl runat="server">

                            <dx:ASPxFileManager ID="FileManager" ClientInstanceName="FileManager" runat="server" Width="100%" OnCustomCallback="FileManager_CustomCallback"
                                OnFilesUploaded="FileManager_FilesUploaded" OnItemsDeleted="FileManager_ItemsDeleted" OnFileUploading="FileManager_FileUploading">

                                <ClientSideEvents FileUploaded="function(s,e) { PostGallegy.PerformCallback(); }" ItemDeleted="function(s,e) { PostGallegy.PerformCallback(); }" />

                                <Settings ThumbnailFolder="~\Content\Thumb\PostsThumb" AllowedFileExtensions=".jpg,.jpeg,.png" EnableMultiSelect="true" />
                                <SettingsFolders Visible="false" />
                                <SettingsEditing AllowDelete="true" AllowRename="true" />
                                <SettingsAdaptivity Enabled="true" />
                                <SettingsToolbar ShowFilterBox="false" ShowPath="false">
                                    <Items>
                                        <dx:FileManagerToolbarRefreshButton />
                                        <dx:FileManagerToolbarDeleteButton />

                                        <dx:FileManagerToolbarUploadButton BeginGroup="true" Text="Загрузить" />

                                    </Items>
                                </SettingsToolbar>
                                <SettingsUpload AdvancedModeSettings-EnableMultiSelect="true" AutoStartUpload="true" UseAdvancedUploadMode="true" ShowUploadPanel="false" />
                                <SettingsContextMenu Enabled="true" />

                            </dx:ASPxFileManager>


                        </dx:PopupControlContentControl>
                    </ContentCollection>
                </dx:ASPxPopupControl>

            </dx:PanelContent>
        </PanelCollection>

    </dx:ASPxCallbackPanel>





</asp:Content>
