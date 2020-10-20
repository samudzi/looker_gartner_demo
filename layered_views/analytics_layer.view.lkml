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
    sql: CAST(${delayed} AS NUMERIC) ;;
    type: sum
    filters: [delayed: "1"]
  }

  measure: percent_delayed {
    sql: ${count_delayed}/NULLIF(${count},0) ;;
    value_format_name: percent_1
    type: number
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
    tiers: [800,1200,1600,2000]
    style: relational
    sql: ${crsdep_time} ;;
  }

  measure: count_origin_snow {
    sql: cast(${origin_snow} as numeric) ;;
    type: sum
    filters: [origin_snow: "1"]
  }

  measure: percent_origin_snow {
    sql: ${count_origin_snow}/NULLIF(${count},0) ;;
    value_format_name: percent_1
    type: number
  }


  measure: count_origin_thunderstorm {
    sql: cast(${origin_thunder} as numeric) ;;
    type: sum
    filters: [origin_thunder: "1"]
  }

  measure: percent_origin_thunderstorm {
    sql: ${count_origin_thunderstorm}/NULLIF(${count},0) ;;
    value_format_name: percent_1
    type: number
  }

  measure: average_origin_windspeed {
    sql: ${origin_wdsp} ;;
    type: average
    value_format_name: decimal_1
  }

  measure: average_origin_max_windspeed {
    sql: ${origin_max_wdsp} ;;
    type: average
    value_format_name: decimal_1
  }

  measure: average_origin_windspeed_diff {
    sql: ${average_origin_max_windspeed} - ${average_origin_windspeed} ;;
    type: number
    value_format_name: decimal_1
  }

  measure: count_origin_fog {
    sql: cast(${origin_fog} as numeric) ;;
    type: sum
    filters: [origin_fog: "1"]
  }

  measure: percent_origin_fog {
    sql: ${count_origin_fog}/NULLIF(${count},0) ;;
    value_format_name: percent_1
    type: number
  }

  measure: count_origin_hail {
    sql: cast(${origin_hail} as numeric) ;;
    type: sum
    filters: [origin_hail: "1"]
  }

  measure: percent_origin_hail {
    sql: ${count_origin_hail}/NULLIF(${count},0) ;;
    value_format_name: percent_1
    type: number
  }


  measure: count_destination_snow {
    sql: cast(${dest_snow} as numeric) ;;
    type: sum
    filters: [dest_snow: "1"]
  }

  measure: percent_dest_snow {
    sql: ${count_destination_snow}/NULLIF(${count},0) ;;
    value_format_name: percent_1
    type: number
  }

  measure: count_destination_thunderstorm {
    sql: cast(${dest_thunder} as numeric) ;;
    type: sum
    filters: [dest_thunder: "1"]
  }

  measure: percent_dest_thunderstorm {
    sql: ${count_destination_thunderstorm}/NULLIF(${count},0) ;;
    value_format_name: percent_1
    type: number
  }

  measure: average_destination_windspeed {
    sql: ${dest_wdsp} ;;
    type: average
    value_format_name: decimal_1
  }

  measure: average_destination_max_windspeed {
    sql: ${dest_max_wdsp} ;;
    type: average
    value_format_name: decimal_1
  }

  measure: average_destination_windspeed_diff {
    sql: ${average_destination_max_windspeed} - ${average_destination_windspeed} ;;
    type: number
    value_format_name: decimal_1
  }

  measure: count_destination_fog {
    sql: cast(${dest_fog} as numeric) ;;
    type: sum
    filters: [dest_fog: "1"]
  }

  measure: percent_dest_fog {
    sql: ${count_destination_fog}/NULLIF(${count},0) ;;
    value_format_name: percent_1
    type: number
  }

  measure: count_dest_hail {
    sql: cast(${dest_hail} as numeric) ;;
    type: sum
    filters: [dest_hail: "1"]
  }

  measure: percent_dest_hail {
    sql: ${count_dest_hail}/NULLIF(${count},0) ;;
    value_format_name: percent_1
    type: number
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
    sql: cast(${pred_isAccurate} as numeric) ;;
    filters: [pred_isAccurate: "1"]
    type: sum
  }

  measure: prediction_accuracy {
    sql: ${accurate_prediction_count}/NULLIF(${count},0) ;;
    value_format_name: percent_1
    type: number
  }

  measure: delayed_count {
    sql: cast(${delayed} as numeric);;
    filters: [delayed: "1"]
    type: sum
  }

  measure: nondelayed_count {
    sql: cast(${delayed} as numeric) ;;
    filters: [delayed: "0"]
    type: sum
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
