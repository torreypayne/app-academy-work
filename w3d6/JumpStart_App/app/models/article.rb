class Article < ActiveRecord::Base
  has_many :comments
  has_many :taggings
  has_many :tags, through: taggings

  def index
    @articles = Article.all
  end

  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end
end
