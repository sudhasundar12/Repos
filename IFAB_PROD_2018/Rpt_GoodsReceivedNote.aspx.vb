﻿
Partial Class Rpt_GoodsReceivedNote
    Inherits BasePage

    Protected Sub btnReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReport.Click
        Try
            Dim QS As String
            Dim GrowerId As Integer = ddlGrowerid.SelectedValue
            Dim EntryDate As DateTime

            If txtDate.Text = "" Then
                EntryDate = "01/01/1900"
            Else
                EntryDate = txtDate.Text
            End If

            QS = Request.QueryString.Get("QS")
            If txtDate.Text = "" Then
                lblErrorMsg.Text = "Please enter the Date."
            Else
                Dim qrystring As String = "Rpt_GoodsReceivedNoteV.aspx?" & QueryStr.Querystring() & "&GrowerId=" & GrowerId & "&EntryDate=" & EntryDate
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "message", "<script>window.open('" & qrystring & "',null,'toolbar=no,scrollbars=yes,location=no,resizable =yes,width=1050,height=700,left=0,top=0')</script>", False)
                lblErrorMsg.Text = ""
            End If
        Catch ex As Exception
            lblErrorMsg.Text = "Please enter correct data."
        End Try
    End Sub

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txtDate.Text = Today.ToString("dd-MMM-yyyy")
        End If
    End Sub
    Protected Sub btnBack_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBack.Click
        Response.Redirect("Report.aspx")
    End Sub
End Class
