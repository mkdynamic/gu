class ListItem
  
  attr_accessor :id, :completed, :content
  
  def initialize(id, content, completed = false)
    @id, @content, @completed = id, content, completed
  end
  
  def completed?
    !!@completed
  end
  
end