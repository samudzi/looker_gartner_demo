view: airport_data {
  sql_table_name: `gartner-dsml-demo-2020.flights.airport_data`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: airport_full_name {
    type: string
    sql: ${TABLE}.airport_full_name ;;
  }

  dimension: altitude {
    type: number
    sql: ${TABLE}.altitude ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: database_tz {
    type: string
    sql: ${TABLE}.database_tz ;;
  }

  dimension: dst {
    type: string
    sql: ${TABLE}.dst ;;
  }

  dimension: iata_code {
    type: string
    sql: ${TABLE}.iata_code ;;
  }

  dimension: icao_code {
    type: string
    sql: ${TABLE}.icao_code ;;
  }

  dimension: lat {
    type: number
    sql: ${TABLE}.lat ;;
  }

  dimension: lon {
    type: number
    sql: ${TABLE}.lon ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: tz {
    type: string
    sql: ${TABLE}.tz ;;
  }

  measure: count {
    type: count
    drill_fields: [id, airport_full_name]
  }
}
