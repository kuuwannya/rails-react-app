class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update]
  def index
    #都道府県が同じで性別の異なるユーザーを取得（自分以外）
    users = User.where(prefecture: current_api_v1_user.prefecture).where.not(id: current_api_v1_user.id, gender: current_api_v1_user.gender).order("created_at DESC")
    render json: { status: 200, users: users}
  end

  def show
    render json: { status: 200, user: @user }
  end

  def update
    @user.name = user_params[:name]
    @user.prefecture = user_params[:prefecture]
    @user.profile = user_params[:profile]
    @user.image = user_params[:image] if user_params[:image] != "" #空じゃない場合

    if @user.save
      render json: { status: 200, user: @user }
    else
      render json: { status: 500, message: "更新に失敗しました"}
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:name, :prefecture, :profile, :image)
    end
end
