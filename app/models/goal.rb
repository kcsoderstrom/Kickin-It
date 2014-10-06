class Goal < ActiveRecord::Base
  validates :title, :user_id, presence: true
  validates :title, uniqueness: { scope: :user }

  belongs_to :user

end