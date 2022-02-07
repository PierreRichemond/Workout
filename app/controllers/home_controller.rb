class HomeController < ApplicationController
  def index
    @athletes = User.all
  end
end
