FactoryGirl.define do
  factory :user, class: User do
    sequence :email do |n|
      "user#{n}@gmail.com"
    end
    password "12345678"

    factory :user_has_contact_and_team_join_one do
	    sequence :email do |n|
	      "user_has_contact_and_team_join_one#{n}@gmail.com"
	    end

	    after(:create) do |user|
	    	contact = create(:contact, user_id: user.id)
	    	team = create(:team, user_id: user.id)
	      create(:contact_team, contact_id: contact.id, team_id: team.id)
	    end
	  end
  end
end
