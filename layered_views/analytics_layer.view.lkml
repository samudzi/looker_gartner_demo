include: "/base_views/*"

view: +predict_output {

  dimension_group:  flight_date {
    sql: DATE(${year},${month},${dayof_month}) ;;
    type: time
    timeframes: [date,month,quarter,week,year,raw]
    datatype: date
  }

  measure: delayed_count {
    sql: ${delayed} ;;
    type: count_distinct
    filters: [delayed: "1"]
  }

  measure: nondelayed_count {
    sql: ${delayed} ;;
    type: count_distinct
    filters: [delayed: "0"]
  }

  measure:  percent_delayed {
    sql: ${delayed_count}/NULLIF((${delayed_count}+${nondelayed_count}),0) ;;
    type: number
    value_format_name: percent_1
  }

  measure: average_delay_probability {
    sql: ${pred} ;;
    type: average
  }






}
