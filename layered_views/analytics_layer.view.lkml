include: "/base_views/*"

view: +predict_output {

  dimension_group:  flight_date {
    sql: DATE(${year},${month},${dayof_month}) ;;
    type: time
    timeframes: [date,month,quarter,week,year,raw]
    datatype: date
  }

  dimension: pred_isAccurate {
    case: {
      when: {
        sql: ${pred} => 0.5 AND ${delayed} = 1 ;;
        label:"1"}
      when: {
        sql: ${pred} < 0.5 AND ${delayed} = 0 ;;
        label: "1"
      }
      else: "0"

    }
  }

  measure: accurate_prediction_count {
    sql: ${pred_isAccurate} ;;
    filters: [pred_isAccurate: "1"]
    type: count_distinct
  }

  measure: prediction_accuracy {
    sql: ${accurate_prediction_count}/NULLIF(${count},0) ;;
    value_format_name: percent_1
    type: number
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
