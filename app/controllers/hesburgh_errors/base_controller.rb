class HesburghErrors::BaseController < ApplicationController

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


end
