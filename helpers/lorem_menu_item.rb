def lorem_menu_item_name
  lorem.words rand(2) + 1
end

def lorem_menu_item( props = {} )

  # Create a hash representing a menu item, fill it with properties and return
  {}.tap do |menu_item|

    menu_item[:name]     = props[:name]     || lorem_menu_item_name
    menu_item[:id]       = props[:id]       || menu_item[:name].gsub(' ', '_')
    menu_item[:url]      = props[:url]      || 'http://google.ru/'
    menu_item[:children] = props[:children] || []

  end

end