class Project < ApplicationRecord
    # model association
    has_many :proposals, class_name: "Proposal", foreign_key: "project_id", dependent: :destroy
    belongs_to :user, class_name: "User", foreign_key: "user_id"
    # validations
    validates_presence_of :title
    validates_presence_of :description
    validates_presence_of :budget
end
