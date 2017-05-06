class OrdersController < ApplicationController
  def index
    @tenant = current_tenant
    # @result = HTTParty.post(
    #   "http://6ecf4f52.ngrok.io/api/publicstream", 
    #   :headers => { 'Content-Type' => 'application/json' },
    #   :body => { "Test": "check now" }
    #   )
    respond_to do |format|
     format.html
     format.json { render json: OrdersDatatable.new(view_context) }
    end
  end

  def track_order
    # render nothing: true
  end
end