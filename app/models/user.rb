# frozen_string_literal: true

class User < ApplicationRecord
  validates :login, presence: true
end
