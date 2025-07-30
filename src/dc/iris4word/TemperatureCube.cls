/// Temperature analysis
Class dc.iris4word.TemperatureCube Extends %DeepSee.CubeDefinition [ DependsOn = dc.iris4word.ClassifyWeatherResponse, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="TemperatureCube" displayName="TemperatureCube" description="Temperature analysis" disabled="false" abstract="false" sourceClass="dc.iris4word.ClassifyWeatherResponse" namedFactNums="true" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0" disableListingGroups="false" enableSqlRestrict="false">
  <dimension name="Classification" disabled="false" hasAll="false" allCaption="All Classification" allDisplayName="Classification" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Classification" disabled="false" sourceProperty="Classification" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="2">
      </level>
    </hierarchy>
  </dimension>
  <measure name="Temperature" disabled="false" sourceProperty="Temperature" aggregate="SUM" type="number" hidden="false" searchable="false" factNumber="1">
  </measure>
</cube>
}

ClassMethod EnableIRISBI(ns As %String) As %Status
{
  Set sc = $$$OK
  set ns=$g(ns) 
  if ns="" set ns=$ZNSPACE
  set ns=$$$LOWER(ns)
  do EnableDeepSee^%SYS.cspServer("/csp/"_ns_"/")
  Return sc
}

ClassMethod StopJournalling(db As %String) As %Status
{
  Set sc = $$$OK
  // disable journalling
  set ns=$ZNSPACE
  if $g(db)="" set db=ns
  zn "%SYS"
  set path = ##class(Config.Databases).Open(db).Directory
  set database = ##class(SYS.Database).%OpenId($get(path))
  if $IsObject(database)  {
    do database.DisableJournaling() 
    set sc = database.%Save()
    }
  else { 
    set sc=$$$ERROR($$$GeneralError,"Cannot find database "_db)}
  zn ns
  Return sc
}

Parameter DOMAIN;

}
