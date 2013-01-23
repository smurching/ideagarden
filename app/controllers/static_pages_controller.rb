class StaticPagesController < ApplicationController

  def home
    render :template => 'static_pages/home', :layout => false
  end

end
