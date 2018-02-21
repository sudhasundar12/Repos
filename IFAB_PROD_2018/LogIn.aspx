<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LogIn.aspx.vb" Inherits="LogIn" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>IFAB</title>
    <style type="text/css" media="all">
        .extraGlow
        {
            color: white;
            text-shadow: 0 0 30px yellow , 0 0 70px yellow;
        }
        #news-container
        {
            width: 560px;
            height: 400px;
            margin: 2px;
            margin-top: -5px;
        }
        #news-container ul li div
        {
        }
        .style1
        {
            height: 19px;
        }
        .style3
        {
            width: 916px;
        }
    </style>

    <script type="text/javascript" src="js/jquery.js"></script>

    <script type="text/javascript" src="js/jquery.vticker-min.js"></script>

    <script type="text/javascript">
function openNewWindows() {
            window.open("http://www.ifabindia.org/home.html");
        }
        function openNewWindows1() {
            //$("#dialog").dialog();
            //$("#frame").attr("src", "Images/ifab.pdf");
            $('.pop-up').show();
        }

        $(function() {
            $('#news-container').vTicker({
                speed: 1500,
                pause: 6000,
                animation: 'scroll',
                mousePause: true,
                showItems: 1
            });
        });

        function openwd() {

            window.open('ChatLogin.aspx', '', 'width=565,left=300,top=200,height=440,scrollbars=true').focus


        }
       
    </script>

    <link href="styleSheet.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form runat="server">
        <asp:ScriptManager runat="server"></asp:ScriptManager>
    <div>
        <asp:Panel ID="Panel3" runat="server">
            <center>
                <table style="padding-left: auto">
                    <tr>
                        <td align="left" colspan="2">
                            &nbsp&nbsp&nbsp&nbsp&nbsp
                        </td>
                        <td>
                            <center>
                                <img alt="" src="Images/IFAB_Logo.jpg" style="width: 78px; height: 63px; color: White" />
                                <table>
                                    <tr align="center">
                                        <td>
                                            <asp:Label ID="Label1" runat="server" Font-Size="XX-Large" ForeColor="Green" Font-Bold="True"
                                                Style="font-family: Calibri;" Text="International Flower Auction Bangalore Limited" />
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td>
                                            <asp:Label ID="Label12" runat="server" Font-Size="Medium" ForeColor="Orange" Font-Bold="True"
                                                Style="font-family: Calibri;" Text="First and largest International Flower Auction Company in Asia" />
                                        </td>
                                    </tr>
   <tr align="center">
                                            <td>
                                                <asp:HyperLink runat="server" ID="hyper" onclick="openNewWindows()" Style="text-decoration-line: underline; cursor: pointer; color: blue" Text="Visit IFAB Company Website" />
                                            </td>
                                        </tr>
                                </table>
                            </center>
                        </td>
                    </tr>
                </table>
            </center>
            <br />
            <br />
            <center>
                <table style="height: 272px; background-image: url('Images/b.jpg'); width: 898px;">
                    <tr>
                        <td align="center" style="border: thin solid #799BFF" colspan="2" class="style1">
                            <asp:Panel ID="Panel1" runat="server" Width="899px" BorderStyle="Solid" BorderWidth="1px">
                                <table>
                                    <tr>
                                        <td>
                                            <img alt="" src="Images/b.jpg" style="height: 250px; width: 598px" />
                                        </td>
                                        <td>
                                            <table>
                                                <tr>
                                                    <td align="right">
                                                        <asp:Label ID="Label3" runat="server" Font-Bold="True" Style="font-family: Calibri;"
                                                            Text="User ID :" BackColor="Transparent" />
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtUserId" runat="server" SkinID="txt" Width="146px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <asp:Label ID="Label4" runat="server" Font-Bold="True" Style="font-family: Calibri;"
                                                            Text="Password :" BackColor="Transparent" />
                                                    </td>
                                                    <td align="left">
                                                        <asp:TextBox ID="txtPassword" runat="server" SkinID="txt" TextMode="Password" Width="146px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" colspan="2">
                                                        <asp:RadioButtonList ID="RadioButtonList1" runat="server" Font-Bold="True" RepeatDirection="Horizontal" >
                                                            <asp:ListItem Selected="True" Value="1">Staff</asp:ListItem>
                                                            <asp:ListItem Value="2">Buyer</asp:ListItem>
                                                            <%--  <asp:ListItem Value="2">Grower</asp:ListItem>
                                                            <asp:ListItem Value="3">Buyer</asp:ListItem>--%>
                                                        </asp:RadioButtonList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <center>
                                                            <br />
                                                            <asp:Button ID="btnLogin" runat="server" BackColor="#CC0000" BorderStyle="Outset"
                                                                ForeColor="White" Height="32px" Text="LOGIN" Width="97px" />
                                                        </center>
                                                    </td>
                                                </tr>
                                                <%--<tr>
                                    <td colspan="2">
                                        <asp:CheckBox ID="CheckBox1" runat="server" Text=" I agree to " />
                                        <asp:HyperLink ID="HyperLink1" runat="server">terms & conditions</asp:HyperLink>
                                    </td>
                                </tr>--%>
                                                <tr>
                                                    <td colspan="2" align="center">
                                                        <asp:Label ID="lblNumberOfAttempts" runat="server" Text='<%# "The application locks a user out after <B>" & Membership.Provider.MaxInvalidPasswordAttempts & " </B>failed login attempts." %>'
                                                            Visible="False" Width="290px" ForeColor="Red"></asp:Label>
                                                        <br />
                                                        <asp:Label ID="lblResults" runat="server" ForeColor="Red" Visible="False" Width="290px">Result : </asp:Label>
                                                    </td>
                                                </tr>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                </table>
                </td> </tr> </table>
            </center>
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <center>
                <a>
                    <asp:UpdatePanel runat="server" >
                        <ContentTemplate>
                            <table>
 <tr>
                                        <td>
                                            <asp:LinkButton ID="Link" runat="server" Text="Terms & Conditions for Online Payment by Buyers" OnClick="btnLogin_Click" Style="text-decoration-line: underline; cursor: pointer; color: blue"  CausesValidation="true" />
                                            <%--OnClientClick="Modelopen();return false;"--%>
                                            <%--<asp:HyperLink runat="server" ID="HyperLink1" onclick="openNewWindows1()" style="text-decoration-line:underline;cursor:pointer;color:blue"  Text="Terms & Conditions for Online Payment by Buyers" />--%>
                                        </td>
                                    </tr>
                        <%--<tr>
                                <td style="border: thin solid #C0C0C0" align="left" class="style3">
                                    <%--<asp:BulletedList ID="BulletedList3" DataSourceID="ObjN0" DataTextField="ContentText"
                                    DataValueField="L_ID" runat="server" Font-Bold="false" Font-Size="small" Font-Names="Calibri"
                                    ForeColor="#666666" Width="850px" Style="margin-left: 0px; margin-bottom: 0px">
                                </asp:BulletedList>
                            </td> </tr>--%>
                        <tr>
                            <td align="center" bgcolor="#00cc00" class="style3">
                                <asp:Label ID="Label5" runat="server" Text="Copyright Advant Techservices India Private Limited"
                                    ForeColor="White"></asp:Label>
                                <a href="http://www.advant-tech.com" target="_blank" style="color: #FFFFFF">www.advant-tech.com</a>
                            </td>
                        </tr>
                        <%--<tr>
                                <td align="center" class="style3">
                                    
                                </td>
                            </tr>--%>
                    </table>
                        </ContentTemplate>
                            
                    </asp:UpdatePanel>
                    
                </a>
    </div>
    </center>
    <asp:ObjectDataSource ID="ObjNE" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetLogInNewsEvents" TypeName="UserDetailsDB"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjN0" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetLogInNotice" TypeName="UserDetailsDB"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjObj" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetLogInObj" TypeName="UserDetailsDB"></asp:ObjectDataSource>
    </asp:Panel>
    <asp:Panel ID="Panel2" runat="server" Visible="false" DefaultButton="btnok">
        <center>
            <center>
                <table style="padding-left: auto">
                    <tr>
                        <td align="left" colspan="2">
                            &nbsp&nbsp&nbsp&nbsp&nbsp
                        </td>
                        <td>
                            <center>
                                <img alt="" src="Images/IFAB_Logo.jpg" style="width: 78px; height: 63px; color: White" />
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label2" runat="server" Font-Size="XX-Large" ForeColor="Green" Font-Bold="True"
                                                Style="font-family: Calibri;" Text="International Flower Auction Bangalore Limited" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label6" runat="server" Font-Size="Medium" ForeColor="Orange" Font-Bold="True"
                                                Style="font-family: Calibri;" Text="First and largest International Flower Auction Company in Asia" />
                                        </td>
                                    </tr>
                                </table>
                            </center>
                        </td>
                    </tr>
                </table>
            </center>
            <%-- <table>
                    <tr>
                        <td align="left">&nbsp&nbsp&nbsp&nbsp
                            <a href="http://www.advant-tech.com" target="_blank">
                                <asp:Image ID="Image3" runat="server" Height="50px" Style="position: absolute; z-index: 200;
                                    top: 20px;" ImageUrl="~/Images/log.gif" Width="50px" />
                            </a>
                           <asp:Label runat="server" ID="Label1" align="right" Text="&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbspAdvant Techservices India Private Limited"
                                ForeColor="WhiteSmoke" Font-Names="monotype corsiva" Font-Size="35px" Style="position: absolute;
                                z-index: 200; top: 31px; filter: Glow(Color=#000000, Strength=5);
                                width: 898px; left: 153px;" />
                            <asp:Image ID="Image4" runat="server" Height="80px" ImageUrl="~//img1.jpg" DataSourceID="Objimg"
                                Width="900px" DataValueField="image" />
                        </td>
                    </tr>
                </table>--%>
            <table>
                <tr>
                    <td colspan="2" align="center">
                        <h1 class="headingTxt">
                            <asp:Label ID="lblBranch" Text="" runat="server"></asp:Label>
                        </h1>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <h3 class="headingTxt">
                            <asp:Label ID="Lblheading" Text="ENTER SECURITY PASSWORD" runat="server"></asp:Label>
                        </h3>
                    </td>
                </tr>
                <%--<tr>
                        <td colspan="2" align="center">
                            <h3 class="headingTxt">
                                <asp:Label ID="lblEnter" Text="Enter your Branch security password" runat="server"></asp:Label>
                            </h3>
                        </td>
                    </tr>--%>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="lblSPassword" runat="server" Font-Bold="True" Style="font-family: Calibri;"
                            Text="Secure Password :" />
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtSPassword" runat="server" SkinID="txt" TextMode="Password" Width="146px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <asp:Button ID="btnok" runat="server" CssClass="ButtonClass" Text="OK" SkinID="btn"
                            BackColor="#336600" />
                        &nbsp;
                        <asp:Button ID="btnBack" runat="server" CssClass="ButtonClass" Text="BACK" SkinID="btn" BackColor="#336600" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <asp:Label ID="lblSResult" runat="server" ForeColor="Red" Visible="False" Width="290px">Result : </asp:Label>
                    </td>
                </tr>
            </table>
        </center>
    </asp:Panel>
    </div>
    </form>

    <script type="text/javascript" src="marquee.js"></script>

</body>
</html>
