module HesburghErrors::ErrorTrapping

  def self.included(base)
    base.extend(ClassMethods)
  end


  def raise_404(message = "Not Found")
    raise ActionController::RoutingError.new(message)
  end


  module ClassMethods
    def raise_404(message = "Not Found")
      raise ActionController::RoutingError.new(message)
    end
  end
end
