class Team < ActiveRecord::Base
  self.per_page = 9
  belongs_to :team_owner, class_name: "User", foreign_key: :user_id
  has_many :members, through: :contact_teams, source: :contact, dependent: :destroy
  has_many :contact_teams
  #has_and_belongs_to_many :contacts
end
