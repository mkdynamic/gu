require 'widget'
class Gallery < Widget
  
  attr_accessor :name
  attr_accessor :images
  
  def name
    @name ||= load_name
  end
  
  def images
    @images ||= load_images
  end
  
  private
  
  def load_name
    bp_data['name']
  end
  
  def load_images
    arr = []
    bp_data['images'].first['image'].each do |image|
      id = image['id'].to_i
      filename = image['file_name']
      desc = image['description']
      arr << Image.new(id, filename, desc)
    end
    return arr
  end
  
end