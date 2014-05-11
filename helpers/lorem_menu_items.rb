require 'json'

def lorem_menu_items( total_items: 20, root_items: 6 )

  # Create and array to store menu items, fill it and return it
  [].tap do |menu_items|

    # Filling the array with menu items, resulting in a flat array
    total_items.times do

      # Generating a unique name
      new_menu_item_name = loop do
        name_candidate = lorem_menu_item_name
        break name_candidate unless menu_items.any? { |item| item[:name] == name_candidate }
      end

      # Generating a new menu item and adding it to the array
      menu_items.push lorem_menu_item( name: new_menu_item_name )

    end

    # Stacking items into a hierarchy
    until menu_items.length == root_items do
      child_item = menu_items.delete_at rand(menu_items.length)
      parent_item = menu_items.sample
      parent_item[:children].push child_item
    end

  end

end