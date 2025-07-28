Class dc.iris4word.WeatherOperation Extends Ens.BusinessOperation
{

Method OnProcessInput(pInput As ClassifyWeatherResponse, Output pOutput As %Persistent) As %Status
{
        Set tSC = $$$OK
        
        Set tWeatherLog = ##class(dc.iris4word.WeatherLog).%New()
        Set tWeatherLog.Temperature = pInput.Temperature
        Set tWeatherLog.Classification = pInput.Classification
        
        Set tSC = tWeatherLog.%Save()
        If $$$ISERR(tSC) Quit tSC
        
        Set pOutput = tWeatherLog
        
        Quit $$$OK
}

}
