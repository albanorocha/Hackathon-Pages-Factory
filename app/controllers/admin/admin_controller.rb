class Admin::AdminController < ApplicationController
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
  before_action :authenticate_user!
  layout 'admin'

  add_breadcrumb "Home", :admin_root_path
end
