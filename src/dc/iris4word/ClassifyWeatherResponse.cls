Class dc.iris4word.ClassifyWeatherResponse Extends Ens.Response
{

Property Temperature As %String;

Property Classification As %String;

Storage Default
{
<Data name="ClassifyWeatherResponseDefaultData">
<Subscript>"ClassifyWeatherResponse"</Subscript>
<Value name="1">
<Value>Temperature</Value>
</Value>
<Value name="2">
<Value>Classification</Value>
</Value>
</Data>
<DefaultData>ClassifyWeatherResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
