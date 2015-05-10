class Article < ActiveRecord::Base

  def index
    @articles = Article.all
  end
end
