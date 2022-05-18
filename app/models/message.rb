class Message < ApplicationRecord

    belongs_to :chef
    validates :content, presence: true
    validates :chef_id, presence: true

    def self.most_recent 
        order(:created_at).last(10) #Only grabs the last 10 
    end

end 