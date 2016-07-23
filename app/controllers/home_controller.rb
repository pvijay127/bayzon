require 'amazon'
require 'ebay'

class HomeController < ApplicationController
  def search
  end

  def fetch_sellers
    query = params[:query]
    begin
      @product_name = product_name(query)
    rescue Exception => ex
      logger.error ex.backtrace
      flash[:warning] = "There was a problem fetching the product name from ebay"
      render :search and return
    end

    begin
      @products = find_sellers(@product_name)
      flash[:success] = "Displaying sellers in Amazon for product #{@product_name}"
      render :index
    rescue Exception => ex
      logger.error ex.backtrace
      flash[:warning] = "There was a problem fetching sellers from Amazon for product named '#{@product_name}'"
      render :search and return
    end
  end

  def index
  end
end
