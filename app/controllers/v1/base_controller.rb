module V1
  class BaseController < ApplicationController
    # Exception handling
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid,  with: :record_invalid
    rescue_from ActiveRecord::RecordNotSaved, with: :record_invalid

    private

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
