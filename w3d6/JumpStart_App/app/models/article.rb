class Article < ActiveRecord::Base
  has_many :comments

  def index
    @articles = Article.all
  end
end
