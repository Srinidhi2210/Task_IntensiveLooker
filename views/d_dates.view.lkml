view: d_dates {
  sql_table_name: "DATA_MART"."D_DATES"
    ;;


  dimension: datekey {
    type: number
    primary_key: yes
    sql: ${TABLE}."DATEKEY" ;;
  }


  dimension_group: date_val {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."DATE_VAL" ;;
  }

  dimension_group: date_of {
    type: time
    timeframes: [
      day_of_week,
      day_of_month,
      day_of_year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."DATE_VAL" ;;
  }


  dimension: day_of_week {
    type: number
    sql: ${TABLE}."DAY_OF_WEEK" ;;
  }

  dimension: dayname_of_week {
    type: string
    sql: ${TABLE}."DAYNAME_OF_WEEK" ;;
  }

  dimension: month_name {
    type: string
    sql: ${TABLE}."MONTH_NAME" ;;
  }

  dimension: month_num {
    type: number
    sql: ${TABLE}."MONTH_NUM" ;;
  }

  dimension: quarter {
    type: number
    sql: ${TABLE}."QUARTER" ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}."YEAR" ;;
  }

  measure: count {
    type: count
    drill_fields: [month_name]
  }

  dimension: date_value {
    datatype: date
    sql: ${TABLE}."DATE_VAL" ;;
  }

  parameter: year_quarter_month_test {
    description:"Choose needed date parameter"
    type: unquoted
    allowed_value: {
      label:"Month"
      value: "Month"
    }
    allowed_value: {
      label:"Quarter"
      value:"QUARTER"
    }
    allowed_value: {
      label:"Year"
      value:"YEAR"
    }
  }

  dimension: dynamic_date_filter {
    description: "Please choose needed Date Format"
    type: number
    label_from_parameter: year_quarter_month_test
    sql: {% parameter year_quarter_month_test %}(${date_value}) ;;
  }

  dimension: dynamic_chart_name {
    label: "Chart Name"
    label_from_parameter:year_quarter_month_test
    type: string
    sql:
      {% if year_quarter_month_test._parameter_value == "Month" %} 'Monthly'
      {% elsif year_quarter_month_test._parameter_value == "QUARTER" %} 'Quarterly'
      {% elsif year_quarter_month_test._parameter_value == "YEAR" %} 'Yearly'
      {% endif %}
      ;;
  }

}
