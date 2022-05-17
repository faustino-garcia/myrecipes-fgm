class Recipe < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true, length: {minimum: 5, maximum: 5000}
    belongs_to :chef
    has_many :recipe_ingredients
    has_many :ingredients, through: :recipe_ingredients
    has_many :comments, dependent: :destroy #without recipe there aren't any comments
    validates :chef_id, presence: true
    default_scope -> { order(updated_at: :desc)} 
end