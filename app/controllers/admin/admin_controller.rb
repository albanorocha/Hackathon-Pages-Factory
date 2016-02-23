class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  layout 'admin'

  add_breadcrumb "Home", :admin_root_path
end
