<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Rpt_IPBlacklistV.aspx.vb" Inherits="Rpt_IPBlacklistV" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=B03F5F7F11D50A3A"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>IP Tracking Report</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" SizeToReportContent="true"
            AsyncRendering="false">
        </rsweb:ReportViewer>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </div>
    <center>
        <asp:Label ID="lblErrorMsg" runat="server" SkinID="lblRed"></asp:Label>
    </center>
    </form>
</body>
</html>
