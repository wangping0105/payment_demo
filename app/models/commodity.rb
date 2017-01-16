class Commodity < ApplicationRecord
  belongs_to :category, counter_cache: true
  has_many :attachments, as: :attachmentable

  def first_image_url
    if attachments.exists?
      attachments.first.file_url
    else
      "demo_product.jpg"
    end

  end
end
