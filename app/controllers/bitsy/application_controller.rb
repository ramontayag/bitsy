module Bitsy
  class ApplicationController < ActionController::API
    # TODO: Remove this when bug is fixed
    # https://github.com/rails-api/active_model_serializers/issues/600
    include ActionController::Serialization
  end
end
