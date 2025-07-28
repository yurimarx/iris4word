Class dc.iris4word.SampleProduction Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="dc.iris4word.SampleProduction" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="WeatherService" Category="" ClassName="dc.iris4word.WeatherService" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="WeatherClassifierProcess" Category="" ClassName="dc.iris4word.WeatherClassifierProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="WeatherOperation" Category="" ClassName="dc.iris4word.WeatherOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
