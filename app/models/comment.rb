class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  def text_html
    RDiscount.new(text).to_html
  end
end
