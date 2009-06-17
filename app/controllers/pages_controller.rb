class PagesController < ApplicationController
  
  caches_page :show
  
  def show
    path = "/" + params[:path].join("/")
    @page = (path == "/") ? Page.home : Page.find_by_path(path)
  end
  
end
