@AbapCatalog.sqlViewName: 'ZAIRPVERTEX'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Vertex view for SAIRPORT'
define view zabap_graph_airport_vertex
  as select from sairport
{
  key id   as AirportId,
      name as Name
}
