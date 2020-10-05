class Message < ApplicationRecord
  belongs_to :user
  belongs_to :receive, class_name: 'User'
end
