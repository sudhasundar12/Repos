﻿Partial Class Rpt_SellerDetailReport
    Inherits BasePage
    Protected Sub btnReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReport.Click
        lblmsg.Text = ""
        msginfo.Text = ""
        Dim Growerid As Integer
        'Dim fromdateE As DateTime

        If ddlGrowerid.SelectedValue = "" Then
            Growerid = 0
        Else
            Growerid = ddlGrowerid.SelectedValue
        End If

        'If txtstartdate.Text = "" Then
        '    fromdateE = "1/1/1900"
        'Else
        '    fromdateE = txtstartdate.Text
        'End If

        Dim qrystring As String = "Rpt_SellerDetailReportV.aspx?" & QueryStr.Querystring() & "&Growerid=" & Growerid
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "message", "<script>window.open('" & qrystring & "',null,'toolbar=no,scrollbars=yes,location=no,resizable =yes,width=800,height=600,left=40,top=80')</script>", False)

        'AlertEnterAllFields()

    End Sub

    Protected Sub btnBack_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBack.Click
        Response.Redirect("Report.aspx")
    End Sub
End Class