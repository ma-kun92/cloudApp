class Group < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :group_users,dependent: :destroy
  has_many :users, through: :group_users
end
