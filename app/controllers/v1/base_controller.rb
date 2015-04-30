module V1
  class BaseController < ApplicationController
    include ActionController::Serialization
    include Rails::API::HashValidationErrors

    # Callbacks
    before_action :doorkeeper_authorize!

    # Exception handling
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid,  with: :record_invalid
    rescue_from ActiveRecord::RecordNotSaved, with: :record_invalid

    private

    ##################################
    # Auth
    ##################################

    def current_user
      return nil unless doorkeeper_token

      @current_user ||= User.find doorkeeper_token.resource_owner_id
    end

    ##################################
    # Exception handling
    ##################################

    # Override Rails 404 responder, to return a custom JSON message.
    def record_not_found(exception)
      render json: {
               status: 404,
               message: exception.message.to_s
             },
             status: :not_found
    end

    # If a record cannot be saved, because it is either malformed or some
    # callback failed, an error message containing the record's errors is
    # returned.
    def record_invalid(exception)
      errors = exception.record.errors.as_json

      render json: {
               status: 422,
               message: 'Unprocessable entity',
               errors: errors
             },
             status: :unprocessable_entity
    end
  end
end
