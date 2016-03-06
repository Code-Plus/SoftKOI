$(document).on 'ready', ->
  $.ajax
    url: 'products/new'
    data: search: $(this).val()
    success: (data) ->
      jQuery ->
        $('#product_category_id').parent().hide()
        categories = $('#product_category_id').html()
        $('#category_type_product_id').change ->
           type_product = $('#category_type_product_id :selected').text()
           escaped_type_product = type_product.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
           options = $(categories).filter("optgroup[label='#{escaped_type_product}']").html()
           if options
              $('#product_category_id').html(options)
              $('#product_category_id').parent().show()
           else
              $('#product_category_id').empty()
              $('#product_category_id').parent().hide()
      return
  return
