class RelationshipfavosController < ApplicationController
  def create
    micro = Micropost.find(params[:favorite_id])
    current_user.favorite(micro)
    flash[:success] = 'お気に入り登録しました。'
    redirect_to current_user
  end

  def destroy
    micro = Micropost.find(params[:favorite_id])
    current_user.unfavorite(micro)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_to current_user
  end
end
