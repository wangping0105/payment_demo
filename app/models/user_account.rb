class UserAccount < ApplicationRecord
  belongs_to  :user

  before_save do
    self.total_amount = self.amount + self.frozen_amount
  end
end
