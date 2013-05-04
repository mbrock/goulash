class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  def self.grouped_by_day
    self.all.group_by do |post|
      post.created_at.to_date
    end.sort_by { |k, v| k }.reverse
  end
end
