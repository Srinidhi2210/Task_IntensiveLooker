view: d_dates {
  sql_table_name: "DATA_MART"."D_DATES"
    ;;

  dimension_group: date_val {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      day_of_month
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."DATE_VAL" ;;
  }

  dimension: datekey {
    type: number
    primary_key: yes
    sql: ${TABLE}."DATEKEY" ;;
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
    view_label: "{% parameter view_label %}"
    type: number
    sql: order by {${TABLE}."MONTH_NUM" };;

  }

  dimension: quarter {
    view_label: "{% parameter view_label %}"
    type: number
    sql: ${TABLE}."QUARTER" ;;
  }

  dimension: year {
    view_label: "{% parameter view_label %}"
    type: number
    sql: ${TABLE}."YEAR" ;;
  }

  measure: count {
    type: count
    drill_fields: [month_name]
  }

  parameter: view_label {
    type: string
    default_value: "The Granularity"
  }

  parameter: date_granularity {
    type: unquoted
    allowed_value: {
      label: "Group by Year"
      value: "year"
    }
    allowed_value: {
      label: "Group by Quarter "
      value: "quarter"
    }
    allowed_value: {
      label: "Group by Month "
      value: "month"
    }
  }

  dimension: granularity {
    label: "{% if date_granularity._parameter_value == 'year' %} Year {% elsif date_granularity._parameter_value == 'quarter' %} Quarter {% else %} Month {% endif %}"
    sql:
    {% if date_granularity._parameter_value == 'year' %}
      ${year}
    {% elsif date_granularity._parameter_value == 'quarter' %}
      ${quarter}
    {% else %}
      ${month_num}
    {% endif %};;
  }

}
