Class dc.iris4word.Iris4WordREST Extends %CSP.REST
{

Parameter Version = "1.0.0";

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<!-- Server Info -->
<Route Url="/" Method="GET" Call="GetInfo" Cors="true"/>
<!-- Swagger specs -->
<Route Url="/_spec" Method="GET" Call="SwaggerSpec" />

<!-- Upload word template -->
<Route Url="/upload-template" Method="POST" Call="UploadTemplate"/>

<!-- Download word document -->
<Route Url="/download-doc/:template" Method="POST" Call="DownloadDoc"/>

<!-- Get Ens production report -->
<Route Url="/ens-report" Method="GET" Call="GetEnsReport"/>

<!-- Get BI report -->
<Route Url="/bi-report" Method="GET" Call="GetBIReport"/>


</Routes>
}

/// API general information
ClassMethod GetInfo() As %Status
{
  SET version = ..#Version
  SET info = {
    "version": (version)
  }
  Write info.%ToJSON()
  Return $$$OK
}

ClassMethod UploadTemplate() As %Status
{
    
    try {
        Set info = {}
        Set source = %request.GetMimeData("file")
        Set destination=##class(%Stream.FileBinary).%New()
        Set destination.Filename="/tmp/"_source.FileName
        set tSC=destination.CopyFrom(source) //reader open the file
        set result=destination.%Save()
        set info.return = result
        set info.message = "File saved "_source.FileName
       
        Set %response.ContentType = ..#CONTENTTYPEJSON
        Set %response.Headers("Access-Control-Allow-Origin")="*"
 
        Write info.%ToJSON()
 
        Set tSC=$$$OK
   
    //returns error message to the user
    } catch e {
        Set tSC=e.AsStatus()
        Set pOutput = tSC
    }
 
    Quit tSC
}

/// Download the word document from a template and body JSON data 
ClassMethod DownloadDoc(template As %String) As %Status
{
    Set tUUID = $System.Util.CreateGUID() 
    Set filePath = "/tmp/"_tUUID_".docx"
    Set jsonContentString = {}.%FromJSON(%request.Content)
    Set sc = ##class(dc.iris4word.WordUtil).GenerateWordFileFromJSON(jsonContentString.%ToJSON(), "/tmp/"_template_".docx", filePath)

    Set %response.NoCharSetConvert=1
    Set %response.Headers("Access-Control-Allow-Origin")="*"
    Do %response.SetHeader("Content-Type","application/vnd.openxmlformats-officedocument.wordprocessingml.document")
    Do %response.SetHeader("Content-Disposition","attachment;filename="""_tUUID_".docx"_"""")
    
    Set stream=##class(%Stream.FileBinary).%New()
    Set sc=stream.LinkToFile(filePath)
    Do stream.OutputToDevice()
    
    Return sc
}

/// Get Interoperability Production report 
ClassMethod GetEnsReport() As %Status
{
    Set tUUID = $System.Util.CreateGUID() 
    Set filePath = "/tmp/"_tUUID_".docx"
    Set jsonContentString = {}.%FromJSON(%request.Content)
    Set sc = ##class(dc.iris4word.EnsUtil).GetEnsDocReport(filePath)

    Set %response.NoCharSetConvert=1
    Set %response.Headers("Access-Control-Allow-Origin")="*"
    Do %response.SetHeader("Content-Type","application/vnd.openxmlformats-officedocument.wordprocessingml.document")
    Do %response.SetHeader("Content-Disposition","attachment;filename="""_tUUID_".docx"_"""")
    
    Set stream=##class(%Stream.FileBinary).%New()
    Set sc=stream.LinkToFile(filePath)
    Do stream.OutputToDevice()
    
    Return sc
}

/// Get BI report 
ClassMethod GetBIReport() As %Status
{
    Set tUUID = $System.Util.CreateGUID() 
    Set filePath = "/tmp/"_tUUID_".docx"
    Set jsonContentString = {}.%FromJSON(%request.Content)
    Set sc = ##class(dc.iris4word.BIUtil).GetBIDocReport(filePath)

    Set %response.NoCharSetConvert=1
    Set %response.Headers("Access-Control-Allow-Origin")="*"
    Do %response.SetHeader("Content-Type","application/vnd.openxmlformats-officedocument.wordprocessingml.document")
    Do %response.SetHeader("Content-Disposition","attachment;filename="""_tUUID_".docx"_"""")
    
    Set stream=##class(%Stream.FileBinary).%New()
    Set sc=stream.LinkToFile(filePath)
    Do stream.OutputToDevice()
    
    Return sc
}

ClassMethod SwaggerSpec() As %Status
{
  Set tSC = ##class(%REST.API).GetWebRESTApplication($NAMESPACE, %request.Application, .swagger)
  Do swagger.info.%Remove("x-ISC_Namespace")
  Set swagger.basePath = "/crud"
  Set swagger.info.title = "IRIS For Word"
  Set swagger.info.version = "1.0.0"
  Set swagger.host = "localhost:52773"
  Write swagger.%ToJSON()
  Return $$$OK
}

}
