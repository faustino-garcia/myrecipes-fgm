class Chef < ApplicationRecord
    before_save {self.email = email.downcase}
    validates :name, presence: true, length: {maximum: 30}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}, 
    uniqueness: {case_sensitive: false} 
    #here it is unnecesary to specify uniqueness: true because it's alredy testing for it
end
