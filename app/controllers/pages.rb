class Pages < Application

  # ...and remember, everything returned from an action
  # goes to the client...
  def show(path)
    @page = (path == '/' ? Page.home : Page.find_by_path(path))
    render
  end
  
end
