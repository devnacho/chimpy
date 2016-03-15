class User < ActiveRecord::Base
  include Chimpy::Sync

  validates :email, uniqueness: true
end
