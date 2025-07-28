Class dc.iris4word.WeatherService Extends Ens.BusinessService
{

Parameter ADAPTER = "Ens.InboundAdapter";

Parameter SETTINGS = "Latitude,Longitude";

Property Latitude As %String [ InitialExpression = "52.52" ];

Property Longitude As %String [ InitialExpression = "13.41" ];

Method OnProcessInput(pInput As Ens.Request, Output pOutput As ClassifyWeatherResponse) As %Status
{
        Set tSC = $$$OK
        Set tHTTP = ##class(%Net.HttpRequest).%New()
        
        Set tHTTP.Server = "api.open-meteo.com"
        Set tHTTP.Port = 443
        Set tHTTP.Https = 1
        Set tHTTP.SSLConfiguration = "pm.community.intersystems.com"
        
        // Use the parameters from the message for the API call
        Set tURL = "/v1/forecast?latitude="_..Latitude_"&longitude="_..Longitude_"&current_weather=true"
        
        Set tSC = tHTTP.Get(tURL)
        If $$$ISERR(tSC) Quit tSC
        
        Set tJSON = {}.%FromJSON(tHTTP.HttpResponse.Data)
        Set tTemperature = tJSON."current_weather".temperature

        Set pRequest = ##class(dc.iris4word.GetWeatherData).%New()
        Set pRequest.Temperature = tTemperature
        Set pRequest.Latitude = ..Latitude
        Set pRequest.Longitude = ..Longitude
        
        // Call the Business Service to get the temperature
        Set tSC = ..SendRequestSync("WeatherClassifierProcess", pRequest, .tResponse)
        If $$$ISERR(tSC) Quit tSC
        
        Set pOutput = tResponse
        
        Quit $$$OK
}

}
