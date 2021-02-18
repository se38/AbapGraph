CLASS zcl_abap_graph DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.

    TYPES: BEGIN OF ty_route,
             ConnectionKey TYPE zabap_graph_spfli_edge-ConnectionKey,
             AirportFrom   TYPE zabap_graph_spfli_edge-AirportFrom,
             Airportto     TYPE zabap_graph_spfli_edge-Airportto,
           END OF ty_route.

    TYPES: tt_routes TYPE STANDARD TABLE OF ty_route WITH EMPTY KEY.

    CLASS-METHODS connection_graph
        FOR DDL OBJECT
        OPTIONS CDS SESSION CLIENT REQUIRED.

    CLASS-METHODS get_shortest_path
      AMDP OPTIONS CDS SESSION CLIENT current
      IMPORTING VALUE(i_airport_from) TYPE zabap_graph_spfli_edge-AirportFrom
                VALUE(i_airport_to)   TYPE zabap_graph_spfli_edge-AirportTo
      EXPORTING VALUE(e_routes)       TYPE tt_routes
      RAISING   cx_amdp_execution_error.

ENDCLASS.



CLASS zcl_abap_graph IMPLEMENTATION.

  METHOD connection_graph
    BY DATABASE GRAPH WORKSPACE FOR HDB LANGUAGE SQL
    USING zabap_graph_spfli_edge zabap_graph_airport_vertex.

    edge table zabap_graph_spfli_edge
      source column AirportFrom
      target column AirportTo
      key column ConnectionKey
    vertex table zabap_graph_airport_vertex
      key column AirportId;

  endmethod.

  METHOD get_shortest_path
    BY DATABASE PROCEDURE FOR HDB LANGUAGE GRAPH
    OPTIONS READ-ONLY
    USING zcl_abap_graph=>connection_graph.

    Graph g = Graph ( "ZCL_ABAP_GRAPH=>CONNECTION_GRAPH" );

    Vertex v_from = Vertex (:g, :i_airport_from);
    Vertex v_to   = Vertex (:g, :i_airport_to);

    WeightedPath<BigInt> p_path = Shortest_Path ( :g, :v_from, :v_to );

    e_routes = select :part.ConnectionKey, :part.AirportFrom, :part.AirportTo
                 foreach part in edges( :p_path );

  ENDMETHOD.

ENDCLASS.
