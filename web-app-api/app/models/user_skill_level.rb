class UserSkillLevel < ApplicationRecord
  validates :skill, presence: true
  validates :user_name, presence: true
  validates :level, presence: true, :numericality => true, :inclusion => { :in => 0..5 }
end
