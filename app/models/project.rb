class Project < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :messages

  validates :title, :video, :presence => true
  mount_uploader :video, VideoUploader
end
