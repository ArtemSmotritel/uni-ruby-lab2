class Comment < ApplicationRecord
  include Visible

  validates :body, presence: true

  belongs_to :article
  belongs_to :author, class_name: "User", foreign_key: "user_id"
end
