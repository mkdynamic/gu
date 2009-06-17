class Note < Widget
  
  attr_accessor :title
  
  def title
    @title ||= load_title
  end
  
  private
  
  def load_title
    bp_data['title']
  end
  
end