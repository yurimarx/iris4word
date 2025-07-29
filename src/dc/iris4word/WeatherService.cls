Class dc.iris4word.WeatherService Extends Ens.BusinessService
{

Parameter ADAPTER = "Ens.InboundAdapter";

Parameter SETTINGS = "Latitude,Longitude";

Property Latitude As %String [ InitialExpression = "52.52" ];

Property Longitude As %String [ InitialExpression = "13.41" ];

Method OnProcessInput(pInput As Ens.Request, Output pOutput As ClassifyWeatherResponse) As %Status
{
        Set TemperatureData = ..GetTemperatureData(..Latitude, ..Longitude)
        
        Set tJSON = {}.%FromJSON(TemperatureData)
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

/// Get temperature data
ClassMethod GetTemperatureData(latitude As %String, longitude As %String) As %String [ Language = python ]
{
        import urllib.request
        import json
        
        base_url = "https://api.open-meteo.com/v1/forecast"
        params = f"?latitude={latitude}&longitude={longitude}&current_weather=true"
        url = base_url + params

        try:
                with urllib.request.urlopen(url) as response:
                        data = response.read().decode('utf-8')
                        json_data = json.loads(data)
                        return data
            
        except urllib.error.URLError as e:
                return json.dumps({"error": f"Error while connecting the API Open-Meteo: {e.reason}"}, ensure_ascii=False, indent=4)
        except json.JSONDecodeError:
                return json.dumps({"error": "Invalid JSON"}, ensure_ascii=False, indent=4)
        except Exception as e:
                return json.dumps({"error": f"Unexpected error: {str(e)}"}, ensure_ascii=False, indent=4)
}

}
