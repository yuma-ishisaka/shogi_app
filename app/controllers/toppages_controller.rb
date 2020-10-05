class ToppagesController < ApplicationController
  def index
    if logged_in?
      redirect_to categories_path
    end
  end
end
