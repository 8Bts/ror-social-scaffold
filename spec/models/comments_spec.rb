require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Validation' do
    let(:user) do
      User.create(name: 'user1', email: 'user1@gmail.com',
                  password: 'password', password_confirmation: 'password')
    end
    let(:post) do
      Post.create(user_id: user.id, content: 'Post post Post post Post post Post
    Post post post Post post Post post Post post .')
    end
    subject do
      Comment.new(user_id: user.id, post_id: post.id, content:
                  'comment comment comment comment comment comment
                comment comment comment comment comment comment')
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is invalid when content is blank' do
      subject.content = nil
      expect(subject).to_not be_valid
    end

    it 'is invalid when content lenght is more than 200' do
      subject.content = 'a' * 201
      expect(subject).to_not be_valid
    end
  end
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
