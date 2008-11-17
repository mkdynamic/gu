module Merb
  module GlobalHelpers
    require 'redcloth'
    
    # helpers defined here available to all views.  
    def textilize(str)
      RedCloth.new(str.to_s).to_html
    end
  end
end
