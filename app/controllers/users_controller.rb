class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    begin
      @user = User.where(id: Integer(params[:id])).first
    rescue ArgumentError
      @user = User.where(username: params[:id]).first
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email)
  end
end
