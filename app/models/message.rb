class Message < ApplicationRecord

    belongs_to :chef
    validates :content, presence: true
    validates :chef_id, presence: true

    def self.most_recent 
        order(created_at: :desc).first(7) #Only grabs the last 7
    end
    
end 