class District < ActiveRecord::Base
  belongs_to :city, touch: true

  def to_s
    name || id
  end
end
