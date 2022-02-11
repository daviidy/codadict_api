require 'rails_helper'

RSpec.describe Project, type: :model do
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  it { should have_many(:proposals).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:budget) }
  it { should validate_presence_of(:visibility) }
  it { should validate_presence_of(:user_id) }
end
