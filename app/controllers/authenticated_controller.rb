# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  include ShopifyApp::Authenticated

  rescue_from StandardError,
              ShopifyApp::ShopifyDomainNotFound,
              with: :render_custom_error_response

  private

  def render_custom_error_response
    render json: { error: 'Custom error' }, status: 400
  end
end
