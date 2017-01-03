module Htmlable
  extend ActiveSupport::Concern

  def html_id
    [self.class.name.parameterize, id].join('-')
  end
end
