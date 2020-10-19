connection: "bigquery-gartner-demo"

include: "/layered_views/*.view.lkml"                # include all views in the views/ folder in this project

explore: predict_output {
  group_label: "Looker Gartner Demo"
  view_label: "Flight Prediction Output"

  join: airport_data_origin {
    from: airport_data
    relationship: many_to_one
    type: inner
    sql_on: ${airport_data_origin.iata_code} = ${predict_output.origin} ;;
  }

  join: airport_data_dest {
    from: airport_data
    relationship: many_to_one
    type: inner
    sql_on: ${airport_data_origin.iata_code} = ${predict_output.dest} ;;
  }
}


explore: flight_analytics {
  view_name: prototype_tf_train
  group_label: "Looker Gartner Demo"
  view_label: "Flight Analytics"

  join: airport_data_origin {
    from: airport_data
    relationship: many_to_one
    type: inner
    sql_on: ${airport_data_origin.iata_code} = ${prototype_tf_train.origin} ;;
  }

  join: airport_data_dest {
    from: airport_data
    relationship: many_to_one
    type: inner
    sql_on: ${airport_data_origin.iata_code} = ${prototype_tf_train.dest} ;;
  }
}
