class PhotosController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  def index
    @photos = Photo.all.includes(:user, :challenges).order('created_at DESC')
  end

  def show
  end

  #def destroy
  #  @photo.destroy
  #  respond_to do |format|
  #    format.html { redirect_to photos_url }
  #    format.json { head :no_content }
  #  end
  #end

  private
  def set_photo
    @photo = Photo.includes(:user).find(params[:id])
  end
end
