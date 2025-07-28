Class dc.iris4word.GetWeatherData Extends Ens.Request
{

Property Latitude As %String;

Property Longitude As %String;

Property Temperature As %Double;

Storage Default
{
<Data name="GetWeatherDataDefaultData">
<Subscript>"GetWeatherData"</Subscript>
<Value name="1">
<Value>Latitude</Value>
</Value>
<Value name="2">
<Value>Longitude</Value>
</Value>
<Value name="3">
<Value>Temperature</Value>
</Value>
</Data>
<DefaultData>GetWeatherDataDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
