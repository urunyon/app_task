class RelationshipsController < ApplicationController
  before_action :authenticate_user!#アクション実行前にユーザーがログインしとるか確認してる
  
  def create #フォローするアクション
    user = User.find(params[:user_id])
    current_user.follow(user)#カレントユーザーが.ユーザーをフォロー
    redirect_to request.referer#アクション実行前のページを表示（アクション実行してもページが変わらない）
  end
  
  def destroy #フォロー解除するアクション
    user = User.find(params[:user_id])
    current_user.unfollow(user)#カレントユーザーが.ユーザーのフォローを解除
    redirect_to request.referer
  end
  
  def followings #特定のユーザー「が」フォローしているユーザーの一覧を表示するアクション
    user = User.find(params[:user_id])#対象のユーザーをユーザー達から特定
    @users = user.followings#上で特定したユーザー「が」フォローしているユーザーを@userに代入してる
  end
  
  def followers #特定のユーザー「を」フォローしているユーザーの一覧を表示するアクション
    user = User.find(params[:user_id])#対象のユーザーをユーザー達から特定
    @users = user.followers#上で特定したユーザー「を」フォローしているユーザーを@userに代入してる
  end
  
end
