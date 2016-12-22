class PagesController < ApplicationController

  #layout "startup"

  def home
    @home_page = true
  end

  def about
    @about_page = true
  end

end