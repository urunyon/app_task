class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    
    if @model  == "user"#選択したモデルに応じて検索を実行
      @records = User.search_for(@content, @method)
    else
      @records = Books.search_for(@content, @method)
    end
  end
end
