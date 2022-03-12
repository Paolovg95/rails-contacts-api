class Contact < ApplicationRecord

  validates :name, :user, presence:true
end
