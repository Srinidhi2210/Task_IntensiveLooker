view: d_dates {
  sql_table_name: "DATA_MART"."D_DATES"
    ;;
## DIMENSIONS ##
    dimension: datekey {
      primary_key: yes
      hidden: yes
      label: "Primary Key"
      type: number
      sql: ${TABLE}."DATEKEY" ;;
    }

    dimension_group: date_val {
      type: time
      timeframes: [
        raw,
        date,
        week,
        month,
        day_of_month,
        quarter,
        year
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
    parameter: date_parameter {
      description:"Choose date: "
      type: unquoted
      allowed_value: {
        label:"Day"
        value: "Day"
      }
      allowed_value: {
        label:"Week"
        value: "Week"
      }
      allowed_value: {
        label:"Month"
        value: "Month"
      }
      allowed_value: {
        label:"Quarter"
        value:"Quarter"
      }
      allowed_value: {
        label:"Year"
        value:"Year"
      }
    }

    dimension: dynamic_date_filter {
      description: "Choose Date Format"
      type: number
      label_from_parameter: date_parameter
      sql: {% parameter date_parameter %}(${TABLE}."DATE_VAL") ;;
    }

    dimension: dynamic_chart_name {
      label: "Chart Name"
      label_from_parameter:date_parameter
      type: string
      sql:
      {% if date_parameter._parameter_value == "Day" %} 'Daily'
      {% elsif date_parameter._parameter_value == "Week" %} 'Weekly'
      {% elsif date_parameter._parameter_value == "Month" %} 'Monthly'
      {% elsif date_parameter._parameter_value == "Quarter" %} 'Quarterly'
      {% elsif date_parameter._parameter_value == "Year" %} 'Yearly'
      {% endif %}
      ;;
    }

## MEASURES ##
    measure: count {
      label: "Count"
      description: "Rows Count"
      type: count
      drill_fields: [month_name]
    }
  }
