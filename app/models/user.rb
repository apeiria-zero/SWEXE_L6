class User < ApplicationRecord
  #TODO: validates
  has_many :tweets,dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_tweets, through: :likes, source: :tweet
  validates :password, presence: true, confirmation: true
  
  attr_accessor :password, :password_confirmation

  def password=(val)
    if val.present?
      self.pass = BCrypt::Password.create(val)
    end
  @password = val
  end
  def create
    @user = User.new(
    uid: params[:user][:uid],
    password: params[:user][:password],
    password_confirmation: params[:user][:password_confirmation])
    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
    end
end
