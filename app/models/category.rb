class Category < ActiveRecord::Base
  has_and_belongs_to_many :data_sets

  attr_reader :category_tokens
  attr_accessible :category_tokens

  def category_tokens=(ids)
    self.category_ids = ids.split(",")
  end

  scope :published, lambda {
    joins(:data_sets).
    where("data_sets.status = 'published'") }
end
