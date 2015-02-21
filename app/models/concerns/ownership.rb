module Ownership
  extend ActiveSupport::Concern

  included do
  end

  def can_write?(requester)
    self == requester || requester.moderator?
  end

  def can_delete?(requester)
    requester.moderator?
  end
 
end
