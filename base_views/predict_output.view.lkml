view: predict_output {
  sql_table_name: `gartner-dsml-demo-2020.flights.predict_output`
    ;;

  dimension: api_error {
    type: string
    sql: ${TABLE}.api_error ;;
  }

  dimension: crsdep_time {
    type: number
    sql: ${TABLE}.CRSDepTime ;;
  }

  dimension: dayof_month {
    type: number
    sql: ${TABLE}.DayofMonth ;;
  }

  dimension: dayof_week {
    type: number
    sql: ${TABLE}.DayofWeek ;;
  }

  dimension: delayed {
    type: string
    sql: ${TABLE}.delayed ;;
  }

  dimension: dest {
    type: string
    sql: ${TABLE}.Dest ;;
  }

  dimension: dest_fog {
    type: number
    sql: ${TABLE}.dest_fog ;;
  }

  dimension: dest_hail {
    type: number
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
    type: number
    sql: ${TABLE}.dest_snow ;;
  }

  dimension: dest_temp {
    type: number
    sql: ${TABLE}.dest_temp ;;
  }

  dimension: dest_thunder {
    type: number
    sql: ${TABLE}.dest_thunder ;;
  }

  dimension: dest_wdsp {
    type: number
    sql: ${TABLE}.dest_wdsp ;;
  }

  dimension: flight_date {
    type: string
    sql: ${TABLE}.flight_date ;;
  }

  dimension: model {
    type: string
    sql: ${TABLE}.model ;;
  }

  dimension: model_version {
    type: string
    sql: ${TABLE}.model_version ;;
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
    type: number
    sql: ${TABLE}.origin_fog ;;
  }

  dimension: origin_hail {
    type: number
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
    type: number
    sql: ${TABLE}.origin_snow ;;
  }

  dimension: origin_temp {
    type: number
    sql: ${TABLE}.origin_temp ;;
  }

  dimension: origin_thunder {
    type: number
    sql: ${TABLE}.origin_thunder ;;
  }

  dimension: origin_wdsp {
    type: number
    sql: ${TABLE}.origin_wdsp ;;
  }

  dimension: pred {
    type: number
    sql: ${TABLE}.pred ;;
  }

  dimension_group: pred_ts {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.pred_ts ;;
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
