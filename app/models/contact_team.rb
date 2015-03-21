class ContactTeam < ActiveRecord::Base
  belongs_to :contact
  belongs_to :team
end
