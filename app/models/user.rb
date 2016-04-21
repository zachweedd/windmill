class User < ActiveRecord::Base
  validates_presence_of :username

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable
end
