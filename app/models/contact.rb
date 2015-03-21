class Contact < ActiveRecord::Base
  validates :name, :presence => true

  belongs_to :owner, class_name: "User", foreign_key: :user_id
  has_many :participated_teams, through: :contact_teams, source: :team
  has_many :contact_teams
  #has_and_belongs_to_many :teams

  # def name_with_initial
  #   "#{name}"
  # end



end
