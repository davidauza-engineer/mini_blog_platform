class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  before_save :sanitize_content

  private

  def sanitize_content
    self.attributes.each do |key, value|
      self[key] = ActionController::Base.helpers.sanitize(value) if value.is_a?(String)
    end
  end
end
