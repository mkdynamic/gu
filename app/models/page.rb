class Page
  
  attr_accessor :id, :title, 
  attr_accessor :tags, :widgets, :parent
  attr_accessor :bp_data
  
  class << self
    def find(id)
      bp_data = Backpack.interface.show_page(id)
      Page.new(id, bp_data)
    end
    
    def find_by_trail(trail)
      pages = Backpack.interface.list_pages['pages'].first['page']
      if (p = pages.find { |p| p['title'].strip == trail })
        Page.find(p['id'].to_i)
      else
        return nil
      end
    end
  end
  
  def initialize(id, bp_data)
    @id, @bp_data = id, bp_data
  end
  
  def title
    load_title unless @title
    @title
  end
  
  def parent
    load_parent unless @parent
    @parent
  end
  
  # backpack data loaders
  def load_title
    bp_title = bp_data['page'].first['title']
    @title = bp_title.split('>').last.strip
  end
  
  def load_parent
    bp_title = bp_data['page'].first['title']
    trail = bp_title.split('>')
    trail.pop # remove this page title
    @parent = Page.find_by_trail(trail.join('>').strip)
  end
  
end