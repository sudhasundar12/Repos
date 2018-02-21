﻿Imports System.Web.UI.WebControls
Imports System.Web.UI

Partial Class frmAuctionLot
    Inherits BasePage
    Dim dt As DataTable
    Dim dt1, dt2 As DataTable
    Dim count, count1 As Integer
    Dim Gl As New Globals
    Dim GrowerType As String
    Dim Remarks As String

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            DisplayGrid()
            BtnClose.Attributes.Add("onclick", "self.close();")
            txtDate.Text = Today.ToString("dd-MMM-yyyy")
        End If
        Dim Id As Integer = 0
        'For Each Grid As GridViewRow In GVAuctionLot.Rows
        '    CType(Grid.FindControl("lblSLNo"), Label).Text = Id + 1
        '    Id = Id + 1
        'Next
    End Sub

    Protected Sub BtnClose_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnClose.Click
        Response.Write("<script language='javascript'> { self.close() }</script>")
    End Sub
    Sub DisplayGrid()
        If Not IsPostBack Then
            GrowerType = "ALL"
        Else
            GrowerType = ddlGrowerType.SelectedItem.Text
        End If

        dt1 = DLAuctionLot.GetAuctionLot(GrowerType)
        count1 = dt1.Rows.Count

        If dt1.Rows.Count > 0 Then
            GVAuctionLot.DataSource = dt1
            GVAuctionLot.DataBind()
            GVAuctionLot.Visible = True
            GVAuctionLot.Enabled = True
            'lblErrorMsg.Text = ""
        Else
            lblErrorMsg.Text = "No Records to display."
            lblgreen.Text = ""
            GVAuctionLot.Visible = False
        End If
        If GVAuctionLot.Rows.Count > 0 Then
            For Each Grid As GridViewRow In GVAuctionLot.Rows
                CType(Grid.FindControl("ddlReason"), DropDownList).SelectedValue = CType(Grid.FindControl("lblReasonId"), Label).Text
            Next
        End If
    End Sub
    Sub CheckAll()
        If CType(GVAuctionLot.HeaderRow.FindControl("ChkAll"), CheckBox).Checked = True Then
            GVAuctionLot.Visible = True

            For Each grid As GridViewRow In GVAuctionLot.Rows
                CType(grid.FindControl("ChkSelect"), CheckBox).Checked = True
            Next
        Else
            GVAuctionLot.Visible = True


            For Each grid As GridViewRow In GVAuctionLot.Rows
                CType(grid.FindControl("ChkSelect"), CheckBox).Checked = False
            Next
        End If

    End Sub

    Protected Sub BtnUpdateMaxPrice_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnUpdateMaxPrice.Click
        If (Session("BranchCode") = Session("ParentBranch")) Then
            Dim Id As Integer
            Dim count As Integer = 0
            Dim MaxPrice As Double
            Dim Flag As Integer
            Dim Reason As String
            For Each Grid As GridViewRow In GVAuctionLot.Rows
                If CType(Grid.FindControl("ChkSelect"), CheckBox).Checked = True Then
                    count = count + 1
                End If
            Next
            If count > 0 Then
                For Each Grid As GridViewRow In GVAuctionLot.Rows
                    If CType(Grid.FindControl("ChkSelect"), CheckBox).Checked = True And CType(Grid.FindControl("TxtMaxPrice"), TextBox).Text <> "" Then
                        If CType(Grid.FindControl("TxtMaxPrice"), TextBox).Text <> "" Then
                            Id = CType(Grid.FindControl("lblAuctionId"), Label).Text
                            If CType(Grid.FindControl("TxtMaxPrice"), TextBox).Text = "" Then
                                MaxPrice = 0
                            Else
                                MaxPrice = CType(Grid.FindControl("TxtMaxPrice"), TextBox).Text
                            End If
                            Reason = CType(Grid.FindControl("ddlReason"), DropDownList).SelectedValue
                            'Update Max Price and Reason
                            Flag = DLAuctionLot.UpdateMaxPrice(Id, MaxPrice, Reason)
                            If Flag <> -1 Then
                                lblgreen.Text = ValidationMessage(1017)
                                lblErrorMsg.Text = ""
                            Else
                                lblgreen.Text = ""
                                lblErrorMsg.Text = "Please Enter Maximum Price Less than Minimum Price."
                            End If
                        Else
                            lblErrorMsg.Text = ValidationMessage(1086)
                            lblgreen.Text = ""
                            Exit For
                        End If
                    End If
                Next
            Else
                lblErrorMsg.Text = ValidationMessage(1087)
                lblgreen.Text = ""
            End If



            'lblErrorMsg.Visible = True
            'lblgreen.Visible = True
            DisplayGrid()

        Else
            lblErrorMsg.Text = ValidationMessage(1029)
            lblgreen.Text = ""
        End If
    End Sub
    Public Function ValidationMessage(ByVal ErrorCode As Integer) As String
        Dim dt2 As DataTable
        dt2 = Session("ValidationTable")
        Dim X As Integer = dt2.Rows.Count() - 1
        Dim str As String = " "
        For i As Integer = 0 To X
            If (dt2.Rows(i).Item("MessageCode").ToString() = ErrorCode) Then
                Return dt2.Rows(i).Item("MessageText").ToString()
            End If
        Next
        Return 0
    End Function
    <System.Web.Services.WebMethod()> Public Sub AbandonSession()
        Dim i As Int16 = UserDetailsDB.UpdateUserlog()
        Response.Redirect("LogIn.aspx")
    End Sub

    Protected Sub BtnCancelLot_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnCancelLot.Click
        If (Session("BranchCode") = Session("ParentBranch")) Then
            'Dim Id As Integer
            'Dim Remarks As String
            Dim AuctionStatus As String = ""
            Dim Id1 As Integer
            Dim count As Integer = 0
            For Each Grid As GridViewRow In GVAuctionLot.Rows
                If CType(Grid.FindControl("ChkSelect"), CheckBox).Checked = True Then
                    count = count + 1
                End If
            Next

            If count > 1 Then
                lblErrorMsg.Text = "Please select one Lot at a time."
                lblgreen.Text = ""
                Exit Sub
            ElseIf count = 0 Then
                lblErrorMsg.Text = "Please select the Lot."
                lblgreen.Text = ""
                Exit Sub
            End If

            If count > 0 Then
                For Each Grid As GridViewRow In GVAuctionLot.Rows
                    If CType(Grid.FindControl("ChkSelect"), CheckBox).Checked = True Then
                        Id1 = CType(Grid.FindControl("lblAuctionId"), Label).Text
                        dt1 = DLAuctionLot.CheckAuctionStatus(Id1)
                        AuctionStatus = dt1.Rows(0).Item("AuctionFlag").ToString
                    End If
                Next
            End If

            If AuctionStatus = "Y" Then
                lblErrorMsg.Text = "Lot Can Not Be Cancel , Already Auctioned."
                lblgreen.Text = ""
            Else
                '        For Each Grid As GridViewRow In GVAuctionLot.Rows
                '            If Left(Globals._LotNumber, 2) = "FC" Then
                '                lblErrorMsg.Text = "Clock has not picked the previous Lot for Auction."
                '                lblgreen.Text = ""
                '            Else
                '                If CType(Grid.FindControl("ChkSelect"), CheckBox).Checked = True Then
                '                    Gl.LotNumber = "FC:" + CType(Grid.FindControl("lblLotNumber"), Label).Text
                '                    lblgreen.Text = "Auction Lot " + CType(Grid.FindControl("lblLotNumber"), Label).Text + "  proposed to clock."
                '                    lblErrorMsg.Text = ""
                '                    Exit Sub
                '                End If
                '            End If
                '        Next
                '    End If
                'Else
                For Each Grid As GridViewRow In GVAuctionLot.Rows
                    If CType(Grid.FindControl("ChkSelect"), CheckBox).Checked = True Then
                        count = count + 1
                    End If
                Next
                If count > 0 Then
                    For Each Grid As GridViewRow In GVAuctionLot.Rows
                        If CType(Grid.FindControl("ChkSelect"), CheckBox).Checked = True Then
                            ID = CType(Grid.FindControl("lblAuctionId"), Label).Text
                            Remarks = CType(Grid.FindControl("ddlReason"), DropDownList).SelectedValue
                            If Remarks = "0" Then
                                lblErrorMsg.Text = ValidationMessage(1095)
                                lblgreen.Text = ""
                                Exit For
                            End If
                            DLAuctionLot.CancelAuctionLot(ID, Remarks)
                            lblgreen.Text = ValidationMessage(1089)
                            lblErrorMsg.Text = ""

                        End If
                    Next
                Else
                    lblErrorMsg.Text = ValidationMessage(1088)
                    lblgreen.Text = ""
                End If



                'lblErrorMsg.Visible = True
                'lblgreen.Visible = True
                DisplayGrid()

                'Else 
                'lblErrorMsg.Text = ValidationMessage(1029)
                'lblgreen.Text = ""
            End If
        End If

    End Sub

    Protected Sub BtnAuction_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnAuction.Click
        Dim count As Integer = 0
        Dim Id1 As Integer
        Dim AuctionStatus As String = ""
        For Each Grid As GridViewRow In GVAuctionLot.Rows
            If CType(Grid.FindControl("ChkSelect"), CheckBox).Checked = True Then
                count = count + 1
            End If
        Next

        If count > 1 Then
            lblErrorMsg.Text = "Please select one Lot at a time."
            lblgreen.Text = ""
            Exit Sub
        ElseIf count = 0 Then
            lblErrorMsg.Text = "Please select the Lot."
            lblgreen.Text = ""
            Exit Sub
        End If

        If count > 0 Then
            For Each Grid As GridViewRow In GVAuctionLot.Rows
                If CType(Grid.FindControl("ChkSelect"), CheckBox).Checked = True Then
                    Id1 = CType(Grid.FindControl("lblAuctionId"), Label).Text
                    dt1 = DLAuctionLot.CheckAuctionStatus(Id1)
                    AuctionStatus = dt1.Rows(0).Item("AuctionFlag").ToString
                End If
            Next
        End If

        If AuctionStatus = "Y" Then
            lblErrorMsg.Text = "Lot already Auctioned."
            lblgreen.Text = ""
        Else
            For Each Grid As GridViewRow In GVAuctionLot.Rows
                If Left(Globals._LotNumber, 2) = "FC" Then
                    lblErrorMsg.Text = "Clock has not picked the previous Lot for Auction."
                    lblgreen.Text = ""
                Else
                    If CType(Grid.FindControl("ChkSelect"), CheckBox).Checked = True Then
                        Gl.LotNumber = "FC:" + CType(Grid.FindControl("lblLotNumber"), Label).Text
                        lblgreen.Text = "Auction Lot " + CType(Grid.FindControl("lblLotNumber"), Label).Text + "  proposed to clock."
                        lblErrorMsg.Text = ""
                        Exit Sub
                    End If
                End If
            Next
        End If

    End Sub

    Protected Sub BtnRefresh_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnRefresh.Click
        DisplayGrid()
        lblErrorMsg.Text = ""
        lblgreen.Text = ""
        txtDate.Text = Today.ToString("dd-MMM-yyyy")
    End Sub

    Protected Sub BtnLoadAuctionLot_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnLoadAuctionLot.Click
        DisplayGrid()
    End Sub

    Protected Sub BtnReAuction_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnReAuction.Click
        Dim count As Integer = 0
        Dim Id1 As Integer
        Dim AuctionBalance As Integer
        For Each Grid As GridViewRow In GVAuctionLot.Rows
            If CType(Grid.FindControl("ChkSelect"), CheckBox).Checked = True Then
                count = count + 1
            End If
        Next

        If count > 1 Then
            lblErrorMsg.Text = "Please select one Lot at a time."
            lblgreen.Text = ""
            Exit Sub
        ElseIf count = 0 Then
            lblErrorMsg.Text = "Please select the Lot."
            lblgreen.Text = ""
            Exit Sub
        End If

        If count > 0 Then
            For Each Grid As GridViewRow In GVAuctionLot.Rows
                If CType(Grid.FindControl("ChkSelect"), CheckBox).Checked = True Then
                    If Left(Globals._LotNumber, 2) <> "FC" Then
                        Id1 = CType(Grid.FindControl("lblAuctionId"), Label).Text
                        dt1 = DLAuctionLot.CheckAuctionBalance(Id1)
                        AuctionBalance = CInt(dt1.Rows(0).Item("Balance"))
                    End If
                End If
            Next
        End If

        If AuctionBalance <= 0 Then
            lblErrorMsg.Text = "No Balance Quantity to Reacution."
            lblgreen.Text = ""
        Else
            For Each Grid As GridViewRow In GVAuctionLot.Rows
                If Left(Globals._LotNumber, 2) = "FC" Then
                    lblErrorMsg.Text = "Clock has not picked the previous Lot for Auction."
                    lblgreen.Text = ""
                Else
                    If CType(Grid.FindControl("ChkSelect"), CheckBox).Checked = True Then
                        Gl.LotNumber = "FC:" + CType(Grid.FindControl("lblLotNumber"), Label).Text
                        lblgreen.Text = "Auction Lot " + CType(Grid.FindControl("lblLotNumber"), Label).Text + "  proposed to clock for Reauction."
                        lblErrorMsg.Text = ""
                        Exit Sub
                    End If
                End If
            Next
        End If
    End Sub

    Protected Sub BtnView_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnView.Click
        Dim AuctionDate As DateTime
        If txtDate.Text = "" Then
            AuctionDate = "01/01/1900"
        Else
            AuctionDate = txtDate.Text
        End If
        'For Selected Date display Auction Lots
        DisplayGridView()
    End Sub
    Sub DisplayGridView()
        If Not IsPostBack Then
            GrowerType = "ALL"
        Else
            GrowerType = ddlGrowerType.SelectedItem.Text
        End If
        Dim AuctionDate As DateTime
        If txtDate.Text = "" Then
            AuctionDate = "01/01/1900"
        Else
            AuctionDate = txtDate.Text
        End If

        If AuctionDate < Date.Today().ToString("dd-MMM-yyyy") Then
            lblErrorMsg.Text = "Cannot Load Previous dates Lots."
            lblgreen.Text = ""
            Exit Sub
        End If

        dt1 = DLAuctionLot.GetAuctionLotView(GrowerType, AuctionDate)
        If dt1.Rows.Count > 0 Then
            GVAuctionLot.DataSource = dt1
            GVAuctionLot.DataBind()
            GVAuctionLot.Visible = True
            GVAuctionLot.Enabled = True
            lblErrorMsg.Text = ""
            lblgreen.Text = ""
        Else
            lblErrorMsg.Text = "No Records to display."
            lblgreen.Text = ""
            GVAuctionLot.Visible = False
        End If
        If GVAuctionLot.Rows.Count > 0 Then
            For Each Grid As GridViewRow In GVAuctionLot.Rows
                CType(Grid.FindControl("ddlReason"), DropDownList).SelectedValue = CType(Grid.FindControl("lblReasonId"), Label).Text
            Next
        End If
    End Sub

    Protected Sub GVAuctionLot_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles GVAuctionLot.Load
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "callFunctionsStartupScript", "grid();", True)
    End Sub
End Class
