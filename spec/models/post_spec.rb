require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) do
      User.create(name: 'user', email: 'user@test.com',
                  password: '123456', password_confirmation: '123456')
  end

  subject do
    Post.new(user_id: user.id, content: 'Lorem Lorem Lorem Lorem Lorem Lorem')
  end
    

  describe 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_most(1000).
    with_long_message('1000 characters in post is the maximum allowed.') }
  end

  it 'is valid when all attributes are valid' do
    expect(subject).to be_valid
  end

  it 'is invalid when content is blank' do
    subject.content = nil
    expect(subject).to_not be_valid
  end

  it 'is invalid when content length is greater than 1000' do
    subject.content = 'c'*1001
    expect(subject).to_not be_valid
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end
  
end