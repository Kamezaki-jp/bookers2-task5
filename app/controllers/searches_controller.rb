class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    #どちらのモデルからデータを取るか
    @model = params["model"]
    #どの検索方法にするのか
    @method = params["method"]
    # 検索バーの入力内容
    @content = params["content"]
    @records = search_for(@model, @method, @content)
  end
  
  private
    def search_for(model, method, content)
      if model == 'user'
        if method == 'perfect'
          User.where(name: content)
        elsif method == 'partial'
          User.where('name LIKE ?', '%'+content+'%')
        elsif method == 'forward'
          User.where('name LIKE ?', content+'%')
        elsif method == 'backward'
          User.where('name LIKE ?', '%'+content)
        end
      elsif model == 'book'
        if method == 'perfect'
          Book.where(title: content)
        elsif method == 'partial'
          Book.where('title LIKE ?', '%'+content+'%')
        elsif method == 'forward'
          Book.where('title LIKE ?', content+'%')
        elsif method == 'backward'
          Book.where('title LIKE ?', '%'+content)
        end
      end
    end
end
