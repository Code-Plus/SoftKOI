require 'will_paginate/view_helpers/link_renderer'

module WillPaginate
  module ViewHelpers
    class LinkRenderer
      protected
      def page_number(page)
        page == current_page ? tag(:span, page, class: 'active item') : link(page, page, class: 'item', rel: rel_value(page))
      end
      
      def gap
        tag(:span, '...', class: 'disabled item')
      end
      
      def previous_page
        num = @collection.current_page > 1 && @collection.current_page - 1
        previous_or_next_page(:left, num)
      end
      
      def next_page
        num = @collection.current_page < total_pages && @collection.current_page + 1
        previous_or_next_page(:right, num)
      end
      
      def previous_or_next_page(left_or_right, page)
        class_names = 'icon item'
        icon = tag(:i, '', class: "icon #{left_or_right} arrow")

        page ? link(icon, page, class: class_names) : tag(:span, icon, class: class_names)
      end
      
      def html_container(html)
        pagination = tag(:div, html, container_attributes.merge({ class: 'ui blue pagination menu' }))
        tag(:div, pagination, class: 'ui aligned basic segment')
      end
    end
  end
end