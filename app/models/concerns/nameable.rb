module Nameable
  extend ActiveSupport::Concern

  included do
    scope :by_name, -> { order name: :asc }
  end

  def to_s
    name.present? ? name : id
  end
end
