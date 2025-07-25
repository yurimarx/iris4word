Class dc.iris4word.WordUtil Extends %RegisteredObject
{

ClassMethod GenerateWordFile(jsonFileName As %String, wordTemplateFileName As %String, wordFileName As %String) As %Status
{
    Set tSC = $$$OK

    Try {
        
        set javaGate = $system.external.getJavaGateway()  
        do javaGate.addToPath($SYSTEM.Util.BinaryDirectory()_"iris4word-1.0.0-jar-with-dependencies.jar")
        set wordUtil = javaGate.new("iris4word.WordUtil") 
        
        do wordUtil.createFromFile(jsonFileName, wordTemplateFileName, wordFileName)
        
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }

    return tSC
}

ClassMethod GenerateWordFileFromJSON(jsonContent As %String, wordTemplateFileName As %String, wordFileName As %String) As %Status
{
    Set tSC = $$$OK

    Try {
        
        set javaGate = $system.external.getJavaGateway()  
        do javaGate.addToPath($SYSTEM.Util.BinaryDirectory()_"iris4word-1.0.0-jar-with-dependencies.jar")
        set wordUtil = javaGate.new("iris4word.WordUtil")

        Set tUUID = $System.Util.CreateGUID() 
        Set jsonFilePath = "/tmp/"_tUUID_".json"
        set tSC = ..SaveStringAsJSON(jsonContent, jsonFilePath)
        
        do wordUtil.createFromFile(jsonFilePath, wordTemplateFileName, wordFileName)
        
    }
    Catch ex {
        Set tSC=ex.AsStatus()
    }

    return tSC
}

ClassMethod SaveStringAsJSON(pJsonString As %String, pFilePath As %String) As %Status
{
    Set sc = $$$OK
    Set tFile = ##class(%Stream.FileCharacter).%New()
    Set sc = tFile.LinkToFile(pFilePath)
    
    Try {
        
        Set sc = tFile.Write(pJsonString)
        Set sc = tFile.%Save()
        If $$$ISERR(sc) {
            Set tFile = ""
            Return sc
        }
    
        Set tFile = ""

    } Catch tException {
        set tFile = ""
        Set sc = tException.AsStatus()
    }

    Return sc
}

}
