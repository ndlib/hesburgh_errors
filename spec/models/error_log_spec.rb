require 'spec_helper'

class User
end

describe HesburghErrors::ErrorLog do

  context :log_error do

    before(:each) do
      @user = double(User, id: 1, username: 'username')
      @request = double( path: '/path/to/url', params: { id: 'id', contorller: 'controller'}, user_agent: 'user_agent' )
      @exception = double(Exception, message: 'message', backtrace: [ 'line 1', 'line 2' ])

      @controller = double(ApplicationController, current_user: @user, request: @request, params: { id: 'id', contorller: 'controller'})

      @error_log = HesburghErrors::ErrorLog.log_error(@controller, @exception)
    end


    it "logs an error " do
      expect(@error_log.valid?).to be_true
    end


    it "logs the error class" do
      expect(@error_log.exception_class).to eq("RSpec::Mocks::Mock")
    end

    it "logs the user agent " do
      expect(@error_log.user_agent).to eq("user_agent")
    end


    it "logs the request path" do
      expect(@error_log.path).to eq '/path/to/url'
    end


    it "logs the backtrace" do
      expect(@error_log.stack_trace).to eq @exception.backtrace.join("\n")
    end


    it "saves the message" do
      expect(@error_log.message).to eq "message"
    end


    it "determins the netid of the person with the problem" do
      expect(@error_log.netid).to eq "username"
    end


    it "saves the params" do
      expect(@error_log.params).to eq("{:id=>\"id\", :contorller=>\"controller\"}")
    end


    it " defaults to new " do
      expect(@error_log.state).to eq("new")
    end


    it "can tranistion to resolved" do
      @error_log.resolve
      expect(@error_log.state).to eq("resolved")
    end


    it "can transition to active" do
      @error_log.start
      expect(@error_log.state).to eq("active")
    end


    it "can transition from active to resolved " do
      @error_log.start
      @error_log.resolve
      expect(@error_log.state).to eq("resolved")
    end
  end

  context :log_message do
    before(:each) do
      @error_log = HesburghErrors::ErrorLog.log_message("netid","A BIG ERROR")
    end

    it "logs the message" do
      expect(@error_log.valid?).to be_true
    end

    it "saves the passed in message" do
      expect(@error_log.message).to eq("A BIG ERROR")
    end

    it "saves the netid of the passed in user" do
      expect(@error_log.netid).to eq("netid")
    end
  end

end
