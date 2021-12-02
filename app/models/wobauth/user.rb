require_dependency 'wobauth/concerns/models/user_concerns'
class Wobauth::User < ActiveRecord::Base
  has_many :notes, dependent: :restrict_with_error
  # dependencies within wobauth models
  include UserConcerns

  # devise *#{@app_name}.devise_modules
  # or ... basic usage:
  devise :database_authenticatable

  validates :password, confirmation: true
end
