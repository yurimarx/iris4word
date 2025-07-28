Class dc.iris4word.EnsUtil Extends %RegisteredObject
{

/// Get word report about an interoperability production
ClassMethod GetEnsDocReport(wordDocumentPath As %String) As %Status
{
    #include Ensemble

    Set response = {}

    Set tSC=##class(Ens.Director).GetProductionStatus(.pProductionName,.tState)
    Set response.Name = pProductionName
    Set response.State = tState
    
    Set tProduction = ##class(Ens.Config.Production).%OpenId(pProductionName, .tSC)
    
    If tProduction.Description '= "" {
        Set response.Description = tProduction.Description
    }
    
    Set response.BusinessHosts = []
    Set i = 0
    For i=1:1:tProduction.Items.Count() {
        Set responseItem = {}
        Set tItem = tProduction.Items.GetAt(i)
        Set responseItem.Name = tItem.Name
        If tItem.Category '= "" {
            Set responseItem.Category = tItem.Category 
        }
        If tItem.ClassName '= "" {
            Set responseItem.ClassName = tItem.ClassName 
        }
        do response.BusinessHosts.%Push(responseItem)
    }

    Set templatePath = $SYSTEM.Util.InstallDirectory()_"enstemplate.docx"
    Set sc = ##class(dc.iris4word.WordUtil).GenerateWordFileFromJSON(response.%ToJSON(), templatePath, wordDocumentPath)
    
    Return sc
}

}
