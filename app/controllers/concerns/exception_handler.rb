# app/controllers/concerns/exception_handler.rb
module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern
  ERROR = {error: "error", description: "deskripsi error"}.freeze

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response(ERROR, :unprocessable_entity)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response(ERROR, :unprocessable_entity)
    end

    rescue_from NoMethodError do |e|
      json_response(ERROR, :unprocessable_entity)
    end
  end
end