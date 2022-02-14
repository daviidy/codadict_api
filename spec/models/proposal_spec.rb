require 'rails_helper'

RSpec.describe Proposal, type: :model do
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  it { should belong_to(:project) } 
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:deadline) }
end
