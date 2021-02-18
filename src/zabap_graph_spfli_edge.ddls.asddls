@AbapCatalog.sqlViewName: 'ZSPFLIEDGE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Edge view for SPFLI (combined key)'
define view zabap_graph_spfli_edge
  as select from spfli
{
  key concat(carrid, connid) as ConnectionKey,
      carrid                 as Carrid,
      connid                 as Connid,
      countryfr              as Countryfr,
      cityfrom               as Cityfrom,
      airpfrom               as AirportFrom,
      countryto              as Countryto,
      cityto                 as Cityto,
      airpto                 as AirportTo,
      fltime                 as Fltime,
      deptime                as Deptime,
      arrtime                as Arrtime,
      distance               as Distance,
      distid                 as Distid,
      fltype                 as Fltype,
      period                 as Period
}
where
  mandt = $session.client
