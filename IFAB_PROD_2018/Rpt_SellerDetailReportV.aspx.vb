﻿Partial Class Rpt_SellerDetailReportV
    Inherits BasePage

    Dim ds1 As DataTable
    Dim Prop As New QureyStringP
    Dim obj As New SelfDetailsB
    Dim dt1 As New DataTable
    Dim DS As New DataSet
    Dim DL As New DLRpt_SellerDetailReport

    Dim dr1 As New Microsoft.Reporting.WebForms.ReportDataSource
    Protected Sub ReportViewer1_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles ReportViewer1.Init

        Dim Growerid As String = Request.QueryString.Get("Growerid")
        QueryStr.GetValue(Page.Request, Prop)

        dt1 = DLRpt_SellerDetailReport.GetSellerDetails(Growerid)
        Try
            If dt1.Rows.Count > 0 Then
                ReportViewer1.LocalReport.ReportPath = "Rpt_SellerDetailReport.rdlc"
                dr1 = New Microsoft.Reporting.WebForms.ReportDataSource("GlobalDataSet_IFAB_GrowerDetailsReport", dt1)

                Dim paramList As New Generic.List(Of Microsoft.Reporting.WebForms.ReportParameter)

                Me.ReportViewer1.LocalReport.DataSources.Add(dr1)
                ReportViewer1.LocalReport.Refresh()
                ds1 = obj.RPT_GetSelfDeatilsByBranch(Request.QueryString(1))
                AddHandler ReportViewer1.LocalReport.SubreportProcessing, AddressOf SubreportProcessingEvent
            Else
                lblErrorMsg.Text = "No Records to Display."
            End If
        Catch ex As Exception
            lblErrorMsg.Text = "Error While loading Report, Enter all Mandatory fields and try again. "
        End Try



    End Sub

    Sub SubreportProcessingEvent(ByVal sender As Object, ByVal e As Microsoft.Reporting.WebForms.SubreportProcessingEventArgs)
        Dim rptDataSource As New Microsoft.Reporting.WebForms.ReportDataSource("GlobalDataSet_Proc_RPT_GetSelfDetailByUID", ds1)
        e.DataSources.Add(rptDataSource)
    End Sub

End Class



