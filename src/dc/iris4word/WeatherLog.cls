Class dc.iris4word.WeatherLog Extends %Persistent
{

Property Timestamp As %PosixTime [ InitialExpression = {$ZPOSIXX} ];

Property Temperature As %String;

Property Classification As %String;

Index IdxTimestamp On Timestamp [ Type = bitmap ];

Storage Default
{
<Data name="WeatherLogDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Timestamp</Value>
</Value>
<Value name="3">
<Value>Temperature</Value>
</Value>
<Value name="4">
<Value>Classification</Value>
</Value>
</Data>
<DataLocation>^dc.iris4word.WeatherLogD</DataLocation>
<DefaultData>WeatherLogDefaultData</DefaultData>
<IdLocation>^dc.iris4word.WeatherLogD</IdLocation>
<IndexLocation>^dc.iris4word.WeatherLogI</IndexLocation>
<StreamLocation>^dc.iris4word.WeatherLogS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
