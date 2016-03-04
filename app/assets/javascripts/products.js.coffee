$('#product_category_id').parent().hide()
  categories = $('#product_category_id').html()

  $('#category_type_product_id').change ->
    type_products = $('#category_type_product_id :selected').text()
    escaped_type_products = type_products.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(categories).filter("optgroup[label='#{escaped_category}']").html()
    
    if options
      $('#product_category_id').html(options)
      $('#product_category_id').parent().show()
    else
      $('#product_category_id').empty()
      $('#product_category_id').parent().hide()
