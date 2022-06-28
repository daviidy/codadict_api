class Project < ApplicationRecord
    # model association
    has_many :proposals, class_name: "Proposal", foreign_key: "project_id", dependent: :destroy
    belongs_to :user, class_name: "User", foreign_key: "user_id"

    has_many :category_projects, foreign_key: :project_id, inverse_of: :project
    has_many :categories, through: :category_projects
    # validations
    validates_presence_of :title
    validates_presence_of :description
    validates_presence_of :budget
end
