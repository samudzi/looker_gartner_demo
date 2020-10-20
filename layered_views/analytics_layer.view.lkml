include: "/base_views/*"

view: +prototype_tf_train {

  dimension_group:  flight_date {
    sql: DATE(${year},${month},${dayof_month}) ;;
    type: time
    timeframes: [date,month,quarter,week,year,raw]
    datatype: date
    }

  dimension: origin_coordinates {
    type: location
    sql_latitude: ${airport_data_origin.lat} ;;
    sql_longitude: ${airport_data_origin.lon} ;;
  }

  dimension: destination_coordinates {
    type: location
    sql_latitude: ${airport_data_dest.lat} ;;
    sql_longitude: ${airport_data_dest.lon} ;;
  }

  measure: count_delayed {
    sql: ${delayed} ;;
    type: sum
    filters: [delayed: "1"]
  }

  measure: total_flight_volume {
    type: count
  }


  measure: percent_delayed {
    sql: ${count_delayed}/NULLIF(${count},0) ;;
    value_format_name: percent_1
    type: number
  }

  measure: average_origin_temp_in_F {
    type: average
    sql: ${origin_temp} ;;
    value_format_name: decimal_1
  }

  measure: average_dest_temp_in_F {
    type: average
    sql: ${dest_temp} ;;
    value_format_name: decimal_1
  }

  measure: average_origin_precipitation_inches {
    type: average
    sql: ${origin_prcp} ;;
    value_format_name: decimal_1
  }

  measure: average_dest_precipitation_inches {
    type: average
    sql: ${dest_prcp} ;;
    value_format_name: decimal_1
  }

  dimension: departure_time_window {
    type: tier
    tiers: [0,800,1200,1600,2000]
    style: relational
    sql: ${crsdep_time} ;;
  }

 measure: count_origin_snow {
  sql: ${origin_snow} ;;
  type: sum
  filters: [origin_snow: "1"]
 }

 measure: count_origin_precipitation {
  sql: ${origin_prcp} ;;
  type: sum
  filters: [origin_prcp: "1"]
 }

measure: count_origin_thunderstorm {
  sql: ${origin_thunder} ;;
  type: sum
  filters: [origin_thunder: "1"]
}

measure: average_origin_windspeed {
  sql: ${origin_wdsp} ;;
  type: average
}

measure: average_origin_max_windspeed {
  sql: ${origin_max_wdsp} ;;
  type: average
}

measure: average_origin_windspeed_diff {
  sql: ${average_origin_max_windspeed} - ${average_origin_windspeed} ;;
  type: number
  value_format_name: decimal_1
}

  measure: count_origin_fog {
    sql: ${origin_fog} ;;
    type: sum
    filters: [origin_fog: "1"]
  }

  measure: count_origin_hail {
    sql: ${origin_hail} ;;
    type: sum
    filters: [origin_hail: "1"]
  }


  measure: count_destination_snow {
    sql: ${dest_snow} ;;
    type: sum
    filters: [dest_snow: "1"]
  }

  measure: count_destination_precipitation {
    sql: ${dest_prcp} ;;
    type: sum
    filters: [dest_prcp: "1"]
  }

  measure: count_destination_thunderstorm {
    sql: ${dest_thunder} ;;
    type: sum
    filters: [dest_thunder: "1"]
  }

  measure: average_destination_windspeed {
    sql: ${dest_wdsp} ;;
    type: average
  }

  measure: average_destination_max_windspeed {
    sql: ${dest_max_wdsp} ;;
    type: average
  }

  measure: average_destination_windspeed_diff {
    sql: ${average_destination_max_windspeed} - ${average_destination_windspeed} ;;
    type: number
    value_format_name: decimal_1
  }

  measure: count_destination_fog {
    sql: ${dest_fog} ;;
    type: sum
    filters: [dest_fog: "1"]
  }

  measure: count_dest_hail {
    sql: ${dest_hail} ;;
    type: sum
    filters: [dest_hail: "1"]
  }


}




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
        sql: ${pred} >= 0.5 AND ${delayed} = "1" ;;
        label:"1"}
      when: {
        sql: ${pred} < 0.5 AND ${delayed} = "0" ;;
        label: "1"
      }
      else: "0"

    }
  }

  dimension: origin_coordinates {
    type: location
    sql_latitude: ${airport_data_origin.lat} ;;
    sql_longitude: ${airport_data_origin.lon} ;;
  }

  dimension: destination_coordinates {
    type: location
    sql_latitude: ${airport_data_origin.lat} ;;
    sql_longitude: ${airport_data_origin.lon} ;;
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
    sql: count(${delayed}) where ${delayed} = 1 ;;
    type: number
  }

  measure: nondelayed_count {
    sql: count(${delayed}) where ${delayed} = 0 ;;
    type: number
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
