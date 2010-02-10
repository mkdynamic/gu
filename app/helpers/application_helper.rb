# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def nav_item(page)
    content_tag "li", :class => (@page == page ? "active" : nil) do
      link_to textilize_without_paragraph(page.title), page.path
    end
  end
  
  # fix backpack links
  def linkify(content)    
    pattern = /(http:\/{2}mkdynamic\.backpackit\.com\/pages\/([0-9]+)\-[\-a-z0-9\#]+)/i
    linkified_content = content.dup
    content.scan(pattern).each do |url, id| 
      page = Page.find(id.to_i)
      linkified_content.gsub!(url, page.path)
    end
    linkified_content
  end
  
  def linkify_and_textilize(content)
    linkify textilize(content)
  end
  
end
