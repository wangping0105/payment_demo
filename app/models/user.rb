class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable#, :validatable

  acts_as_paranoid
  # has_secure_password
  has_one :api_key
  has_one :attachment, as: :attachmentable
  has_many :orders
  has_many :order_pays
  has_one :user_account

  validates_presence_of :password, :message => "密码不能为空!"
  validates_uniqueness_of :email, conditions: -> { paranoia_scope }, :message => "邮箱已经存在!"
  # validates_uniqueness_of :phone, conditions: -> { paranoia_scope }
  validates_presence_of :email, :message => "邮箱不能为空!"
  validates_format_of  :email, :message => "邮箱格式不正确!", :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  enum :role => {nomal: 0, admin: 1}

  before_save do
    self.name ||= self.phone
    self.name_pinyin = PinYin.of_string(self.name).join('').first(255)
  end

  after_save do
    _api_key = self.api_key
    _api_key.save if _api_key.present?
  end

  def admin?
    if role == 'admin'
      return true
    end
    false
  end
end
