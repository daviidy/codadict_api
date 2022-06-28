require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should have_many(:projects) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:name) }
end
