﻿'Imports System.Web
Imports System.Web.Services
'Imports System.Web.Services.Protocols
'Imports System.Web.Caching
Imports System.IO
'Imports System
'Imports System.Collections.Generic
Imports System.Data.SqlClient
'Imports System.Data

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class Service
    Inherits System.Web.Services.WebService
    Dim connstr As String = ConfigurationManager.ConnectionStrings("Advant").ConnectionString
    Dim con As SqlConnection = New SqlConnection(connstr)
    Dim cmd As SqlCommand
    Dim myDA As SqlDataAdapter
    Dim myDataSet As DataSet
    Dim dt, dt1, dtsta, dtdup As New DataTable
    Dim userName, password, imei As String
    Dim LOG As New DataTable

    <WebMethod(EnableSession:=True)> _
    Public Function Flower(ByVal IP As String, ByVal BID As String, ByVal ADATE As String, ByVal B As String, ByVal DATA As String) As String
        Dim strFile As String = String.Format(Server.MapPath(("~\comm_log.txt")), DateTime.Today.ToString("dd-MMM-yyyy"))
        Dim s As String = String.Empty
        Dim BuyerId As String = String.Empty
        Dim Key As String = String.Empty
        Dim Result As String = String.Empty

        Select Case B

            Case "A"
                Dim strarr() As String
                strarr = DATA.Split(",")
                userName = strarr(0)
                password = RijndaelSimple.Encrypt(strarr(1), _
                                               RijndaelSimple.passPhrase, _
                                               RijndaelSimple.saltValue, _
                                               RijndaelSimple.hashAlgorithm, _
                                               RijndaelSimple.passwordIterations, _
                                               RijndaelSimple.initVector, _
                                               RijndaelSimple.keySize)
                imei = strarr(2)
                dt1 = UserDetailsDB.Checkimei(imei)
                If dt1.Rows.Count = 0 Then
                    Return "Device not Registered!!!"
                End If
                dt1 = UserDetailsDB.Status()
                If dt1.Rows(0).Item(0).ToString.Equals("T") Then
                    Return "Login Not Started!!!"
                End If
                dt = UserDetailsDB.GetBuyerOnlineInfo(Trim(userName), Trim(password)) 'spassword
                If dt IsNot Nothing Then
                    If dt.Rows.Count > 0 Then
                        Dim usrid As Integer = dt.Rows(0)("BuyerID").ToString.Trim
                        dtdup = UserDetailsDB.DuplicateUser(usrid)
                        If dtdup.Rows.Count = 0 Then
                            LOG = UserDetailsDB.buyerinsert(usrid, imei)
                            Result = dt.Rows(0)("BuyerName").ToString.Trim + "," + dt.Rows(0)("BuyerID").ToString.Trim + "," + LOG.Rows(0).Item(0).ToString + "," + dt.Rows(0)("BranchCode").ToString + "," + dt.Rows(0)("Company_Name").ToString
                        Else
                            Result = "Already Logged In !!!"
                        End If
                    Else
                        Result = "Enter Correct Details !!!"
                    End If
                Else
                    Result = "Enter Correct Details !!!"
                End If
                Return Result

            Case "ST"
                System.Web.HttpContext.Current.Cache("Status") = "T"

            Case "T"
                Return String.Format("{0:yyyy-MM-dd HH:mm:ss}", System.DateTime.Now)

            Case "L"
                UserDetailsDB.UpdateBuyerlog(DATA)

            Case "S"
                System.Web.HttpContext.Current.Cache("Status") = "S"
                Return "0"

            Case "C"
                If (System.Web.HttpContext.Current.Cache("B") Is Nothing) Then
                    System.Web.HttpContext.Current.Cache("B") = "0"
                    s = "0"
                Else
                    s = System.Web.HttpContext.Current.Cache("B")
                    System.Web.HttpContext.Current.Cache("B") = "0"
                End If
                If s.Equals("0") Then
                    Return "0"
                Else
                    Return System.Web.HttpContext.Current.Cache("IP") + "," + System.Web.HttpContext.Current.Cache("ADATE") + "," + System.Web.HttpContext.Current.Cache("DATA") + "," + s
                End If

            Case "D"
                If (System.Web.HttpContext.Current.Cache("Status") = "S") Then
                    System.Web.HttpContext.Current.Cache("B") = B
                    System.Web.HttpContext.Current.Cache("BID") = BID
                    System.Web.HttpContext.Current.Cache("DATA") = DATA
                    System.Web.HttpContext.Current.Cache("IP") = IP
                    System.Web.HttpContext.Current.Cache("ADATE") = ADATE
                    System.Web.HttpContext.Current.Cache("Status") = "T"
                    Return "S"
                End If
                If (System.Web.HttpContext.Current.Cache("Status") = "T") Then
                    Return "Clock Stop"
                End If
            Case "B"
                If (System.Web.HttpContext.Current.Cache("Status") = "S") Then
                    System.Web.HttpContext.Current.Cache("B") = B
                    System.Web.HttpContext.Current.Cache("BID") = BID
                    System.Web.HttpContext.Current.Cache("DATA") = DATA
                    System.Web.HttpContext.Current.Cache("IP") = IP
                    System.Web.HttpContext.Current.Cache("ADATE") = ADATE
                    System.Web.HttpContext.Current.Cache("Status") = "T"
                    Return "S"
                End If
                If (System.Web.HttpContext.Current.Cache("Status") = "T") Then
                    Return "Clock Stop"
                End If

            Case "G"
                BuyerId = System.Web.HttpContext.Current.Cache("DATA")
                Return BuyerId

            Case "Q"
                If (System.Web.HttpContext.Current.Cache("IP") = IP) Then
                    System.Web.HttpContext.Current.Cache("B") = B
                    System.Web.HttpContext.Current.Cache("BID") = BID
                    System.Web.HttpContext.Current.Cache("IP") = IP
                    System.Web.HttpContext.Current.Cache("ADATE") = ADATE
                    System.Web.HttpContext.Current.Cache("DATA") = DATA
                Else : Return "Y"
                End If

            Case "CQ"
                If (System.Web.HttpContext.Current.Cache("DATA").Equals("0")) Then
                    Return "x"
                Else : Return System.Web.HttpContext.Current.Cache("IP") + "," + System.Web.HttpContext.Current.Cache("ADATE") + "," + System.Web.HttpContext.Current.Cache("DATA") + "," + System.Web.HttpContext.Current.Cache("B")
                End If

            Case "STA"
                dtsta = UserDetailsDB.GetBuyerStatus(BID, DATA)
                If dtsta.Rows.Count > 0 Then
                    Return dtsta.Rows(0)("Data").ToString.Trim + "|" + dtsta.Rows(0)("Amt").ToString.Trim
                End If

            Case "AUC"
                System.Web.HttpContext.Current.Cache("AUC") = Globals._LotNumber
                Globals._LotNumber = "FA"
                If (System.Web.HttpContext.Current.Cache("AUC") Is Nothing) Then
                    Return "FA"
                Else
                    Return System.Web.HttpContext.Current.Cache("AUC")
                End If

            Case "LOG"
                System.Web.HttpContext.Current.Cache("LOG") = DATA
                Return 0

            Case "T"
                Return "Clock Stop"
        End Select
        If (System.Web.HttpContext.Current.Cache("LOG") = "On") Then
            File.AppendAllText(strFile, String.Format(IP + " " + ADATE + " " + B + "   " + DATA + Environment.NewLine, DateTime.Now, Environment.NewLine))
        End If
        Return "0"
    End Function
End Class
