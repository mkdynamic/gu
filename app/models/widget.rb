class Widget

  attr_accessor :id, :bp_data
  attr_reader :content
  
  def initialize(id, bp_data)
    @id, @bp_data = id, bp_data
  end
  
  def content
    @content ||= load_content
  end
  
  protected
  
  def load_content
    bp_data['content']
  end
  
end