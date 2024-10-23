class Comment < ApplicationRecord
  include Visible

  validates :body, presence: true
  validates :commenter, presence: true

  belongs_to :article
end
