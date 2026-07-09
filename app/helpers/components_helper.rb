module ComponentsHelper
  def sortable_column_header(column, label)
    column = column.to_s
    active = @sort == column
    next_direction = active && @direction == "asc" ? "desc" : "asc"
    indicator = active ? (@direction == "asc" ? " ▲" : " ▼") : ""

    link_to "#{label}#{indicator}", components_path(request.query_parameters.merge("sort" => column, "direction" => next_direction)),
      class: "hover:text-text"
  end
end
