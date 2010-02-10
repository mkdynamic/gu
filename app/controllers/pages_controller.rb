class PagesController < ApplicationController
  
  caches_page :show
  
  def show
    absolute_path = "/" + params[:path].join("/")
    @page = begin
      if absolute_path == "/"
        Page.home
      else
        Page.find_by_path(absolute_path)
      end
    end
  end
  
end
