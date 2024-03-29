<%@ Application Language="VB" %>

<script runat="server">   

    Public Shared rowpos1 As Integer
    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application startup   

        'Application("Strcontent") = ConfigurationManager.ConnectionStrings("Sahaj_Edu").ConnectionString
        'Application("GlbProviderName") = ConfigurationManager.ConnectionStrings("Sahaj_Edu").ProviderName

    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
        For Each de As DictionaryEntry In HttpContext.Current.Cache
            HttpContext.Current.Cache.Remove(DirectCast(de.Key, String))
        Next
        'Begin Edit by Kusum
        Dim i As Int16 = UserDetailsDB.UpdateUserlog() 'Reset user session
        GlobalFunction.logid = Nothing 'Nullify global variable - LogID
        HttpContext.Current.Session.Abandon()
        'End Edit by Kusum
    End Sub
    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        'Begin comment by Kusum. 19-05-2012
        'Dim exc As Exception = Server.GetLastError
        'try
        'If (exc.GetType Is GetType(HttpException)) Then
        'Else
        '    Session("ErrorMsg") = Server.GetLastError.ToString()
        'End If
        'catch
        'end try 
        'End comment by Kusum

        Dim exc As Exception = Server.GetLastError
        try
            If (exc.GetType Is GetType(HttpException)) Then
            Else
                Session("ErrorMsg") = Server.GetLastError.ToString()
            End If
        catch
        End Try
        'Begin Edit by Kusum
        Dim i As Int16 = UserDetailsDB.UpdateUserlog() 'Reset user session
        GlobalFunction.logid = Nothing 'Nullify global variable - LogID
        'End Edit by Kusum
    End Sub
    'Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
    '    ' Code that runs when an unhandled error occurs
    '    ' Get the exception object.
    '    dim str as String =""
    '    Dim exc As Exception = Server.GetLastError

    '    ' Handle HTTP errors (avoid trapping HttpUnhandledException
    '    ' which is generated when a non-HTTP exception 
    '    ' such as the ones generated by buttons 1-3 in 
    '    ' Default.aspx is not handled at the page level).
    '    If (exc.GetType Is GetType(HttpException)) Then
    '        ' The Complete Error Handling Example generates
    '        ' some errors using URLs with "NoCatch" in them;
    '        ' ignore these here to simulate what would happen
    '        ' if a global.asax handler were not implemented.
    '        If exc.Message.Contains("NoCatch") Then
    '            Return
    '        End If

    '        'Redizxect HTTP errors to HttpError page
    '        'Response.Redirect("../Error/frmError.aspx")
    '    End If
    '    Try
    '        str = exc.InnerException.ToString
    '    Catch
    '    End Try
    '    ' For other kinds of errors give the user some information
    '    ' but stay on the default page
    '    Response.Write("<h2>Global Page Error</h2>" & vbLf)
    '    Response.Write("<p>" & exc.Message.ToString  & vbLf & exc.TargetSite.ToString & vbLf & exc.StackTrace.ToString  & vbLf & str & "</p>" & vbLf)
    '    Response.Write(("Return to the <a href='Default.aspx'>" _
    '      & "Default Page</a>" & vbLf))

    '    ' Log the exception and notify system operators
    '    ExceptionUtility.LogException(exc, "DefaultPage")
    '    ExceptionUtility.NotifySystemOps(exc)

    '    ' Clear the error from the server
    '    Server.ClearError()
    'End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)

        ' Code that runs when a new session is started 
        If Session.IsNewSession Then
            Dim EMPID As Long = 0
            Dim sesbranch As Long = 0
            Dim sesInstitute As Long = 0
            Dim sesDepartment As Long = 0
            Dim sesCourse As Long = 0
            Dim sesStartDate As String = String.Empty
            Dim sesEndDate As String = String.Empty
            'Session("editstatus") = ""
            'Session("editid") = 0
            'Session("AssetDet_Id") = 0
            'Session("ParentGridViewIndex") = 0
            'Session("Book_ID") = 0
            'Session("ErrorMsg") = ""
            'Session("ErrorPageLink") = ""
            Dim sesThemeName As String = String.Empty
            'Session.Add("Admin", 0)
            'Session.Add("HOID", 0)
            'Session.Add("sesHOID", 0)
            'Session.Add("sesThemeName", "MSN_Blue")
            'Session.Add("sesbranch", 0)
            'Session.Add("sesInstitute", 0)
            'Session.Add("sesDepartment", 0)
            'Session.Add("sesCourse", 0)
            'Session.Add("sesSubject", 0)
            'Session.Add("SesStartDate", "")
            'Session.Add("SesEndDate", "")
            'Session.Add("sesCategory", 0)
            'Session.Add("sesCourseType", 0)
            'Session("RecoverForm") = "" ' Variable to hold the form name to recover
            'Session("Gstatus") = ""     ' Variable defineing the status of Button Event 
            'Session("PreRpt") = ""      ' Boolean Value True to display the report
            'Session.Add("editstr", "ADD")
            'Session.Add("EMPID", 0)
            'Session("USER") = ""
            'Session("sesLoginBranch") = ""
            'Session("sesLoginInstitute") = ""
            'Session("Access_Per_Frm") = ""
            'Session("UserRole") = ""

            ' initialize Financial Start Date and Financial End Date
            Dim ConL As New ConfigurationB
            Dim ConEL As New EntConfiguration

            'Commented by Nethra during Build March-30-2012

            ConEL = ConL.GetConfigId(11)
            Session.Add("FinStartDate", ConEL.config_value) ' Financial Year Start Date
            ConEL = ConL.GetConfigId(12)
            Session.Add("FinEndDate", ConEL.config_value)   ' Financial Year End Date 
            ConEL = ConL.GetConfigId(34)
            Session.Add("TestUser", ConEL.config_value)   ' Test User
            ConEL = ConL.GetConfigId(50)
            Session.Add("Path", ConEL.config_value)
            ConEL = ConL.GetConfigId(57)
            Session.Add("Theme", ConEL.config_value)   ' Random Theme
            ConEL = ConL.GetConfigId(59)
            Session.Add("EmailID", ConEL.config_value)   ' Email ID
            ConEL = ConL.GetConfigId(60)
            Session.Add("Password", ConEL.config_value)   ' Password
            ConEL = ConL.GetConfigId(61)
            Session.Add("SMTP", ConEL.config_value)   ' SMTP
            ConEL = ConL.GetConfigId(62)
            Session.Add("Port", ConEL.config_value)   ' Port

            ConEL = ConL.GetConfigId(76)
            Session.Add("CurrentYear", ConEL.config_value)   ' Current Year

            'Commented by Nethra during Build March-30-2012


            'Session.Add("RptFrmTitleName", "") ' Financial Report Identification
            'Session.Add("FrmParentName", "") 'TO get Parent name

            'Session("BranchID") = ""
            'Session("InstituteID") = ""
            'Session("UserName") = ""
            'Session("UserID") = ""
            'Session("BranchName") = "ALL"
            'Session("InstituteName") = "ALL"
            'Session("NewBranchID") = ""
            'Session("sesPartyType") = ""
            'Session.Add("sesPartyId", 0)
        End If

    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        'Session.Add("EMPID", 0)
        'Session("USER") = ""
        'Session("sesLoginBranch") = ""
        'Session("sesLoginInstitute") = ""
        'Session("Access_Per_Frm") = ""
        'Session("UserRole") = ""

        'Session("BranchID") = ""
        'Session("InstituteID") = ""
        'Session("UserName") = ""
        'Session("BranchName") = ""
        'Session("InstituteName") = ""
        'Session("UserID") = ""
        'Session("sesPartyType") = ""
        'Session("sesPartyId") = ""
        'Begin Edit by Kusum
        Dim i As Int16 = UserDetailsDB.UpdateUserlog() 'Reset user session
        GlobalFunction.logid = Nothing 'Nullify global variable - LogID
        'FormsAuthentication.SignOut()

        Roles.DeleteCookie()
        Session.Abandon()
        'End Edit by Kusum
        ' Code that runs when a session ends. 
        ' Note: The Session_End event is raised only when the sessionstate mode
        ' is set to InProc in the Web.config file. If session mode is set to StateServer 
        ' or SQLServer, the event is not raised.
    End Sub
    'End Sub
    'Protected Sub Application_AuthorizeRequest(ByVal sender As Object, ByVal e As System.EventArgs)
    '    If (Me.Request.Path.ToUpper().EndsWith("LOGIN.ASPX") And Me.Request.IsAuthenticated) Then
    '        Me.Response.Redirect("AccessDenied.aspx")
    '    End If
    'End Sub

    Protected Sub Application_PreRequestHandlerExecute(ByVal sender As Object, ByVal e As System.EventArgs)
        'Session("ErrorMsg") = ""
        '           Session("ErrorPageLink") = ""
    End Sub
</script>