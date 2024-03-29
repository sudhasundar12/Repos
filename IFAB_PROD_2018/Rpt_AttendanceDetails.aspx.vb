﻿
Partial Class Rpt_AttendanceDetails
    Inherits BasePage



    Protected Sub btnReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReport.Click
        lblmsg.Text = ""
        msginfo.Text = ""
        Dim CompanyId As Integer
        Dim fromdateE As DateTime
        Dim todateE As DateTime
        If ddlBuyer.SelectedValue = "" Then
            CompanyId = 0
        Else
            CompanyId = ddlBuyer.SelectedValue
        End If
       
        If txtstartdate.Text = "" Then
            fromdateE = "1/1/1900"
        Else
            fromdateE = txtstartdate.Text
        End If
        If txtenddate.Text = "" Then
            todateE = "1/1/3000"
        Else
            todateE = txtenddate.Text
        End If
        If fromdateE > todateE Then
            msginfo.Text = "Start date should not be greater than End date."
            txtenddate.Focus()
            Exit Sub
        End If
        Dim qrystring As String = "Rpt_AttendanceDetailsV.aspx?" & QueryStr.Querystring() & "&StartDate=" & fromdateE & "&EndDate=" & todateE & "&CompanyId=" & CompanyId
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "message", "<script>window.open('" & qrystring & "',null,'toolbar=no,scrollbars=yes,location=no,resizable =yes,width=800,height=600,left=40,top=80')</script>", False)

        'AlertEnterAllFields()

    End Sub

    Protected Sub btnBack_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBack.Click
        Response.Redirect("Report.aspx")
    End Sub

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txtstartdate.Text = Format(Today.Date(), "dd-MMM-yyyy")
            txtenddate.Text = Format(Today.Date(), "dd-MMM-yyyy")
        End If
    End Sub
End Class