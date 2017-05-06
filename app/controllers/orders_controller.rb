class OrdersController < ApplicationController
  def index
    @tenant = current_tenant
    # RetrieveTweetBackground.perform_in(2.seconds)
    respond_to do |format|
     format.html
     format.json { render json: OrdersDatatable.new(view_context) }
    end
  end

  def track_order
    # render nothing: true
  end
end