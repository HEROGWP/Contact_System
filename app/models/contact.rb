class Contact < ActiveRecord::Base
  validates :name, :presence => true

  belongs_to :owner, class_name: "User", foreign_key: :user_id
end
