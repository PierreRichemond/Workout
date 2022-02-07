class HomeController < ApplicationController
  def index
    @athletes = User.paginate(page: params[:page])
  end
end
