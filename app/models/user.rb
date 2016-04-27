class User < ActiveRecord::Base
  has_many :confirmations
  belongs_to :team
  validates_presence_of :first_name
  validates_presence_of :last_name
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :invitable, :invite_for => 2.weeks
end
