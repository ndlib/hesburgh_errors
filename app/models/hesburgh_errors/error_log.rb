require 'state_machine'

module HesburghErrors
  class ErrorLog < ActiveRecord::Base
    self.table_name = "error_logs"

    scope :default_order, -> { order("state DESC, created_at DESC") }

    state_machine :state, :initial => :new do

      event :resolve do
        transition [:new, :active] => :resolved
      end

      event :start do
        transition [:new] => :active
      end

      state :new
      state :active
      state :resolved
    end


    def self.log_error(controller, exception)
      error = ErrorLog.create(
        message: determine_message(exception),
        netid: determine_netid(controller),
        path: controller.request.path,
        params: controller.params.to_s,
        exception_class: determine_exception_class(exception),
        user_agent: controller.request.user_agent,
        stack_trace: determine_backtrace(exception)
      )

      Rails.logger.warn(DateTime.now.to_s + " [ERROR RAISED] /errors/#{error.id}")

      error
    end


    def self.log_message(netid, text)
      error = ErrorLog.create(
        message: text,
        netid: netid,
        path: "",
        params: "",
        exception_class: "",
        user_agent: "",
        stack_trace: ""
      )
    end


    def self.errors
      self.default_order.limit(100).where("state != ? ", 'resolved')
    end


    def self.determine_netid(controller)
      if controller.respond_to?(:current_user) && controller.current_user.present?
         controller.current_user.username
      else
        "Uknown User"
      end
    end


    def self.determine_message(exception)
      exception.blank? ? 'Nil Exception' : exception.message
    end


    def self.determine_backtrace(exception)
      if exception.blank?
        'Nil Exception'
      elsif exception.backtrace.nil?
        "No Backtrace"
      else
        exception.backtrace.join("\n")
      end
    end


    def self.determine_exception_class(exception)
      if exception.blank?
        "No Exception Thrown"
      else
        exception.class.to_s
      end
    end


    def self.determine_masquerade(controller)
      masquerade = Masquerade.new(controller)
      if masquerade.masquerading?
        return masquerade.original_user.username
      end

      return false
    end
  end
end
