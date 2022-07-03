require "active_support/concern"

module Response
  extended ActiveSupport::Concern

    def json_response(object, status = :ok)
      render json: object, status: status
    end

end