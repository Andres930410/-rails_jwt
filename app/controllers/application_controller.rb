class ApplicationController < ActionController::API
  include Secured

  protected
  def errors_hash(model)
    model.errors.to_hash.merge(full_messages: model.errors.full_messages)
  end
end
