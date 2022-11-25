class HomeController < ApplicationController

  before_action :authenticate_user!, only: [:dasboard]

  def index
  end

  def dashboard
  end
end
