class Order < ApplicationRecord
  belongs_to  :commodity
  belongs_to  :user

  enum status: {paying: 0, paid: 1, failed: 2, refund: 3, cancel: 4}
  before_save do
    self.discount ||= 0
    self.price = (1 - self.discount) * self.origin_price
    self.status ||= 0
  end

  def status_mapped
    I18n.t("enum.order.status.#{status}")
  end
end
