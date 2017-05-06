class TenantsController < ApplicationController
  def new
    @tenant = Tenant.new
  end

  def create
    @tenant = Tenant.new(tenant_params)
    @tenant.save
    redirect_to root_path
  end

  private
  def tenant_params
    params.require(:tenant).permit(:name, :subdomain, :company_email, :company_phone, :password, :confirm_password)
  end
end