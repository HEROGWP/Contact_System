class ContactTeam < ActiveRecord::Base
  belongs_to :contact
  belongs_to :team, counter_cache: :contact_team_count
end
