- dashboard: summary_dashboard_target__ks
  title: Summary Dashboard Target - KS
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: 62TQHO39OdS4ltF9Nxaa1b
  elements:
  - title: Return Rate By Supplier Region
    name: Return Rate By Supplier Region
    model: task1_intensive_kumari
    explore: f_lineitems
    type: looker_grid
    fields: [d_supplier.s_name, d_supplier.s_region, d_customer.c_region, f_lineitems.items_returned,
      f_lineitems.items_sold, f_lineitems.returned_rate_group]
    filters:
      d_customer.c_region: ''
      d_supplier.s_region: "-NULL"
    sorts: [f_lineitems.items_returned desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Customer Nation: d_customer.c_nation
      Month Quarter Year: d_dates.year_quarter_month_test
    row: 0
    col: 10
    width: 14
    height: 10
  - title: Gross Margin Trends
    name: Gross Margin Trends
    model: task1_intensive_kumari
    explore: f_lineitems
    type: looker_column
    fields: [f_lineitems.Total_Gross_Margin_Amount, d_dates.dynamic_date_filter]
    filters:
      d_customer.c_region: ''
      d_customer.c_nation: ''
    sorts: [d_dates.dynamic_date_filter]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    series_types: {}
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Month Quarter Year: d_dates.year_quarter_month_test
    row: 0
    col: 0
    width: 10
    height: 10
  filters:
  - name: Customer Nation
    title: Customer Nation
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: task1_intensive_kumari
    explore: f_lineitems
    listens_to_filters: []
    field: d_customer.c_nation
  - name: Region
    title: Region
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: task1_intensive_kumari
    explore: f_lineitems
    listens_to_filters: []
    field: d_customer.c_region
  - name: Month Quarter Year
    title: Month Quarter Year
    type: field_filter
    default_value: Month
    allow_multiple_values: true
    required: false
    ui_config:
      type: radio_buttons
      display: inline
    model: task1_intensive_kumari
    explore: f_lineitems
    listens_to_filters: []
    field: d_dates.year_quarter_month_test
