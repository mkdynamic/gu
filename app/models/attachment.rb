class Attachment < Widget
  
  attr_accessor :filename
  
  def filename
    @filename ||= load_filename
  end
  
  def url(version = :original)
    path = File.join(*("%08d" % id).scan(/..../))
    u = Backpack.interface.username
    "http://#{u}.backpackit.com/attachments/#{path}/#{version.to_s}#{ext}/as/#{filename}"
  end
  
  def ext
    File.extname(filename)
  end
  
  private
  
  def load_filename
    bp_data['file_name']
  end
  
end