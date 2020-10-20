view: const_eval {
  sql_table_name: `gartner-dsml-demo-2020.flights.const_eval`
    ;;

  dimension: avg_acc {
    type: number
    sql: ${TABLE}.avg_acc ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
