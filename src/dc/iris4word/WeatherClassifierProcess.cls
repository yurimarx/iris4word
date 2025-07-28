Class dc.iris4word.WeatherClassifierProcess Extends Ens.BusinessProcess
{

Parameter SETTINGS = "Threshold";

Property Threshold As %Double [ InitialExpression = "25.0" ];

Method OnRequest(pRequest As dc.iris4word.GetWeatherData, Output pResponse As ClassifyWeatherResponse) As %Status
{
        Set tSC = $$$OK
        
        Set pResponse = ##class(dc.iris4word.ClassifyWeatherResponse).%New()

        // Classify the temperature
        If pRequest.Temperature > ..Threshold {
            Set pResponse.Classification = "High"
        } Else {
            Set pResponse.Classification = "Low"
        }
        
        Set pResponse.Temperature = pRequest.Temperature
        
        // Send the complete response to the Business Operation
        //Set tSC = ..SendRequestAsync("WeatherOperation", pResponse)
        
        Quit tSC
}

Storage Default
{
<Data name="WeatherClassifierDefaultData">
<Subscript>"WeatherClassifier"</Subscript>
<Value name="1">
<Value>Threshold</Value>
</Value>
</Data>
<DefaultData>WeatherClassifierDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
