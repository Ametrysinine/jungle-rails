class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']

  def show
    @product_count = Product.all.size
    @category_count = Category.all.size
  end
end
