
module HesburghErrors::ControllerErrorTrapping

  def self.included(base)
    include HesburghErrors::ErrorTrapping

    base.extend(ClassMethods)
  end

  protected
    def catch_403(exception=nil)
      log_error(exception)

      respond_to do |format|
        format.html { render :template => 'hesburgh_errors/errors/error_403', :status => 404 }
      end
    end

    def catch_404(exception=nil)
      log_error(exception)

      respond_to do |format|
        format.html { render :template => 'hesburgh_errors/errors/error_404', :status => 404 }
      end
    end


    def catch_500(exception=nil)
      log_error(exception)

      # forward to exception notifier if it is defined
      if Object.const_defined?('ExceptionNotifier')
        ExceptionNotifier.notify_exception(exception, { :env => request.env })
      end

      respond_to do |format|
        format.html { render :template => 'hesburgh_errors/errors/error_500', :status => 500 }
      end
    end


    def log_error(exception)
      @e = env["action_dispatch.exception"]
      if exception.blank?
        HesburghErrors::ErrorLog.log_error(self, @e)
      else
        HesburghErrors::ErrorLog.log_error(self, exception)
      end
    end



  module ClassMethods

    def setup_controller_errors
      # must be first otherwise the others will not fire.
      rescue_from Exception, :with => :catch_500

      rescue_from ActionController::RoutingError, :with => :catch_404
      rescue_from ActionController::UnknownController, :with => :catch_404
      rescue_from AbstractController::ActionNotFound, :with => :catch_404
      rescue_from ActiveRecord::RecordNotFound, :with => :catch_404
    end
  end
end
