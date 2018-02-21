﻿Imports Microsoft.VisualBasic
Imports System.Data.SqlClient

Public Class DLRpt_AttendenceDetails
    Shared Function GetBuyerCombo() As System.Data.DataTable
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("Advant").ConnectionString
        Dim ds As New DataSet
        Dim arParms() As SqlParameter = New SqlParameter(1) {}
        arParms(0) = New SqlParameter("@Office", SqlDbType.VarChar, 50)
        arParms(0).Value = HttpContext.Current.Session("Office")
        arParms(1) = New SqlParameter("@BranchCode", SqlDbType.VarChar, 50)
        arParms(1).Value = HttpContext.Current.Session("BranchCode")
        Try
            ds = SqlHelper.ExecuteDataset(connectionString, CommandType.StoredProcedure, "Proc_GetIFABBuyerDDL", arParms)

        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try
        Return ds.Tables(0)
    End Function
    Shared Function GetAttendenceDetails(ByVal CompanyId As Integer, ByVal StartDate As DateTime, ByVal EndDate As DateTime) As System.Data.DataTable
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("Advant").ConnectionString
        Dim ds As New DataSet
        Dim para() As SqlClient.SqlParameter = New SqlClient.SqlParameter(4) {}

        para(0) = New SqlParameter("@BranchCode", SqlDbType.VarChar, 50)
        para(0).Value = HttpContext.Current.Session("BranchCode")
        para(1) = New SqlParameter("@Office", SqlDbType.VarChar, 50)
        para(1).Value = HttpContext.Current.Session("Office")
        para(2) = New SqlParameter("@CompanyId ", SqlDbType.Int)
        para(2).Value = CompanyId
        para(3) = New SqlParameter("@StartDate ", SqlDbType.DateTime)
        para(3).Value = StartDate
        para(4) = New SqlParameter("@EndDate ", SqlDbType.DateTime)
        para(4).Value = EndDate

        Try
            ds = SqlHelper.ExecuteDataset(connectionString, CommandType.StoredProcedure, "IFAB_AttendenceReport", para)
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try
        Return ds.Tables(0)
    End Function
End Class
