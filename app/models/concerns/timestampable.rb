module Timestampable
  extend ActiveSupport::Concern

  included do
    scope :by_created_at_asc,   -> { order created_at: :asc }
    scope :by_created_at_desc,  -> { order created_at: :desc }

    scope :by_created_at, -> { by_created_at_desc }
    scope :by_updated_at, -> { order updated_at: :desc }

    scope :oldest_first,  -> { by_created_at_asc }
    scope :newest_first,  -> { by_created_at_desc }

    scope :fresh_first,   -> { by_updated_at }

    scope :recent, -> (limit) { newest_first.limit(limit) }
  end
end
