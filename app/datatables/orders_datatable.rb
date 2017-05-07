class OrdersDatatable
  delegate :params, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Order.count,
      iTotalDisplayRecords: orders.total_entries,
      aaData: data
    }
  end

private

  def data
    orders.map do |order|
      [
        order.name,
        order.movie_name,
        order.theatre_name,
        order.no_of_seats,
        order.time
      ]
    end
  end

  def orders
    @orders ||= fetch_orders
  end

  def fetch_orders
    orders = Order.order("#{sort_column} #{sort_direction}").uniq
    orders = orders.page(page).per_page(per_page)
    if params[:sSearch].present?
      orders = orders.where("name like :search or description like :search", search: "%#{params[:sSearch]}%")
    end
    orders
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name movie_name theatre_name no_of_seats time]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end