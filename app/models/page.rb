class Page
  
  @@cache = {}
  attr_accessor :id, :bp_data, :titie, :tags, :widgets, :parent, :children
  
  class << self  
    def home
      Page.find_by_trail('Home')
    end
    
    def to_slug(str)
      str.downcase.gsub(/[^A-Za-z0-9]/, ' ').strip.gsub(/\s+/, '-')
    end
    
    def ext
      '.html'
    end
    
    def find(id)
      fetch_or_cache_by_key("ID::" + id.to_s) do
        bp_data = Backpack.interface.show_page(id)
        Page.new(id, bp_data)
      end
    end
    
    def find_by_path(path)
      fetch_or_cache_by_key("PATH::" + path.to_s) do
        pages = Backpack.interface.list_pages['pages'].first['page']
        p = pages.detect { |p| ('/' + p['title'].split('>').map { |s| Page.to_slug(s) }.join('/') + Page.ext) == path }
        p ? Page.find(p['id'].to_i) : nil
      end
    end
    
    # trail is like 'Home > Foo > Bar'. i.e. page name in Backpack
    # case + whitespace tolerant
    def find_by_trail(trail)
      fetch_or_cache_by_key("TRAIL::" + trail.to_s) do
        pages = Backpack.interface.list_pages['pages'].first['page']
        p = pages.detect { |p| p['title'].downcase.squish == trail.downcase.squish }
        p ? Page.find(p['id'].to_i) : nil
      end
    end
    
    # case + whitespace tolerant
    def find_children_by_trail(trail)
      fetch_or_cache_by_key("CHILDREN_BY_TRAIL::" + trail.to_s) do
        pages = Backpack.interface.list_pages['pages'].first['page']
        children = pages.select { |p| p['title'].squish.match(/^#{trail.squish}\s*>\s*[^>]+$/i) }
        children.map { |c| Page.find(c['id'].to_i) }   
      end  
    end    
    
    def fetch_or_cache_by_key(key)
      @@cache[key] ||= yield
    end
  end
  
  def initialize(id, bp_data)
    @id, @bp_data = id, bp_data
  end
  
  # compare using Backpack ID's
  def ==(comp)
    if !self.nil? && !comp.nil?
      self.id == comp.id
    else
      super(comp)
    end
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
    Page.to_slug(title)
  end

  def path(rel = [])
    if parent == nil
      path = '/' 
      unless rel.empty?
        rel = [slug] + rel
        path << rel.join('/') + Page.ext
      end
      return path
    else
      parent.path([slug] + rel)
    end
  end
  
  def home?
    Page.home == self
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
        type = 'Attachment' if type == 'Asset'
        unless type == 'WriteboardLink'
          bp_widget = bp_data['page'].first[type.downcase.pluralize].first[type.downcase].find { |i| i['id'].to_i == id }
        else
          bp_widget = nil
        end
        klass = type.constantize
        arr << klass.new(id, bp_widget)
      end
    end
    return arr
  end
  
end