include: "/base_views/*"

view: +predict_output {

  dimension_group:  flight_date {
    sql: DATE(${year},${month},${dayof_month}) ;;
    type: time
    timeframes: [date,month,quarter,week,year,raw]
    datatype: date
  }






}
