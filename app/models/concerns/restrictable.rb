module Restrictable
  extend ActiveSupport::Concern

  included do
    has_many :restrictions, as: :restrictable, dependent: :destroy
    accepts_nested_attributes_for :restrictions
  end

  # Instance methods can go here
  def restriction_names
    restrictions.pluck(:name).join(", ")
  end
end
