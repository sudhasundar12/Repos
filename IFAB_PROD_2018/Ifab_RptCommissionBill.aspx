<%@ Page Language="VB" MasterPageFile="~/Home.master" AutoEventWireup="false" CodeFile="Ifab_RptCommissionBill.aspx.vb"
    Inherits="Ifab_RptCommissionBill" Title="Commission Bill Report" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=B03F5F7F11D50A3A"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript" language="javascript">
        function Valid() {
            var msg;
            msg = ValidateDateMul(document.getElementById("<%=txttodate.ClientID%>"));
            if (msg != "") {
                document.getElementById("<%=txttodate.ClientID%>").focus();
                a = document.getElementById("<%=Label2.ClientID %>").innerHTML;
                msg = Spliter(a) + " " + ErrorMessage(msg);
                return msg;
            }
            return true;
        }
        function Validate() {
            var msg = Valid();

            if (msg != true) {
                if (navigator.appName == "Microsoft Internet Explorer") {
                    document.getElementById("<%=msginfo.ClientID%>").innerText = msg;
                    return false;
                }
                else if (navigator.appName == "Netscape") {
                    document.getElementById("<%=msginfo.ClientID%>").textContent = msg;
                    return false;
                }
                return true;
            }
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
            var n;
            n = str.indexOf("*");
            if (n != 0 && n != -1) {
                a = a.split("*");
                return a[0];
            }
            n = str.indexOf("^");
            if (n != 0 && n != -1) {
                a = a.split("^");
                return a[0];
            }
            n = str.indexOf(":");
            if (n != 0 && n != -1) {
                a = a.split(":");
                return a[0];
            }
        }
    </script>

    <asp:UpdatePanel ID="Updatepanel1" runat="server">
    
        <ContentTemplate>
      
            <div>
                <center>
                    <table>
                        <tr>
                            <td align="center">
                                <h1 class="headingTxt">
                                    <asp:Label ID="LabelEm" runat="server" Text="COMMISSION BILL REPORT" SkinID="lblRepRsz"
                                        Width="350" Visible="True"></asp:Label>
                                </h1>
                            </td>
                        </tr>
                    </table>
                </center>
                <%--<table>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>--%>
                <center>
                    <table class="custTable">
                        <tr>
                            <td align="right">
                                <asp:Label ID="Label3" runat="server"  Text="Grower :" SkinID="lbl"></asp:Label>
                            </td>
                                &nbsp<td align="left">
                            <asp:DropDownList ID="ddlGrowerid" runat="server" SkinID="ddlRsz" DataSourceID="ObjGrowerName"
                                DataTextField="Supp_Name" DataValueField="Supp_Id_Auto" TabIndex="1" Width="250px">
                            </asp:DropDownList>
                            <asp:ObjectDataSource runat="server" ID="ObjGrowerName" SelectMethod="Proc_GetGrowerNameDDLALL"
                                TypeName="DLIfabReportsR"></asp:ObjectDataSource>
                        </td>
                            
                        </tr>                       
                        <tr>
                            <td align="right">
                                <asp:Label ID="Label2" runat="server" Text="Auction Date* :" SkinID="lblRsz"></asp:Label>
                            </td>
                            <td align="left">
                                &nbsp<asp:TextBox ID="txttodate" runat="server" SkinID="txt" TabIndex="3"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="btnTd">
                                <asp:Button ID="btnReport" TabIndex="3" runat="server" Text="REPORT" SkinID="btn"
                                    CommandName="REPORT" CssClass="ButtonClass" OnClientClick="return Validate();">
                                </asp:Button>
                                <asp:Button ID="btnBack" TabIndex="4" runat="server" Text="BACK" SkinID="btn" CommandName="BACK"
                                    CssClass="ButtonClass"></asp:Button>
                               
                        </tr>
                        <tr>
                            <td colspan="4">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <center>
                                    <div>
                                       <hr/>
                                        <asp:CheckBox ID="ChkSMS" runat="server" Text="SMS" /> &nbsp&nbsp
                                        <asp:CheckBox ID="ChkMail" runat="server" Text="Mail"/><br/><br/>
                                         <asp:Button ID="btnEmail" TabIndex="4" runat="server" Text="SEND " SkinID="btnRsz" CommandName="EMAIL"
                                    CssClass="ButtonClass" Width="130px"></asp:Button>
                                    <asp:Button ID="btnStatus" TabIndex="5" runat="server" Text="STATUS " SkinID="btnRsz" 
                                    CssClass="ButtonClass" Width="130px"></asp:Button>
                                         <br />
                                    </div>
                                </center>
                            </td>
                        </tr>
                         <tr>
                            <td colspan="4">
                                <center>
                                    <div>
                                       <hr/>
                                       <br />
                                         <asp:Button ID="BtnAuto" TabIndex="4" runat="server" Text="Auto Send SMS/Email" SkinID="btnRsz" CommandName="EMAIL"
                                    CssClass="ButtonClass" Width="180px"></asp:Button>
                                         <br />
                                    </div>
                                </center>
                            </td>
                        </tr>
                        <td colspan="4">
                                <center>
                                    <div>
                                        <asp:Label ID="msginfo" runat="server" Width="600px"></asp:Label>
                                    </div>
                                </center>
                            </td>
                        </tr>
                        <tr>
                        <td colspan="2" align="center">
                            <asp:UpdateProgress runat="server" ID="PageUpdateProgress">
                                <ProgressTemplate>
                                    <div class="PleaseWait">
                                        <asp:Label ID="lblprocess" runat="server" Text="Sending Mail and SMS..Please wait..."
                                            SkinID="lblBlackRsz" Width="300" Visible="True"></asp:Label>
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                    </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </center>                
                <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txttodate"
                    Format="dd-MMM-yyyy" SkinID="Calendar">
                </ajaxToolkit:CalendarExtender>
            </div>
            <%--<rsweb:ReportViewer ID="ReportViewer1" runat="server" Visible="false">
            </rsweb:ReportViewer>--%>
            <asp:Timer ID="Timer1" runat="server">
            </asp:Timer>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
