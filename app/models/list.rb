class List < Widget
  
  attr_accessor :name
  attr_accessor :items
  
  def name
    @name ||= load_name
  end
  
  def items
    @items ||= load_items
  end
  
  private
  
  def load_name
    bp_data['name']
  end
  
  def load_items
    arr = []
    bp_data['items'].first['item'].each do |item|
      id = item['id'].to_i
      content = item['content']
      completed = (item['completed'] == 'true')
      arr << ListItem.new(id, content, completed)
    end
    return arr
  end
  
end