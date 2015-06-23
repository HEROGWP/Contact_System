class Contact < ActiveRecord::Base
  validates :name, :birthday, :presence => true

  self.per_page = 9
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  has_many :participated_teams, through: :contact_teams, source: :team
  has_many :contact_teams
  #has_and_belongs_to_many :teams

  # def name_with_initial
  #   "#{name}"
  # end
  before_create do
    self.month = self.birthday.month
  end
  before_update do
    self.month = self.birthday.month
  end

  def self.to_csv
    CSV.generate do |csv|
      output_header = ["姓名", "生日","電話","地址", "備註"]
      output_values = ["name", "birthday", "phone", "address", "remark"]
      csv << output_header
      all.each do |contact|
        csv << contact.attributes.values_at(*output_values)
      end
    end
  end
end
