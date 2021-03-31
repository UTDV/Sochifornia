<%@ Page Title="Недвижимость Сочи" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="Default.aspx.vb" Inherits="WebEstateProject._Default"  %> 

<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>



<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .SortFontClass {
           font-weight:600;
           text-decoration:underline;
           
        }

        #rcorners1 {
  border-radius: 100%;
  background: #17293F;
  padding: 0px; 
  width: 8px;
  height: 8px;
  margin:6px;
}

        .ThumbSelectedStyle {
            border-radius: 100%;
        }
    </style>

    <dx:ASPxHiddenField ID="HiddenField" ClientInstanceName="HiddenField" runat="server" />

    <dx:ASPxFormLayout ID="FormLayout" runat="server" Width="100%" ColumnCount="3">
        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="1400" />
        <Items>

            <dx:EmptyLayoutItem ColumnSpan="1" Width="10%" />


            <dx:LayoutItem ShowCaption="False" Width="80%">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        

                        <dx:ASPxRoundPanel ID="FilterRoundPanel" ClientInstanceName="FilterRoundPanel" runat="server" Width="100%" Collapsed="true" CssClass="border-0" >

                            <HeaderTemplate>

                                <dx:ASPxComboBox ID="SortCB" runat="server" Caption="Сортировка" Border-BorderStyle="none" ShowImageInEditBox="true" Cursor="pointer"
                                    ForeColor="#17293F" CssClass="SortFontClass" >
                                    <DropDownButton Visible="false" />
                                    <Items>
                                        <dx:ListEditItem Value="ByDate" Text="Сначала новые" Selected="true" />
                                        <dx:ListEditItem Value="ByPriceAsc" Text="По возрастанию цены" />
                                        <dx:ListEditItem Value="ByPriceDesc" Text="По убыванию цены" />
                                    </Items>
                                    <ClientSideEvents ValueChanged="function(s,e) { PropertyCardView.PerformCallback('sort|' + s.GetValue()); }" />
                                </dx:ASPxComboBox>



                                <dx:ASPxButton ID="ShowFilterButton" ClientInstanceName="ShowFilterButton" runat="server" AutoPostBack="false" Text="Фильтры" RenderMode="link"
                                    Image-Url="~/Content/Icons/down.png" ImagePosition="Right" Style="margin-top:20px; margin-bottom:10px" >
                                    <ClientSideEvents Click=" function(s,e){ ShowFilterButtonClick();  } " />
                                </dx:ASPxButton>

                            </HeaderTemplate>

                           
                            <HeaderStyle BackColor="Transparent" Border-BorderStyle="None" />                            

                            <PanelCollection>
                                <dx:PanelContent runat="server">                                    

                                    <dx:ASPxFormLayout ID="FilterFormLayout" runat="server" ColumnCount="3" Width="100%">

                                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="1000" />

                                        <Items>

                                            <dx:LayoutGroup ShowCaption="False" GroupBoxDecoration="None" ColumnSpan="1"  Width="30%" >
                                                <Items>

                                                    <dx:LayoutItem Caption="Категория">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">

                                                                <dx:ASPxComboBox ID="TypeFilterCB" ClientInstanceName="TypeFilterCB" runat="server" DataSourceID="TypeDS" ValueField="ID" TextField="MetaName" Width="250" />

                                                                <asp:SqlDataSource ID="TypeDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>'
                                                                    SelectCommand=" SELECT ID, MetaName
                                                                            FROM [dbo].[PropertyMetaNames]
                                                                            where MetaCategory = @Category
                                                                              and NoShow = 0
                                                                            order by OrderBy">
                                                                    <SelectParameters>
                                                                        <asp:Parameter Name="Category" DefaultValue="Категория недвижимости" DbType="String" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>

                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>

                                                    <dx:LayoutItem Caption="Район">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">

                                                                <dx:ASPxComboBox ID="DistrictFilterCB" ClientInstanceName="DistrictFilterCB" runat="server" DataSourceID="DistrictDS" ValueField="ID" TextField="MetaName" Width="250" EnableCallbackMode="true" />

                                                                <asp:SqlDataSource ID="DistrictDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>'
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

                                                    <dx:LayoutItem Caption="Состояние">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">

                                                                <dx:ASPxComboBox ID="ConditionFilterCB" ClientInstanceName="ConditionFilterCB" runat="server" DataSourceID="ConditionDS" ValueField="ID" TextField="MetaName" Width="250" />

                                                                <asp:SqlDataSource ID="ConditionDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>'
                                                                    SelectCommand=" SELECT ID, MetaName
                                                                            FROM [dbo].[PropertyMetaNames]
                                                                            where MetaCategory = @Category
                                                                              and NoShow = 0
                                                                            order by OrderBy">
                                                                    <SelectParameters>
                                                                        <asp:Parameter Name="Category" DefaultValue="Состояние" DbType="String" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>

                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>

                                                    <dx:LayoutItem Caption="Статус">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">

                                                                <dx:ASPxComboBox ID="StatusFilterCB" ClientInstanceName="StatusFilterCB" runat="server" DataSourceID="StatusDS" ValueField="ID" TextField="MetaName" Width="250" />

                                                                <asp:SqlDataSource ID="StatusDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>'
                                                                    SelectCommand=" SELECT ID, MetaName
                                                                            FROM [dbo].[PropertyMetaNames]
                                                                            where MetaCategory = @Category
                                                                              and NoShow = 0
                                                                            order by OrderBy">
                                                                    <SelectParameters>
                                                                        <asp:Parameter Name="Category" DefaultValue="Статус" DbType="String" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>

                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>

                                                </Items>
                                            </dx:LayoutGroup>


                                            <dx:LayoutGroup ShowCaption="False" GroupBoxDecoration="None" ColumnSpan="1"  Width="30%" >
                                                <Items>

                                                    <dx:LayoutItem Caption="Цена" HorizontalAlign="Left">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">

                                                                <div class="row">

                                                                    <dx:ASPxSpinEdit ID="PriceFromSpin" ClientInstanceName="PriceFromSpin" runat="server" NumberType="Integer" NullText="От"
                                                                        DisplayFormatString="C0" Style="margin-left: 15px" SpinButtons-ShowIncrementButtons="false" SelectInputTextOnClick="true" Width="100" />

                                                                    <dx:ASPxSpinEdit ID="PriceToSpin" ClientInstanceName="PriceToSpin" runat="server" NumberType="Integer" NullText="До"
                                                                        DisplayFormatString="C0" Style="margin-left: 10px" SpinButtons-ShowIncrementButtons="false" SelectInputTextOnClick="true" Width="100" />

                                                                </div>

                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>
                                                    
                                                    <dx:LayoutItem Caption="Площадь" HorizontalAlign="Left">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">

                                                                <div class="row">

                                                                    <dx:ASPxSpinEdit ID="SQFromSpin" ClientInstanceName="SQFromSpin" runat="server" NumberType="Integer" NullText="От"
                                                                        DisplayFormatString="{0}" Style="margin-left: 15px" SpinButtons-ShowIncrementButtons="false" SelectInputTextOnClick="true" Width="100" />

                                                                    <dx:ASPxSpinEdit ID="SQToSpin" ClientInstanceName="SQToSpin" runat="server" NumberType="Integer" NullText="До"
                                                                        DisplayFormatString="{0}" Style="margin-left: 10px" SpinButtons-ShowIncrementButtons="false" SelectInputTextOnClick="true" Width="100" />

                                                                </div>

                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>

                                                    <dx:LayoutItem Caption="Кол-во комнат" HorizontalAlign="Left">
                                                        <LayoutItemNestedControlCollection>
                                                            <dx:LayoutItemNestedControlContainer runat="server">

                                                                <dx:ASPxComboBox ID="RoomsCB" ClientInstanceName="RoomsCB" runat="server" Width="210">
                                                                    <Items>
                                                                        <dx:ListEditItem Text="" />
                                                                        <dx:ListEditItem Text="Студия" Value="=0" />
                                                                        <dx:ListEditItem Text="1" Value="=1" />
                                                                        <dx:ListEditItem Text="2" Value="=2" />
                                                                        <dx:ListEditItem Text="3" Value="=3" />
                                                                        <dx:ListEditItem Text="4+" Value=">=4" />
                                                                    </Items>
                                                                </dx:ASPxComboBox>

                                                            </dx:LayoutItemNestedControlContainer>
                                                        </LayoutItemNestedControlCollection>
                                                    </dx:LayoutItem>

                                                </Items>
                                            </dx:LayoutGroup>


                                            <dx:LayoutItem ShowCaption="False" ColumnSpan="3" HorizontalAlign="Left" ParentContainerStyle-Paddings-PaddingTop="20" >
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server">

                                                        <dx:ASPxButton ID="ApplyFilterButton" runat="server" AutoPostBack="false" Text="Применить" Width="120" >
                                                            <ClientSideEvents Click="function(s,e) { ApplyFilter();  }" />
                                                        </dx:ASPxButton>

                                                        <dx:ASPxButton ID="ClearFilterButton" runat="server" AutoPostBack="false" Text="Очистить" RenderMode="Secondary" ForeColor="#17293F" Width="120">
                                                            <ClientSideEvents Click="function(s,e) { ClearFilter();  }" />
                                                        </dx:ASPxButton>

                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>

                                            

                                        </Items>
                                    </dx:ASPxFormLayout>                                    

                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxRoundPanel>



                        <dx:ASPxCardView ID="PropertyCardView" ClientInstanceName="PropertyCardView" runat="server" AutoGenerateColumns="false" DataSourceID="PropertyCardDS" KeyFieldName="ID"
                            EnableCardsCache="false" Width="100%" OnCustomCallback="PropertyCardView_CustomCallback" Paddings-PaddingTop="10"  >

                            <Settings LayoutMode="Breakpoints" />
                             
                            <SettingsBehavior AllowSelectByCardClick="true" AllowSelectSingleCardOnly="true" AllowFocusedCard="true"   />

                            <SettingsDataSecurity AllowDelete="false" AllowEdit="false" AllowInsert="false" />

                            <SettingsPager Mode="EndlessPaging" EnableAdaptivity="true" EndlessPagingMode="OnScroll">
                                <SettingsBreakpointsLayout ItemsPerPage="6" />
                            </SettingsPager>
                          
                            <SettingsAdaptivity>
                                <BreakpointsLayoutSettings CardsPerRow="3">
                                    <Breakpoints>
                                        <dx:CardViewBreakpoint DeviceSize="XLarge" CardsPerRow="3" />
                                        <dx:CardViewBreakpoint DeviceSize="Large" CardsPerRow="2" />
                                        <dx:CardViewBreakpoint DeviceSize="Medium" CardsPerRow="2" />
                                        <dx:CardViewBreakpoint DeviceSize="Small" CardsPerRow="1" />
                                        <dx:CardViewBreakpoint DeviceSize="XSmall" CardsPerRow="1" />
                                    </Breakpoints>
                                </BreakpointsLayoutSettings>
                            </SettingsAdaptivity>

                            <SettingsCommandButton EndlessPagingShowMoreCardsButton-Text="Показать еще..."  />

                            <Styles >
                                <BreakpointsCard Height="100%" />
                            </Styles>


                            <Columns>
                                <dx:CardViewColumn FieldName="slug" Visible="false" />
                                <dx:CardViewImageColumn FieldName="ID">
                                    <DataItemTemplate>

                                        <header style="height: 40px; background-color: black; margin-bottom: -40px; z-index: 2; position: relative; opacity: 0.6; color: white;">
                                            <dx:ASPxLabel ID="TypeLabel" runat="server" Text='<%# Eval("Type") %>' ForeColor="White" Width="270"  Style="padding-top: 1em; padding-left: 1em" />
                                        </header>

                                        <dx:ASPxImageSlider ID="PropertySlider" runat="server" 
                                            
                                            ImageSourceFolder='<%# If(System.IO.Directory.Exists(MapPath("~/Content/Foto/" & Eval("ID") & "/")) = True, If(System.IO.Directory.GetFiles(MapPath("~/Content/Foto/" & Eval("ID") & "/")).Count = 0, "~/Content/Foto/007/", "~/Content/Foto/" & Eval("ID") & "/"), "~/Content/Foto/007/") %>' 
                                            
                                            
                                            ShowNavigationBar="true"
                                            Style="z-index: 1; position: relative" Width="270" Height="270" >

                                            <SettingsImageArea ImageSizeMode="FillAndCrop" />

                                            <SettingsBehavior EnablePagingByClick="True" EnablePagingGestures="true" ImageLoadMode="DynamicLoad" />

                                            <Styles>
                                                <Thumbnail ImageWidth="20" ImageHeight="20" Border-BorderStyle="None"  SelectedStyle-CssClass="ThumbSelectedStyle" >
                                                    <SelectedStyle BackColor="#17293F" Border-BorderColor="White"  />
                                                </Thumbnail>
                                            </Styles>

                                            <ItemThumbnailTemplate>
                                                <p id="rcorners1" ></p>
                                            </ItemThumbnailTemplate>
                                            

                                        </dx:ASPxImageSlider>

<%--                                        <footer>
                                            <dx:ASPxLabel ID="LastUpdateLabel" runat="server" Text='<%# Eval("LastUpdate") %>' CssClass="ImageWidthClass" Font-Size="Smaller" />
                                        </footer>--%>

                                    </DataItemTemplate>
                                </dx:CardViewImageColumn>

                                <dx:CardViewColumn Name="Name" >
                                    <DataItemTemplate>
                                        <dx:ASPxHeadline ID="NameHeadLine" runat="server" HeaderText='<%# Eval("Name") %>' HorizontalAlign="Center" CssClass="NameFontClassSize" />
                                    </DataItemTemplate>
                                </dx:CardViewColumn>

                                <dx:CardViewColumn FieldName="Type" />

                                <dx:CardViewColumn FieldName="District" />

                                <dx:CardViewColumn FieldName="Status" />
                                
                                <dx:CardViewTextColumn FieldName="Price" PropertiesTextEdit-DisplayFormatString="C0" />

                                <dx:CardViewColumn FieldName="PriceForMetr" />

                                <dx:CardViewColumn FieldName="ApartmentArea" />
                                
                                <dx:CardViewColumn FieldName="Floor" />

                                <dx:CardViewColumn FieldName="Rooms" />

                                <dx:CardViewDateColumn FieldName="LastUpdate" PropertiesDateEdit-DisplayFormatString="dd.MM.yyyy" />

                                <dx:CardViewColumn Name="LinkCard">
                                    <DataItemTemplate>
                                        <dx:ASPxHyperLink ID="HL" runat="server" Text="Подробнее..." Target="_blank" NavigateUrl='<%# "object/" & Eval("slug") %>' />
                                    </DataItemTemplate>
                                </dx:CardViewColumn>


                                <dx:CardViewColumn FieldName="Condition" />
                                <dx:CardViewColumn FieldName="Stove" />
                                <dx:CardViewColumn FieldName="Ipoteka" />
                                <dx:CardViewColumn FieldName="Rooms" />
                                <dx:CardViewColumn FieldName="ASquare" />
                                <dx:CardViewColumn FieldName="ARooms" />
                                <dx:CardViewColumn FieldName="ARooms" />

                                <dx:CardViewColumn FieldName="CreatorPhone" />
                                <dx:CardViewColumn FieldName="CreatorEmail" />
                                <dx:CardViewColumn FieldName="CreatorName" />
                                <dx:CardViewColumn FieldName="CreatorWhatsApp" />

                                <dx:CardViewTextColumn Name="Contacts">
                                    <DataItemTemplate>

                                        <a id="ContactsButton" style="border:solid; border-width:1px; padding:10px; border-color:#17293F; color:#17293F" href="javascript:OnLinkDeteailsClick(<%#Container.KeyValue.ToString()%>);">Контакты</a>

                                    </DataItemTemplate>
                                </dx:CardViewTextColumn>

                            </Columns>




                            <CardLayoutProperties ColumnCount="2" >
                                <Items>

                                    <dx:CardViewColumnLayoutItem ColumnName="ID" ShowCaption="False" Paddings-PaddingBottom="5px"  ColumnSpan="2" HorizontalAlign="Center"  />

                                    <dx:CardViewColumnLayoutItem ColumnName="Name" ShowCaption="False" HorizontalAlign="Center" ColumnSpan="2" />

                                    <dx:CardViewColumnLayoutItem ColumnName="District" Caption="Район" ColumnSpan="2" CssClass="FontClassSize" />

                                    <dx:CardViewColumnLayoutItem ColumnName="Status" Caption="Статус" ColumnSpan="2" CssClass="FontClassSize" />

                                    <dx:CardViewColumnLayoutItem ColumnName="Price" Caption="Цена" CssClass="FontClassSize" />
                                    <dx:CardViewColumnLayoutItem ColumnName="PriceForMetr" ShowCaption="False" VerticalAlign="Bottom" ParentContainerStyle-ForeColor="Gray" HorizontalAlign="Right" CssClass="FontClassSize"  />

                                    <dx:CardViewColumnLayoutItem ColumnName="ApartmentArea" Caption="Площадь" ColumnSpan="2" CssClass="FontClassSize" />

                                    <dx:CardViewColumnLayoutItem ColumnName="Floor" Caption="Этаж" ColumnSpan="2" CssClass="FontClassSize" />

                                    <dx:CardViewColumnLayoutItem ColumnName="Rooms" Caption="Комнат" ColumnSpan="2" CssClass="FontClassSize" />

                                    <dx:CardViewColumnLayoutItem ColumnName="Contacts" ShowCaption="False" ColumnSpan="2" HorizontalAlign="Center" ParentContainerStyle-Paddings-PaddingTop="20"  />

                                   <%-- <dx:CardViewColumnLayoutItem ColumnSpan="2" ShowCaption="False" ParentContainerStyle-Paddings-PaddingTop="10" ParentContainerStyle-Paddings-PaddingBottom="10" >
                                        <Template>
                                            
                                            <dx:ASPxRoundPanel ID="CreatorContacts" ClientInstanceName="CreatorContacts" runat="server" ShowCollapseButton="false" Collapsed="true" 
                                                Width="100%" HeaderText="Контакты" AllowCollapsingByHeaderClick="true">
                                               
                                                <HeaderStyle BackColor="Transparent" HorizontalAlign="Center" />
                                                <PanelCollection>
                                                    <dx:PanelContent runat="server">

                                                        <dx:ASPxHeadline ID="CreatorPhoneHeadline" runat="server" HeaderStyle-Wrap="False" ShowHeaderAsLink="true" NavigateUrl='<%# "tel:+" & Eval("CreatorPhone") %>'
                                                            Image-Url="~/Content/Icons/SmallPhone.png" ShowImageAsLink="true" HeaderText='<%# Format(CDbl(Eval("CreatorPhone")), "+# (###) ###-##-##") %>' 
                                                            HeaderStyle-Paddings-PaddingTop="2"  />
                                                        

                                                        <dx:ASPxHeadline ID="CreatorWhatsAppHeadline" runat="server" HeaderStyle-Wrap="False" ShowHeaderAsLink="true" NavigateUrl='<%# "https://wa.me/7" & Eval("CreatorWhatsApp") %>'
                                                            Image-Url="~/Content/Icons/whatsapp.png" ShowImageAsLink="true" HeaderText='<%# Format(CDbl(Eval("CreatorWhatsApp")), "+7# (###) ###-##-##") %>' 
                                                            HeaderStyle-Paddings-PaddingTop="2" Target="_blank"  />



                                                    </dx:PanelContent>
                                                </PanelCollection>
                                            </dx:ASPxRoundPanel>

                                           

                                        </Template>
                                    </dx:CardViewColumnLayoutItem>--%>



                                    <dx:CardViewColumnLayoutItem ColumnName="LinkCard" VerticalAlign="Bottom" HorizontalAlign="Right" ColumnSpan="2" CssClass="FontClassSize"   />

                                </Items>
                            </CardLayoutProperties>



                            
                            

                        </dx:ASPxCardView>

                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>

            <dx:EmptyLayoutItem ColumnSpan="1" Width="10%" />

        </Items>
    </dx:ASPxFormLayout>



 

    <asp:SqlDataSource ID="PropertyCardDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>' 
        SelectCommand="exec dbo.GetAllProperty" />



    <dx:ASPxPopupControl ID="ContactsPopup" ClientInstanceName="ContactsPopup" runat="server" HeaderText="Контакты" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
        HeaderStyle-Paddings-PaddingLeft="30" OnWindowCallback="ContactsPopup_WindowCallback" AutoUpdatePosition="true" >
        <ClientSideEvents Closing="function(s,e){ ContactsFormLayout.SetClientVisible(0); }" />
        <SettingsAdaptivity Mode="Always" VerticalAlign="WindowCenter" MaxWidth="400" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">

                <dx:ASPxHiddenField ID="ObjectHiddenField" runat="server" />

                <dx:ASPxFormLayout ID="ContactsFormLayout" ClientInstanceName="ContactsFormLayout" runat="server" Width="100%" ColumnCount="1" ClientVisible="false" >
                    <Items>

                        <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center" Name="CreatorName">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">

                                    <dx:ASPxHeadline ID="CreatorNameHL" runat="server" HeaderStyle-Wrap="False" HeaderStyle-CssClass="PhoneClassComfortaa" />

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                        <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center" Name="Phone">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">

                                    <dx:ASPxHeadline ID="CreatorPhone" runat="server" HeaderStyle-Wrap="False" HeaderStyle-CssClass="PhoneClassComfortaa" ShowHeaderAsLink="true"
                                        HeaderStyle-Paddings-PaddingTop="7" Image-Url="~/Content/Icons/telephone.png" ShowImageAsLink="true" />

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                        <dx:LayoutItem Name="Mail" ShowCaption="False" ParentContainerStyle-Paddings-PaddingTop="10" ParentContainerStyle-Paddings-PaddingBottom="10" HorizontalAlign="Center">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">

                                    <dx:ASPxButton ID="SendMailButton" ClientInstanceName="SendMailButton" runat="server" Text="Написать" AutoPostBack="false" Width="200"
                                        Image-Url="~/Content/Icons/envelope.png" ImageSpacing="10">
                                        <ClientSideEvents Click="function(s,e){ ContactsFormLayout.GetItemByName('CreatorName').SetVisible(0); ContactsFormLayout.GetItemByName('Phone').SetVisible(0); ContactsFormLayout.GetItemByName('Mail').SetVisible(0); ContactsFormLayout.GetItemByName('SendMail').SetVisible(1); ContactsPopup.UpdatePosition(); }" />
                                    </dx:ASPxButton>

                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>

                        <dx:LayoutGroup GroupBoxDecoration="None" CellStyle-Paddings-Padding="10" ClientVisible="false" Name="SendMail">
                            <Items>

                                <dx:LayoutItem ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="NameSendMail" ClientInstanceName="NameSendMail" runat="server" Width="100%" NullText="Ваше имя" />
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                                <dx:LayoutItem ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="PhoneSendMail" ClientInstanceName="PhoneSendMail" runat="server" Width="100%" NullText="Телефон" DisplayFormatString="+# (###) ###-##-##">
                                                <ClientSideEvents GotFocus="function(s,e){ if(PhoneSendMail.GetText()==''){ PhoneSendMail.SetText('+7'); } }"
                                                    LostFocus="function(s,e){ if(PhoneSendMail.GetText()=='+7'){ PhoneSendMail.SetText(''); } }" />
                                            </dx:ASPxTextBox>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                                <dx:LayoutItem ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxTextBox ID="EmailSendMail" ClientInstanceName="EmailSendMail" runat="server" Width="100%" NullText="E-mail" />
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                                <dx:LayoutItem ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxMemo ID="NoteSendMail" ClientInstanceName="NoteSendMail" runat="server" Width="100%" NullText="Меня заинтересовал этот объект. Пожалуйста, расскажите о нем подробнее." Rows="5" />
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                                <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">

                                            <dx:ASPxButton ID="SendButton" runat="server" Width="200" AutoPostBack="false" Text="Отправить">
                                                <ClientSideEvents Click="function(s,e){ SendButtonClick(); }" />
                                            </dx:ASPxButton>

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                                <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center" ClientVisible="false" Name="ErrorLabelItem">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">


                                            <dx:ASPxLabel ID="ErrorLabel" ClientInstanceName="ErrorLabel" runat="server" Text="" ForeColor="Red" Font-Size="Smaller" />

                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                            </Items>
                        </dx:LayoutGroup>

                    </Items>
                </dx:ASPxFormLayout>

            </dx:PopupControlContentControl>
        </ContentCollection>
    </dx:ASPxPopupControl>

    <dx:ASPxCallback ID="CBackSendMail" ClientInstanceName="CBackSendMail" runat="server" OnCallback="CBackSendMail_Callback">
        <ClientSideEvents CallbackComplete="function(s,e){ CBackSendMailResult(e.result); }" />
    </dx:ASPxCallback>

    <dx:ASPxLoadingPanel ID="LoadingPanel" ClientInstanceName="LoadingPanel" runat="server" Modal="true" />

     <script type="text/javascript">

         function ApplyFilter() {

             var str = '';
             // Категория
             if (TypeFilterCB.GetValue() != null) {
                 str = "Type ='" + TypeFilterCB.GetText() + "'";
             }
             // Район
             if (DistrictFilterCB.GetValue() != null) {
                 if (str == '') {
                     str = "District ='" + DistrictFilterCB.GetText() + "'";
                 }
                 else {
                     str = str + " and District ='" + DistrictFilterCB.GetText() + "'";
                 }
             }
             // Состояние
             if (ConditionFilterCB.GetValue() != null) {
                 if (str == '') {
                     str = "Condition ='" + ConditionFilterCB.GetText() + "'";
                 }
                 else {
                     str = str + " and Condition ='" + ConditionFilterCB.GetText() + "'";
                 }
             }
             // Статус
             if (StatusFilterCB.GetValue() != null) {
                 if (str == '') {
                     str = "Status ='" + StatusFilterCB.GetText() + "'";
                 }
                 else {
                     str = str + " and Status ='" + StatusFilterCB.GetText() + "'";
                 }
             }
             // Цена
             if (PriceFromSpin.GetValue() != null) {
                 if (str == '') {
                     str = "Price >=" + PriceFromSpin.GetValue();
                 }
                 else {
                     str = str + " and Price >=" + PriceFromSpin.GetValue();
                 }
             }

             if (PriceToSpin.GetValue() != null) {
                 if (str == '') {
                     str = "Price <=" + PriceToSpin.GetValue();
                 }
                 else {
                     str = str + " and Price <=" + PriceToSpin.GetValue();
                 }
             }
             // Площадь
             if (SQFromSpin.GetValue() != null) {
                 if (str == '') {
                     str = "ASquare >=" + SQFromSpin.GetValue();
                 }
                 else {
                     str = str + " and ASquare >=" + SQFromSpin.GetValue();
                 }
             }

             if (SQToSpin.GetValue() != null) {
                 if (str == '') {
                     str = "ASquare <=" + SQToSpin.GetValue();
                 }
                 else {
                     str = str + " and ASquare <=" + SQToSpin.GetValue();
                 }
             }
             //Комнаты
             if (RoomsCB.GetValue() != null) {
                 if (str == '') {
                     str = "ARooms" + RoomsCB.GetValue();
                 }
                 else {
                     str = str + " and ARooms" + RoomsCB.GetValue();
                 }
             }

             PropertyCardView.PerformCallback('filter|' + str);

             ShowFilterButtonClick();
         }

         function ClearFilter() {
             TypeFilterCB.SetValue(null);
             DistrictFilterCB.SetValue(null);
             ConditionFilterCB.SetValue(null);
             StatusFilterCB.SetValue(null);
             PriceFromSpin.SetValue(null);
             PriceToSpin.SetValue(null);
             SQFromSpin.SetValue(null);
             SQToSpin.SetValue(null);
             RoomsCB.SetValue(null);
             PropertyCardView.PerformCallback('filter|');
             ShowFilterButtonClick();
         }

         function ShowFilterButtonClick() {

             if (FilterRoundPanel.GetCollapsed()) {
                 ShowFilterButton.SetImageUrl("Content/Icons/up.png");
             }
             else {
                 ShowFilterButton.SetImageUrl("Content/Icons/down.png");
             }
             

             FilterRoundPanel.SetCollapsed(!FilterRoundPanel.GetCollapsed());
         }

         //Контакты
         function OnLinkDeteailsClick(vl) {
             HiddenField.Set("ID", vl);
             ContactsPopup.PerformCallback(HiddenField.Get("ID"));
             ContactsPopup.Show();
         }


         //Отправка письма
         function SendButtonClick() {

             ErrorLabel.SetText('');
             ContactsFormLayout.GetItemByName('ErrorLabelItem').SetVisible(0);

             if (NameSendMail.GetText() == '') {
                 ErrorLabel.SetText('Пожалуйста, укажите Ваше имя');
                 ContactsFormLayout.GetItemByName('ErrorLabelItem').SetVisible(1);
             }
             else if (PhoneSendMail.GetText() == '' && EmailSendMail.GetText() == '') {
                 ErrorLabel.SetText('Пожалуйста, укажите телефон или e-mail');
                 ContactsFormLayout.GetItemByName('ErrorLabelItem').SetVisible(1);
             }
             else if (PhoneSendMail.GetText() != '' && /^\d{10}$/.test(PhoneSendMail.GetText().substring(2)) == false) {
                 ErrorLabel.SetText('Некорректный номер телефона');
                 ContactsFormLayout.GetItemByName('ErrorLabelItem').SetVisible(1);
             }
             else if (EmailSendMail.GetText() != '' && /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/.test(EmailSendMail.GetText()) == false) {
                 ErrorLabel.SetText('Некорректный e-mail');
                 ContactsFormLayout.GetItemByName('ErrorLabelItem').SetVisible(1);
             }
             else {
                 LoadingPanel.Show();
                 CBackSendMail.PerformCallback();
             }

         }

         function CBackSendMailResult(vl) {
             LoadingPanel.Hide();
             if (vl == 1) {
                 ContactsPopup.Hide();
             }
             else if (vl == 0) {
                 ErrorLabel.SetText('Что-то пошло не так. Попробуйте еще раз.');
                 ContactsFormLayout.GetItemByName('ErrorLabelItem').SetVisible(1);
             }
         }

     </script>

</asp:Content>
