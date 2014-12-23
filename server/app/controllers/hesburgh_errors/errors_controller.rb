require 'yaml'

class HesburghErrors::ErrorsController < ApplicationController
  before_action :check_authentication

  def index
    @errors = HesburghErrors::ErrorLog.errors
  end

  def show
    @error = HesburghErrors::ErrorLog.find(params[:id])

    if @error.start
      @error.save!
    end
  end

  def update
    @error = HesburghErrors::ErrorLog.find(params[:id])

    if @error.resolve
      flash[:notice] = "Resolved Error ##{@error.id}"
      @error.save!
    end

    redirect_to errors_path()
  end

  protected

    def check_authentication
      if !defined?(User) && !self.respond_to?(:current_user)
        raise "To use the errors controller you must implement devise and devise cas!!!!!!!"
      end

      (admin_netids.include?(current_user.username))
    end


    def admin_netids
      @error_admins ||= YAML::load(File.open('hesburgh_errors/error_admins.yml'))
      @error_admins[:admin_netids]
    end
end
