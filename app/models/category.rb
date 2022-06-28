class Category < ApplicationRecord
    has_many :category_projects, foreign_key: :category_id
    has_many :projects, through: :category_projects
    
    validates_presence_of :name
end
