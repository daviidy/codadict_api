class CategoryProject < ApplicationRecord
    belongs_to :project, class_name: "Project", foreign_key: "project_id"
    belongs_to :category, class_name: "Category", foreign_key: "category_id"
end
