class Country < ActiveRecord::Base
  has_many :provinces

  def to_s
    name || id
  end
end
