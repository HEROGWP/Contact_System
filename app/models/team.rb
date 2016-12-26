class Team < ActiveRecord::Base
  validates :when, :presence => true
  self.per_page = 9
  belongs_to :team_owner, class_name: "User", foreign_key: :user_id
  has_many :members, through: :contact_teams, source: :contact, dependent: :destroy
  has_many :contact_teams
  #has_and_belongs_to_many :contacts
  before_create :set_year_and_month
  before_update :set_year_and_month

  def set_year_and_month
    if self.when
      self.year = self.when.year
      self.month = self.when.month
    end
  end
end
