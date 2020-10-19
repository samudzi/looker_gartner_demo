view: prototype_tf_train {
  sql_table_name: `gartner-dsml-demo-2020.flights.prototype_tf_train`
    ;;

  dimension: crsdep_time {
    type: number
    sql: ${TABLE}.CRSDepTime ;;
  }

  dimension: day_of_week {
    type: number
    sql: ${TABLE}.DayOfWeek ;;
  }

  dimension: dayof_month {
    type: number
    sql: ${TABLE}.DayofMonth ;;
  }

  dimension: delayed {
    type: number
    sql: ${TABLE}.delayed ;;
  }

  dimension: dest {
    type: string
    sql: ${TABLE}.Dest ;;
  }

  dimension: dest_fog {
    type: string
    sql: ${TABLE}.dest_fog ;;
  }

  dimension: dest_hail {
    type: string
    sql: ${TABLE}.dest_hail ;;
  }

  dimension: dest_max_wdsp {
    type: number
    sql: ${TABLE}.dest_max_wdsp ;;
  }

  dimension: dest_prcp {
    type: number
    sql: ${TABLE}.dest_prcp ;;
  }

  dimension: dest_snow {
    type: string
    sql: ${TABLE}.dest_snow ;;
  }

  dimension: dest_temp {
    type: number
    sql: ${TABLE}.dest_temp ;;
  }

  dimension: dest_thunder {
    type: string
    sql: ${TABLE}.dest_thunder ;;
  }

  dimension: dest_wdsp {
    type: number
    sql: ${TABLE}.dest_wdsp ;;
  }

  dimension: month {
    type: number
    sql: ${TABLE}.Month ;;
  }

  dimension: origin {
    type: string
    sql: ${TABLE}.Origin ;;
  }

  dimension: origin_fog {
    type: string
    sql: ${TABLE}.origin_fog ;;
  }

  dimension: origin_hail {
    type: string
    sql: ${TABLE}.origin_hail ;;
  }

  dimension: origin_max_wdsp {
    type: number
    sql: ${TABLE}.origin_max_wdsp ;;
  }

  dimension: origin_prcp {
    type: number
    sql: ${TABLE}.origin_prcp ;;
  }

  dimension: origin_snow {
    type: string
    sql: ${TABLE}.origin_snow ;;
  }

  dimension: origin_temp {
    type: number
    sql: ${TABLE}.origin_temp ;;
  }

  dimension: origin_thunder {
    type: string
    sql: ${TABLE}.origin_thunder ;;
  }

  dimension: origin_wdsp {
    type: number
    sql: ${TABLE}.origin_wdsp ;;
  }

  dimension: unique_carrier {
    type: string
    sql: ${TABLE}.UniqueCarrier ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.Year ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
