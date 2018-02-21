﻿<%@ Page Language="VB" MasterPageFile="~/Home.master" AutoEventWireup="false" CodeFile="RptCRMAppt.aspx.vb"
    Inherits="RptCRMAppt" Title="CRM-Appointment Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel runat="server" ID="Up1">
        <ContentTemplate>
            <center>
                <h1 class="headingTxt">
                    CRM-APPOINTMENT DETAILS
                </h1>
                <br />
                <table>
                    <tr>
                        <td align="right">
                            <asp:Label ID="lblEmp" runat="server" Text="Assigned To :&nbsp;&nbsp;" SkinID="lbl"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlApptAssignedto" runat="server" SkinID="ddl" DataSourceID="ObjEmp"
                                DataValueField="EmpID" DataTextField="Emp_Name" TabIndex="1">
                            </asp:DropDownList>
                            <asp:ObjectDataSource ID="ObjEmp" runat="server" SelectMethod="GetEmpComboAll" TypeName="DLAppointmentCRM">
                            </asp:ObjectDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="lblFrmdate" runat="server" Text="From Date :&nbsp;&nbsp;" SkinID="lblRsz"></asp:Label>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtFromDate" runat="server" SkinID="txt" MaxLength="11" TabIndex="2"></asp:TextBox>
                            <ajaxToolkit:CalendarExtender ID="SDate" runat="server" TargetControlID="txtFromDate"
                                Format="dd-MMM-yyyy">
                            </ajaxToolkit:CalendarExtender>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="lblToDate" runat="server" Text="To Date :&nbsp;&nbsp;" SkinID="lblRsz"></asp:Label>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtToDate" runat="server" SkinID="txt" MaxLength="11" TabIndex="3"></asp:TextBox>
                            <ajaxToolkit:CalendarExtender ID="EDate" runat="server" TargetControlID="txtToDate"
                                Format="dd-MMM-yyyy">
                            </ajaxToolkit:CalendarExtender>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="btnTd">
                            <asp:Button ID="Btnreport" runat="server" Text="REPORT" SkinID="btn" TabIndex="4"
                                CssClass="ButtonClass " />
                            &nbsp;<asp:Button ID="btnBack" runat="server" CssClass="ButtonClass" SkinID="btn"
                                TabIndex="5" Text="BACK" />
                        </td>
                    </tr>
                </table>
                <asp:Label ID="msginfo" runat="server" SkinID="lblRed" Visible="true" TabIndex="-1"></asp:Label>
            </center>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
