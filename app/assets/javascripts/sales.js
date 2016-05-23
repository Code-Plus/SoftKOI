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

		var valor = $(this).val();
		if(valor == ""){
			$(this).val(0);
		}else{
			//Nothing to do here jiji
		}
	});


	// Crear nuevo item para la venta
	var input = $('#search_item_name')[0]
	var sale_id = parseInt($('#search_sale_id')[0].value)
  Awesomplete.$.bind(input, {
	  "awesomplete-selectcomplete": function(evt) {
	   $.ajax({
	      type: "GET",
	      url: '/sales/create_line_item',
	      data: { product_id: parseInt(input.value.split(".|")[0]), quantity: 1, sale_id: sale_id},
	      dataType: "script",
	      success: function() {
	      	input.value = "";
	      }
	    });
	  }
	});

	// Asociar un cliente a la venta
	var input_customer = $('#search_customer_name')[0]
  Awesomplete.$.bind(input_customer, {
	  "awesomplete-selectcomplete": function(evt) {
	   $.ajax({
	      type: "GET",
	      url: '/sales/create_customer_association',
	      data: { customer_id: parseInt(input_customer.value.split(".|")[0]), sale_id: sale_id},
	      dataType: "script",
	      success: function() {
	      	input.value = "";
	      }
	    });
	  }
	});

});
