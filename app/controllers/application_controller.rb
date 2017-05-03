class ApplicationController < ActionController::Base
  require 'json_web_token'
  protect_from_forgery with: :exception
end
