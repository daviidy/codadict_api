class User < ApplicationRecord
    # encrypt password
    has_secure_password

    has_many :projects, class_name: "Project", foreign_key: "user_id", dependent: :destroy
    has_many :proposals, class_name: "Proposal", foreign_key: "user_id", dependent: :destroy

    validates_presence_of :name, :email, :password_digest
end
