FactoryGirl.define do
	factory :contact, class: Contact do
		sequence :name do |n|
			"蔡建弘#{n}"
		end

		sequence :birthday do |n|
			"#{Date.today+(n*15)}"
		end
	end
end
