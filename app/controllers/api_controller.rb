class ApiController < ApplicationController
  # include EscapeHelper
  # before_action :login_and_with_valid_status?, :escape_html, :set_tenant_client, :has_gc_permission?

  respond_to :json

  

  # protected

  # AUTHORIZATION_MESSAGE = {'message' => 'authorization failed!'}

  # def self.skip_check_login(options)
  #   self.skip_before_action :login_and_with_valid_status?, options
  #   self.skip_before_action :has_gc_permission?, options
  #   self.skip_before_action :logger, options
  #   self.before_action :reset_tenant_client, options
  # end

  # def find_tenant
  #   current_user.organization if current_user.present?
  # end

  # def found?(*args)
  #   if args.all? { |arg| arg != nil }
  #     yield if block_given?
  #     true
  #   else
  #     render status: :not_found, json: { response: _('resource not found') }
  #     false
  #   end
  # end

  # def valid?(target)
  #   errors = target.respond_to?(:errors) ? target.errors : target
  #   if errors.blank?
  #     yield if block_given?
  #     true
  #   else
  #     render status: :bad_request, json: errors
  #     false
  #   end
  # end

  # def truthy?(value, errors = {})
  #   if value
  #     yield if block_given?
  #     true
  #   else
  #     render status: :bad_request, json: errors
  #     false
  #   end
  # end
end
