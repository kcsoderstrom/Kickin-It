class Goal < ActiveRecord::Base
  validates :title, :user_id, presence: true
  validates :is_private, inclusion: [true, false]

  validates :title, uniqueness: { scope: :user }

  belongs_to :user

  def to_s
    "#{title}: #{content}"
  end

end