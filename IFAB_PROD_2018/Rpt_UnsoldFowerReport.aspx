﻿<%@ Page Title="UNSOLD FLOWER REPORT" Language="VB" MasterPageFile="~/Home.master" AutoEventWireup="false" CodeFile="Rpt_UnsoldFowerReport.aspx.vb" Inherits="Rpt_UnsoldFowerReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script type="text/javascript">
        function Validate() {
            var msg = Valid();

            if (msg != true) {
                if (navigator.appName == "Microsoft Internet Explorer") {
                    document.getElementById("<%=msginfo.ClientID%>").innerText = msg;
                    document.getElementById("<%=lblmsg.ClientID%>").innerText = "";
                    return false;
                }
                else if (navigator.appName == "Netscape") {
                document.getElementById("<%=msginfo.ClientID%>").textContent = msg;
                document.getElementById("<%=lblmsg.ClientID%>").textContent = "";
                    return false;
                }
                return true;
            }
        }

        //Function for Multilingual Validations
        //Created by siddharth

        function Valid() {

            var msg, a;
        
            msg = ValidateDateMul(document.getElementById("<%=txtstartdate.ClientID %>"));
            if (msg != "") {
                document.getElementById("<%=txtstartdate.ClientID %>").focus();
                a = document.getElementById("<%=lblstartdate.ClientID %>").innerHTML;
                msg = Spliter(a) + " " + ErrorMessage(msg);
                return msg;
            }
            msg = ValidateDateMul(document.getElementById("<%=txtenddate.ClientID %>"));
            if (msg != "") {
                document.getElementById("<%=txtenddate.ClientID %>").focus();
                a = document.getElementById("<%=lblenddate.ClientID %>").innerHTML;
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
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div>
                <center>
                    <h1 class="headingTxt">
                      UNSOLD FLOWER REPORT
                        <br />
                        <br />
                    </h1>
                </center>
                <center>
                    <table>
                        <tr>
                            <td align="right">
                                <asp:Label ID="lblGrowerName" runat="server" SkinID="lbl"  Text="Grower Name :&nbsp;&nbsp;"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlGrowerid" runat="server" SkinID="ddl" DataSourceID="ObjGrowerName"
                                    DataTextField="Supp_Name" DataValueField="Supp_Id_Auto" TabIndex="1">
                                </asp:DropDownList>
                                <asp:ObjectDataSource runat="server" ID="ObjGrowerName" SelectMethod="GetDDlGrowerName"
                                    TypeName="DLUnsoldFlower"></asp:ObjectDataSource>
                            </td>
                        </tr>
                          <tr>
                            <td align="right">
                                <asp:Label ID="lblstartdate" Width="150px" runat="server" Text="From Date* :&nbsp;&nbsp;"
                                    SkinID="lblRsz"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtstartdate" runat="server" SkinID="txt" TabIndex="1"></asp:TextBox>
                                <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender15" runat="server"
                                    FilterMode="InvalidChars" FilterType="Numbers" InvalidChars="'" TargetControlID="txtstartdate"
                                    Enabled="True">
                                </ajaxToolkit:FilteredTextBoxExtender>
                                <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" Animated="False"
                                    Format="dd-MMM-yyyy" TargetControlID="txtstartdate" Enabled="True">
                                </ajaxToolkit:CalendarExtender>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="lblenddate" runat="server" SkinID="lblRsz" Text="To Date* :&nbsp;&nbsp;"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtenddate" runat="server" SkinID="txt" TabIndex="3"></asp:TextBox>
                                <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server"
                                    FilterMode="InvalidChars" FilterType="Numbers" InvalidChars="'" TargetControlID="txtenddate"
                                    Enabled="True">
                                </ajaxToolkit:FilteredTextBoxExtender>
                                <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Animated="False"
                                    Format="dd-MMM-yyyy" TargetControlID="txtenddate" Enabled="True">
                                </ajaxToolkit:CalendarExtender>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="btnTd">
                                <asp:Button ID="btnReport" runat="server" Text="REPORT" SkinID="btn" TabIndex="2"
                                    CssClass="ButtonClass" OnClientClick="return Validate();" ></asp:Button>
                                <asp:Button ID="btnBack" TabIndex="3" runat="server" Text="BACK" SkinID="btn" CssClass="ButtonClass">
                                </asp:Button>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Label ID="msginfo" runat="server" SkinID="lblRed" Visible="true"></asp:Label>
                    <asp:Label ID="lblmsg" runat="server" SkinID="lblGreen" Visible="true"></asp:Label>
                </center>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>



