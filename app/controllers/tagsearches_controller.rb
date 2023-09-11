class TagsearchesController < ApplicationController

  def search
    @model = Book #search機能とは関係なし
    @word = params[:word]
    @books = Book.where("tag LIKE?","%#{@word}%")
    render "tag_searches/tagsearch"
  end

end
