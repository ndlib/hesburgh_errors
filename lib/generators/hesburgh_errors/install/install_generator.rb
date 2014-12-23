class HesburghErrors::InstallGenerator < ::Rails::Generators::Base

  source_root File.expand_path('../templates', __FILE__)

  def all
    copy_file "errors_controller.rb", "app/controllers/hesburgh_errors/errors_controller.rb"
    route 'mount HesburghErrors::Engine => "/hesburgh_errors"'

    inject_into_file 'app/controllers/application_controller.rb', after: "protect_from_forgery"  do <<-RUBY

      include HesburghErrors::ControllerErrorTrapping

      unless Rails.configuration.consider_all_requests_local
        setup_controller_errors
      end

      RUBY
    end
  end

end
