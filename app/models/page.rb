class Page
  
  attr_accessor :id, :title
  attr_accessor :tags, :widgets, :parent, :children
  attr_accessor :bp_data
  
  class << self
    def find(id)
      bp_data = Backpack.interface.show_page(id)
      Page.new(id, bp_data)
    end
    
    def find_by_trail(trail)
      pages = Backpack.interface.list_pages['pages'].first['page']
      p = pages.find { |p| p['title'] == trail }
      return (p ? Page.find(p['id'].to_i) : nil)
    end
    
    def find_children_by_trail(trail)
      pages = Backpack.interface.list_pages['pages'].first['page']
      r = /^#{trail}\s+>\s+[^>]+$/
      children = pages.select { |p| p['title'].match(r) }
      return children.map { |c| Page.find(c['id'].to_i) }     
    end
  end
  
  def initialize(id, bp_data)
    @id, @bp_data = id, bp_data
  end
  
  def title
    @title ||= load_title
  end
  
  def parent
    @parent ||= load_parent
  end
  
  def children
    @children ||= load_children
  end
  
  def tags
    @tags ||= load_tags
  end 
  
  def widgets
    @widgets ||= load_widgets
  end
  
  def slug
    title.downcase.gsub(/[^A-Za-z0-9]/, ' ').strip.gsub(/\s+/, '-')
  end

  def path(rel = [])
    if parent == nil
      path = '/' 
      unless rel.empty?
        rel = [slug] + rel
        path << rel.join('/') + ext
      end
      return path
    else
      parent.path([slug] + rel)
    end
  end
  
  def ext
    '.html'
  end
  
  private

  # backpack data loaders  
  def load_title
    bp_title = bp_data['page'].first['title']
    bp_title.split('>').last.strip
  end
  
  def load_parent
    bp_title = bp_data['page'].first['title']
    trail = bp_title.split('>')
    trail.pop # remove this page title
    Page.find_by_trail(trail.join('>').strip)
  end
  
  def load_children
    bp_title = bp_data['page'].first['title']
    Page.find_children_by_trail(bp_title)    
  end
  
  def load_tags
    if (tags = bp_data['page'].first['tags'])
      tags.first['tag'].map { |t| t['name'] }
    else
      return []
    end
  end
  
  def load_widgets
    arr = []
    if (widgets = bp_data['page'].first['belongings'])
      widgets.first['belonging'].each do |w|
        id = w['widget'].first['id'].to_i
        type = w['widget'].first['type']
        unless type == 'WriteboardLink'
          bp_widget = bp_data['page'].first[type.downcase.pluralize].first[type.downcase].find { |i| i['id'].to_i == id }
        else
          bp_widget = nil
        end
        klass = Extlib::Inflection.constantize(type)
        arr << klass.new(id, bp_widget)
      end
    end
    return arr
  end
  
end