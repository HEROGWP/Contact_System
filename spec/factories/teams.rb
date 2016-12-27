FactoryGirl.define do
	factory :team do
		sequence :when do |n|
			"#{Date.today+(n*15)}"
		end
	end
end
