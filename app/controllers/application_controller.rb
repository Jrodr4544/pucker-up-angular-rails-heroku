require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder

  protect_from_forgery with: :exception

  after_filter :set_csrf_cookie

  respond_to :json

  def set_csrf_cookie
      cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def index
      # root application#index will be the home to ui-view
  end

  protected
      def verified_request?
          super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
      end

end
