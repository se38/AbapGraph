*&---------------------------------------------------------------------*
*& Report zabap_graph_shortest
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_graph_shortest.

CLASS app DEFINITION CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS main.

ENDCLASS.

NEW app( )->main( ).

CLASS app IMPLEMENTATION.

  METHOD main.

    TRY.
        zcl_abap_graph=>get_shortest_path(
          EXPORTING
            i_airport_from = 'FRA'
            i_airport_to   = 'SIN'
          IMPORTING
            e_routes = DATA(routes)
        ).

        cl_demo_output=>display( routes ).

      CATCH cx_amdp_execution_error INTO DATA(lcx).
        cl_demo_output=>display( lcx->get_text( ) ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
