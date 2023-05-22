  view: f_lineitems {
    label: "Lineitems fact"
    sql_table_name: "DATA_MART"."F_LINEITEMS"
      ;;


    parameter: timeframe_selector {
      type: unquoted
      default_value: "month"

      allowed_value: {
        label: "Month"
        value: "month"
      }
      allowed_value: {
        label: "Quarter"
        value: "quarter"
      }
      allowed_value: {
        label: "Year"
        value: "year"
      }
    }

    dimension: dynamic_timeframe {
      label_from_parameter: timeframe_selector

      sql:
      {% if timeframe_selector._parameter_value == "quarter" %} ${d_dates.quarter}
      {% elsif timeframe_selector._parameter_value == "year" %} ${d_dates.year}
      {% elsif timeframe_selector._parameter_value == "month" %} ${d_dates.month_num}
      {% endif %}
      ;;
    }


    dimension:dynamic_timeframe_title {
      label: "Chart Title"
      type: string
      sql:
           {% if timeframe_selector._parameter_value == "quarter" %} 'Quarterly'
            {% elsif timeframe_selector._parameter_value == "year" %} 'Yearly'
            {% elsif timeframe_selector._parameter_value == "month" %} 'Monthly'
            {% endif %}
            ;;
    }

  dimension: l_availqty {
    type: number
    sql: ${TABLE}."L_AVAILQTY" ;;
  }

  dimension: l_clerk {
    type: string
    sql: ${TABLE}."L_CLERK" ;;
  }

  dimension: l_commitdatekey {
    type: number
    sql: ${TABLE}."L_COMMITDATEKEY" ;;
  }

  dimension: l_custkey {
    type: number
    sql: ${TABLE}."L_CUSTKEY" ;;
  }

  dimension: l_discount {
    type: number
    sql: ${TABLE}."L_DISCOUNT" ;;
  }

  dimension: l_extendedprice {
    type: number
    sql: ${TABLE}."L_EXTENDEDPRICE" ;;
  }

  dimension: l_linenumber {
    type: number
    sql: ${TABLE}."L_LINENUMBER" ;;
  }

  dimension: l_orderdatekey {
    type: number
    sql: ${TABLE}."L_ORDERDATEKEY" ;;
  }

  dimension: l_orderkey {
    type: number
    sql: ${TABLE}."L_ORDERKEY" ;;
  }
  # added unique primary key
  dimension: l_orderkey_l_linenumber {
    #type: number
    primary_key: yes
    sql: CONCAT(${l_orderkey}, ${l_linenumber});;
  }


  dimension: l_orderpriority {
    type: string
    sql: ${TABLE}."L_ORDERPRIORITY" ;;
  }

  dimension: l_orderstatus {
    type: string
    sql: ${TABLE}."L_ORDERSTATUS" ;;
  }

  dimension: l_partkey {
    type: number
    sql: ${TABLE}."L_PARTKEY" ;;
  }

  dimension: l_quantity {
    type: number
    sql: ${TABLE}."L_QUANTITY" ;;
  }

  dimension: l_receiptdatekey {
    type: number
    sql: ${TABLE}."L_RECEIPTDATEKEY" ;;
  }

  dimension: l_returnflag {
    type: string
    sql: ${TABLE}."L_RETURNFLAG" ;;
  }

  dimension: l_shipdatekey {
    type: number
    sql: ${TABLE}."L_SHIPDATEKEY" ;;
  }

  dimension: l_shipinstruct {
    type: string
    sql: ${TABLE}."L_SHIPINSTRUCT" ;;
  }
  dimension: l_shipmode {
    type: string
    label: "Shipmode"
    sql: ${TABLE}."L_SHIPMODE" ;;
    drill_fields: [d_supplier.suppl_cohorts_acctbal, d_supplier.s_region]
    link: {
      label: "Explore Account Balance Cohorts and Supplier Region"
    }
  }
  dimension: l_shippriority {
    type: number
    sql: ${TABLE}."L_SHIPPRIORITY" ;;
  }

  dimension: l_suppkey {
    type: number
    sql: ${TABLE}."L_SUPPKEY" ;;
  }

  dimension: l_supplycost {
    type: number
    sql: ${TABLE}."L_SUPPLYCOST" ;;
  }

  dimension: l_tax {
    type: number
    sql: ${TABLE}."L_TAX" ;;
  }

  dimension: l_totalprice {
    type: number
    sql: ${TABLE}."L_TOTALPRICE" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: total_sale_price {
    type: sum
    label: "Total sale Price"
    description: "The Total Sale Price of items sold."
    value_format: "$#,##0.00,,\" M\""
    sql: ${l_totalprice} ;;
  }

  measure: average_sale_price {
    type:  average
    label: "Average Sales Price"
    description: "The Average Sale Price of items sold."
    value_format_name: usd
    sql:${l_totalprice} ;;
  }
  measure: cumulative_total_sales {
    type: running_total
    description: "The Cumulative Total Sales from items sold."
    value_format: "$#,##0.00,,\" M\""
    sql:  ${l_totalprice} ;;
  }

measure: Total_Russia_Sales {
  type: sum
  label: "Total Russia Sales"
  description: "Total sales by customers from Russia"
  value_format: "$#,##0.00, , \" M\""
  sql:${l_totalprice}  ;;
  filters: [d_customer.c_nation: "Russia"]

}
measure: Total_Gross_Revenue {
  type: sum
  description: "The Total Gross Revenue from items sold."
  value_format: "$#,##0.00,,\" M\""
  sql: ${l_totalprice} ;;
  filters: [l_orderstatus: "F"]

}
measure: Total_Cost {
    type: sum
  description: "The Total Cost from items sold."
  value_format: "$#,##0.00,,\" M\""
  sql:  ${l_supplycost} ;;
}

measure: Total_Gross_Margin_Amount {
  type: number
  description: "Total Gross Margin Amount"
  value_format: "$#,##0.00,,\" M\""
  sql: ${Total_Gross_Revenue}-${Total_Cost} ;;
}

measure: Goss_Margin_Percentage {
  type:  number
  description: "Total Gross Margin Amount/Total Gross Revenue."
  value_format: "0.00%"
  sql: ${Total_Gross_Margin_Amount}/${Total_Gross_Revenue} ;;
}

measure:Number_of_Items_Returned {
  type: sum
  description: "Number of items that were returned by dissatisfied customers."
  value_format: "#,##0"
  sql:  ${l_quantity};;
  filters: [l_returnflag: "R"]
}

measure: Total_Number_of_Items_Sold {
type: sum
  description: "Number of items that were sold."
  value_format: "#,##0"
  sql: ${l_quantity};;
}

measure: item_return_rate{
type: number
description:  "Number Of Items Returned / Total Number Of Items Sold"
value_format: "0.00%"
sql: ${Number_of_Items_Returned} / NULLIF(${Total_Number_of_Items_Sold },0);;

}

    measure:  returned_rate_group{
      type: number
      value_format_name: percent_2
      sql:${item_return_rate} ;;
      html:
          {% if value >= 0.5 %}
            <font color="red">{{ rendered_value }}</font>
          {% elsif value >= 0.3  and value < 0.5%}
            <font color ="orange">{{ rendered_value }}</fontn>
          {% else %}
            <font color ="green">{{ rendered_value }}</font>
          {% endif %} ;;
    }
  measure: average_spend_by_customer{
    type: number
    description: "Total Sale Price / Total Number of Customers."
    value_format: "$#,##0.00"
    sql:${total_sale_price} / NULLIF(${d_customer.count}, 0) ;;

}
}
