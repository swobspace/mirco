# frozen_string_literal: true

require_dependency 'wobauth/concerns/models/user_concerns'
module Wobauth
  class User < ApplicationRecord
    has_many :notes, dependent: :restrict_with_error
    has_and_belongs_to_many :notification_groups, inverse_of: :users
    # dependencies within wobauth models
    include UserConcerns

    # devise *#{@app_name}.devise_modules
    # or ... basic usage:
    devise *Mirco.devise_modules

    validates :password, confirmation: true
  end
end
