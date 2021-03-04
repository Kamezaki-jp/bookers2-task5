class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    #どちらのモデルからデータを取るか
    @model = params["search"]["model"]
    #どの検索方法にするのか
    @method = params["search"]["method"]
    # 検索バーの入力内容
    @content = params["search"]["content"]
    @records = search_for(@model, @content, @method)
  end
  
  private
    def match(model, content)
      if model == 'user'
        @users = User.where(name: content)
      elsif model == 'book'
        @books = Book.where(title: content)
      end
    end
    
    def forward(model, content)
      if model == 'user'
        @users = User.where("name LIKE ?", "#{content}%")
      elsif model == 'book'
        @books = Book.where("title LIKE ?", "#{content}%")
      end
    end
    
    def backward(model, content)
      if model == 'user'
        @users = User.where("name LIKE ?", "%#{content}")
      elsif model == 'book'
        @books = Book.where("title LIKE ?", "%#{content}")
      end
    end
    
    def parcial(model, content)
      if model == 'user'
        @users = User.where("name LIKE ?", "%#{content}%")
      elsif model == 'book'
        @books = Book.where("title LIKE ?", "%#{content}%")
      end
    end
    
    def search_for(method, model, content)
      case method
        when 'match'
          match(model, content)
        when 'forward'
          forward(model,content)
        when 'backward'
          backward(model, content)
        when 'parcial'
         parcial(model,content)
      end
    end
end
