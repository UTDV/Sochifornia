<%@ Register Assembly="DevExpress.Web.v20.1, Version=20.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<style>
    .SortFontClass {
        font-weight: 600;
        text-decoration: underline;
    }

    #rcorners1 {
        border-radius: 100%;
        background: #17293F;
        padding: 0px;
        width: 8px;
        height: 8px;
        margin: 6px;
    }

    .ThumbSelectedStyle {
        border-radius: 100%;
    }
</style>



<body>
    <dx:ASPxHiddenField ID="HiddenField" ClientInstanceName="HiddenField" runat="server" />
    <dx:ASPxCardView ID="PropertyCardView" ClientInstanceName="PropertyCardView" runat="server" AutoGenerateColumns="false" DataSourceID="PropertyCardDS" KeyFieldName="ID"
        EnableCardsCache="false" Width="100%" Paddings-PaddingTop="3" >


        <SettingsBehavior AllowFocusedCard="true" />

        <SettingsDataSecurity AllowDelete="false" AllowEdit="false" AllowInsert="false" />
        
        <SettingsAdaptivity>
            <BreakpointsLayoutSettings CardsPerRow="1">
                
            </BreakpointsLayoutSettings>
        </SettingsAdaptivity>



        <Styles>
            <BreakpointsCard Height="100%" />
        </Styles>


        <Columns>
            <dx:CardViewColumn FieldName="slug" Visible="false" />
            <dx:CardViewImageColumn FieldName="ID">
                <DataItemTemplate>

                    <header style="height: 40px; background-color: black; margin-bottom: -40px; z-index: 2; position: relative; opacity: 0.6; color: white;">
                        <dx:ASPxLabel ID="TypeLabel" runat="server" Text='<%# Eval("Type") %>' ForeColor="White" Width="270" Style="padding-top: 1em; padding-left: 1em" />
                    </header>

                    <dx:ASPxImageSlider ID="PropertySlider" runat="server"
                        ImageSourceFolder='<%# If(System.IO.Directory.Exists(MapPath("~/Content/Foto/" & Eval("ID") & "/")) = True, If(System.IO.Directory.GetFiles(MapPath("~/Content/Foto/" & Eval("ID") & "/")).Count = 0, "~/Content/Foto/007/", "~/Content/Foto/" & Eval("ID") & "/"), "~/Content/Foto/007/") %>'
                        ShowNavigationBar="true"
                        Style="z-index: 1; position: relative" Width="270" Height="270">

                        <SettingsImageArea ImageSizeMode="FillAndCrop" />

                        <SettingsBehavior EnablePagingByClick="True" EnablePagingGestures="true" ImageLoadMode="DynamicLoad" />

                        <Styles>
                            <Thumbnail ImageWidth="20" ImageHeight="20" Border-BorderStyle="None" SelectedStyle-CssClass="ThumbSelectedStyle">
                                <SelectedStyle BackColor="#17293F" Border-BorderColor="White" />
                            </Thumbnail>
                        </Styles>

                        <ItemThumbnailTemplate>
                            <p id="rcorners1"></p>
                        </ItemThumbnailTemplate>


                    </dx:ASPxImageSlider>



                </DataItemTemplate>
            </dx:CardViewImageColumn>

            <dx:CardViewColumn Name="Name">
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

                    <a id="ContactsButton" style="border: solid; border-width: 1px; padding: 10px; border-color: #17293F; color: #17293F" href="javascript:OnLinkDeteailsClick(<%#Container.KeyValue.ToString()%>);">Контакты</a>

                </DataItemTemplate>
            </dx:CardViewTextColumn>

        </Columns>

        <CardLayoutProperties >
            <Items >

                <dx:CardViewColumnLayoutItem ColumnName="ID" ShowCaption="False" Paddings-PaddingBottom="5px" HorizontalAlign="Center" />

                <dx:CardViewColumnLayoutItem ColumnName="Name" ShowCaption="False" HorizontalAlign="Center"  />

                <dx:CardViewColumnLayoutItem ColumnName="District" Caption="Район"  CssClass="FontClassSize" />

                <dx:CardViewColumnLayoutItem ColumnName="Status" Caption="Статус"  CssClass="FontClassSize" />

                <dx:CardViewColumnLayoutItem ColumnName="Price" Caption="Цена" CssClass="FontClassSize" />
                

                <dx:CardViewColumnLayoutItem ColumnName="ApartmentArea" Caption="Площадь"  CssClass="FontClassSize" />

                <dx:CardViewColumnLayoutItem ColumnName="Floor" Caption="Этаж"  CssClass="FontClassSize" />

                <dx:CardViewColumnLayoutItem ColumnName="Rooms" Caption="Комнат"  CssClass="FontClassSize" />

                <dx:CardViewColumnLayoutItem ColumnName="Contacts" ShowCaption="False"  HorizontalAlign="Center" ParentContainerStyle-Paddings-PaddingTop="20" />

                <dx:CardViewColumnLayoutItem ColumnName="LinkCard" VerticalAlign="Bottom" HorizontalAlign="Right" CssClass="FontClassSize" />

            </Items>

        </CardLayoutProperties>

    </dx:ASPxCardView>
    <asp:SqlDataSource ID="PropertyCardDS" runat="server" ConnectionString='<%$ ConnectionStrings:propertyConnectionString %>'
        SelectCommand="exec dbo.GetAllProperty" />
    <dx:ASPxPopupControl ID="ContactsPopup" ClientInstanceName="ContactsPopup" runat="server" HeaderText="Контакты" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
        HeaderStyle-Paddings-PaddingLeft="30" OnWindowCallback="ContactsPopup_WindowCallback" AutoUpdatePosition="true">
        <ClientSideEvents Closing="function(s,e){ ContactsFormLayout.SetClientVisible(0); }" />
        <SettingsAdaptivity Mode="Always" VerticalAlign="WindowCenter" MaxWidth="400" />
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">

                <dx:ASPxHiddenField ID="ObjectHiddenField" runat="server" />

                <dx:ASPxFormLayout ID="ContactsFormLayout" ClientInstanceName="ContactsFormLayout" runat="server" Width="100%" ColumnCount="1" ClientVisible="false">
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

</body>

<script runat="server" language="vb">


    Protected Sub ContactsPopup_WindowCallback(source As Object, e As DevExpress.Web.PopupWindowCallbackArgs)
        Dim c As New System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("propertyConnectionString").ConnectionString)
        Dim cmd As New System.Data.SqlClient.SqlCommand("exec dbo.GetPropertyObjectData @ID", c)
        cmd.Parameters.AddWithValue("ID", e.Parameter)
        c.Open()
        Dim RDR As System.Data.SqlClient.SqlDataReader
        RDR = cmd.ExecuteReader
        RDR.Read()
        If RDR.HasRows Then

            CreatorNameHL.HeaderText = RDR("CreatorName").ToString
            CreatorPhone.HeaderText = Format(CDbl(RDR("CreatorPhone").ToString), "+# (###) ###-##-##")
            CreatorPhone.NavigateUrl = "tel:+" + RDR("CreatorPhone").ToString
            ObjectHiddenField("CreatorEmail") = RDR("CreatorEmail").ToString
            ObjectHiddenField("slug") = RDR("Slug").ToString

        End If
        RDR.Close()
        c.Close()
        cmd.Dispose()
        c.Dispose()

        ContactsFormLayout.ClientVisible = True

    End Sub

    Protected Sub CBackSendMail_Callback(source As Object, e As DevExpress.Web.CallbackEventArgs)

        Try

            Dim emailto As String = ObjectHiddenField("CreatorEmail")
            'Dim path As String = MapPath("~/object/" & ObjectHiddenField("slug"))

            Dim path2 As String = "https://Sochifornia.realty/object/" & ObjectHiddenField("slug")

            'Dim path3 As String = "../object/" & ObjectHiddenField("slug")

            Dim bld As New MimeKit.BodyBuilder()
            Dim message = New MimeKit.MimeMessage()
            message.From.Add(New MimeKit.MailboxAddress("Система уведомлений Sochifornia", "info@sochifornia.realty"))
            message.To.Add(New MimeKit.MailboxAddress(emailto, emailto))

            message.Subject = "Сообщение с сайта от клиента"

            bld.HtmlBody = "<br/>Поступило сообщение от клиента " & NameSendMail.Text & ", телефон: " & IIf(IsNothing(PhoneSendMail.Value) = True, "не указан", PhoneSendMail.Text) &
                ", почта: " & IIf(IsNothing(EmailSendMail.Value) = True, "не указана", EmailSendMail.Text) & "<br/><br/>" & "Текст сообщения: " & IIf(IsNothing(NoteSendMail.Value) = True, NoteSendMail.NullText, NoteSendMail.Text) &
                "<br/><br/>" & "<a href=" & path2 + "> ССЫЛКА НА ОБЪЕКТ </a>"

            message.Body = bld.ToMessageBody()

            Dim client = New MailKit.Net.Smtp.SmtpClient()
            client.Connect("smtp.mail.ru", 465, True)
            client.Authenticate("info@sochifornia.realty", "Ii123456")
            client.Send(message)
            client.Disconnect(True)

            e.Result = 1

        Catch ex As Exception
            e.Result = 0
        End Try

    End Sub

</script>

<script type="text/javascript">
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
