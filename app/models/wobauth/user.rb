# frozen_string_literal: true

require_dependency 'wobauth/concerns/models/user_concerns'
module Wobauth
  class User < ApplicationRecord
    has_many :notes, dependent: :restrict_with_error
    # dependencies within wobauth models
    include UserConcerns

    # devise *#{@app_name}.devise_modules
    # or ... basic usage:
    devise *Mirco.devise_modules

    validates :password, confirmation: true
  end
end
