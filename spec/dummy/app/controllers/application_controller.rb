class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate, :another_authentication
  around_action :around_test1, :around_test2

  def authenticate
    redirect_to '/401.html'
  end

  def another_authentication
    redirect_to '/401.html'
  end

  def around_test1
    redirect_to '/401.html'
  end

  def around_test2
    redirect_to '/401.html'
  end
end
