class Image
  
  attr_accessor :id, :filename, :description
  
  def initialize(id, filename, description = '')
    @id, @filename, @description = id, filename, description
  end
  
  def url(version = :original)
    path = File.join(*("%08d" % id).scan(/..../))
    u = Backpack.interface.username
    "http://#{u}.backpackit.com/images/#{path}/#{version.to_s}.jpg/as/#{filename}"
  end
  
end