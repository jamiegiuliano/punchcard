class MerchantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:new, :edit, :update, :destroy]

  def index
    if !params[:location].blank?
      @merchants = user_merchants.by_location(params[:location])
    else
      @merchants = user_merchants
    end
  end

  def new
    @merchant = @user.merchants.build
  end

  def create
    @merchant = user_merchants.build(merchant_params)
    if !@merchant.link.url.empty? && @merchant.save
      redirect_to authenticated_root_path
    else
      render :new
    end
  end

  def edit
    @merchant = Merchant.find_by(id: params[:id])
  end

  def update
    @merchant = Merchant.find_by(id: params[:id])
    if @merchant.update(merchant_params)
      redirect_to authenticated_root_path, notice: 'Merchant was successfully updated.'
    else
      render :edit
    end
  end

  def favorite
    Scraper.scrape_activity(user_merchants)
    @favorite = user_merchants.current_favorite
  end

  def destroy
    @merchant = Merchant.find_by(id: params[:id])
    name = @merchant.name

    @merchant.delete
    redirect_to merchants_path(current_user), notice: "#{name} deleted successfully."
  end

  private
  def set_user
    @user = current_user
  end

  def merchant_params
    params.require(:merchant).permit(:user_id, :name, :location, link_attributes: [:url])
  end

  def user_merchants
    current_user.merchants
  end
end
