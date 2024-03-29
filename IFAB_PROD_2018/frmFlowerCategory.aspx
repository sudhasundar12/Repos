﻿<%@ Page Title=" FLOWER CATEGORY MASTER" Language="VB" MasterPageFile="~/Home.master" AutoEventWireup="false"
    CodeFile="frmFlowerCategory.aspx.vb" Inherits="frmFlowerCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function Validate() {
            var msg = Valid();

            if (msg != true) {
                if (navigator.appName == "Microsoft Internet Explorer") {
                    document.getElementById("<%=lblerrmsg.ClientID%>").innerText = msg;
                    document.getElementById("<%=lblmsgifo.ClientID%>").innerText = "";
                    return false;
                }
                else if (navigator.appName == "Netscape") {
                    document.getElementById("<%=lblerrmsg.ClientID%>").textContent = msg;
                    document.getElementById("<%=lblmsgifo.ClientID%>").textContent = "";
                    return false;
                }
            return true;
        }
    }

    //Function for Multilingual Validations
    //Created by siddharth

    function Valid() {

        var msg, a;


        msg = NameField100Mul(document.getElementById("<%=txtfcategory.ClientID %>"));
            if (msg != "") {
                document.getElementById("<%=txtfcategory.ClientID %>").focus();
                a = document.getElementById("<%=lblfcategory.ClientID %>").innerHTML;
                msg = Spliter(a) + " " + ErrorMessage(msg);
                return msg;
            }


            return true;
        }

        function ErrorMessage(msg) {
            var SesVar = '<%= Session("Validation") %>';
            var ValidationArray = new Array();
            ValidationArray = SesVar.split(":");
            for (var i = 0; i < ValidationArray.length - 1; i++) {
                if (ValidationArray[i] == msg) {
                    return ValidationArray[i + 1];
                }
            }
        }


        function Spliter(a) {
            var str = a;
            var n = str.indexOf("*");
            if (n != 0 && n != -1) {
                a = a.split("*");
                return a[0];
            }
            var n = str.indexOf("^");
            if (n != 0 && n != -1) {
                a = a.split("^");
                return a[0];
            }
            var n = str.indexOf(":");
            if (n != 0 && n != -1) {
                a = a.split(":");
                return a[0];
            }
        }
    </script>


    <asp:UpdatePanel ID="Updatepanel1" runat="server">
        <ContentTemplate>
            <center>
                <h1 class="headingTxt">FLOWER CATEGORY MASTER
                </h1>
            </center>
            &nbsp;
            <center>
                <table>
                    <tr>
                        <td align="right">
                            <asp:Label ID="lblfcategory" runat="server" Text="Flower Category*^ :&nbsp;&nbsp;"
                                SkinID="lblRsz"></asp:Label>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtfcategory" runat="server" SkinID="txtRsz" TabIndex="1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">&nbsp;
                        </td>
                        <td align="left">&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="btnTd" colspan="2">
                            <center>
                                <asp:Button ID="btnAdd" runat="server" CssClass="ButtonClass" OnClientClick="return Validate();"
                                    SkinID="btn" Text="ADD" TabIndex="3" ValidationGroup="ADD" />
                                &nbsp;<asp:Button ID="btnView" runat="server" CausesValidation="False" CssClass="ButtonClass"
                                    SkinID="btn" TabIndex="4" Text="VIEW" />
                    </tr>
                </table>
            </center>
            <br />
            <center>
                <asp:Label ID="lblerrmsg" runat="server" SkinID="lblRed" Visible="true"></asp:Label>
                <asp:Label ID="lblmsgifo" runat="server" SkinID="lblGreen" Visible="true"></asp:Label>
            </center>
            <br />
            <center>
                <asp:Panel ID="panel2" runat="server" ScrollBars="Auto" Width="650px" Height="300px">
                    <table>
                        <tr>
                            <td>&nbsp;
                                <asp:GridView ID="GVFlower" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                    PageSize="100" SkinID="GridView" Width="300px">
                                    <Columns>
                                        <asp:TemplateField ShowHeader="false">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandName="Edit"
                                                    Text="Edit"></asp:LinkButton>
                                                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="false" CommandName="Delete"
                                                    Text="Delete" Visible="false" OnClientClick="return confirm('Do you want to delete the selected record?')"></asp:LinkButton>
                                                <br />
                                            </ItemTemplate>
                                            <ItemStyle Wrap="False" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Flower Category">
                                            <ItemTemplate>
                                                <asp:Label ID="lblfcategory" runat="server" Text='<%# Bind("FlowerCategory") %>'></asp:Label>
                                                <asp:Label ID="lblid" runat="server" Visible="false" Text='<%# Bind("FlowerCategoryId") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Wrap="false" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="#CCCCCC" />
                                    <PagerStyle ForeColor="Black" HorizontalAlign="Center" BackColor="#999999" />
                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                    <AlternatingRowStyle BackColor="#CCCCCC" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </center>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
