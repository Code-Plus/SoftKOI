$(document).ready(function() {

	$(document).on("keypress", '.item_search_input', function(){
	  $('.item_search').click();
	});

	$(document).on("keypress", '.customer_input', function(){
	  $('.customer_search').click();
	});

	$(document).on("change", "#sale_comments_comment", function(){
		$('.sale_comments').click();
	});


	// Descuento de la venta
	$(document).on("change", "#sale_discount", function(){
		$.ajax({
      type: "POST",
      url: '/sales/sale_discount',
      data: { sale_discount: { discount: $(this).val(), sale_id: $(document).find('.sale_id').html() }},
      dataType: "script",
      success: function() { console.log('Se ha efectuado el descuento.'); }
    });
	});

});
