require 'widget'
class Attachment < Widget
  
  attr_accessor :filename
  
  def filename
    @filename ||= load_filename
  end
  
  private
  
  def load_filename
    bp_data['file_name']
  end
  
end