class OrdersController < ApplicationController
  def index
    @tenant = current_tenant
    respond_to do |format|
     format.html
     format.json { render json: OrdersDatatable.new(view_context) }
    end
  end
end