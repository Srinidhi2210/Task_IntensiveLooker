connection: "tpchlooker"

# include all the views
include: "/views/**/*.view"
include: "/Dashboard/Summary_Dashboard_Target_KS.dashboard.lookml"

datagroup: task1_intensive_kumari_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "4 hour"
}

persist_with: task1_intensive_kumari_default_datagroup

explore: f_lineitems {
  description: "This Explore will give details of the lineitems sold."
  label: "line items"
  join: d_supplier {
    view_label: "Supplier info"
    type:  left_outer
    relationship: many_to_one
    sql_on: ${f_lineitems.l_suppkey} = ${d_supplier.s_suppkey};;
  }
  join: d_part {
  view_label: "Parts info"
  type: left_outer
  relationship: many_to_one
  sql_on:  ${f_lineitems.l_partkey}=${d_part.p_partkey};;
 }
  join: d_dates {
    view_label: "Dates info"
    type: left_outer
    relationship:  many_to_many
    sql_on: ${f_lineitems.l_orderdatekey} = ${d_dates.datekey};;
  }
  join: d_customer {
    view_label: "Customer info"
    type: left_outer
    relationship: many_to_one
    sql_on: ${f_lineitems.l_custkey} = ${d_customer.c_custkey};;
  }



}

explore: d_customer {}

explore: d_dates {}

explore: d_part {}

explore: d_supplier {}
