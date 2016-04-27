$(document).ready(function() {

	//Calcular el total de la venta cuando se agregar o retiran productos
	function calculate_total() {
		var sum = 0;
		$('.input-total_price').each (function(){
			var t = $(this).find("input:eq(0)").val();
			sum += parseInt(t.replace(".",""));
		});
		$('#sale_amount').val(sum);

		var total_amount = $('#sale_amount').val() - $('#sale_discount').val()
		$('#sale_total_amount').val(total_amount);
	}

	//Agregar productos a la tabla de "sale"
	$('#addtotable').click(function(){
		var id_product = $('#items_product_id option:selected').val();

		$.ajax({
			url: '/items/product',
			data:{ product: id_product },
			type: 'get',
			DataType: 'json'
		}).done(function(done){
			var product_name = done['name'];
			var product_price = done['price'];

			var form_data={};

			form_data['product'] = product_name + "<input type='hidden' name='tblproduct[]' id='tblproduct' value='"+product_name+"'>";

			form_data['price'] = "<span id='unit_price'>"+product_price+"</span><input type='hidden' name='tblprice[]' id='tblprice' value='"+product_price+"'>";

			form_data['quantity'] = "<div id='mas' class='btn btn-primary btn-xs'><i class='fa fa-plus-circle'></i></div> &nbsp; <input type='number' name='tblquantity[]' id='tblquantitys' class='quantity_sale form-control input-sm' value='1' onkeyup='miabuelo(this.value)' readonly> &nbsp; <div id='menos' class='btn btn-primary btn-xs'><i class='fa fa-minus-circle'></i></div>"

			form_data['total_price'] = "<span id='unit_prices'>"+product_price+"</span><input type='hidden'  name='tbltotal_price[]' id='tbltotal_price' value='"+product_price+"'>";

			form_data['delete'] = "<div class='tbncerrar btn btn-sm bold btn-danger'><i class='fa fa-close'></i></div>";

			var row = $('<tr></tr>');

			$.each(form_data,function(tipo,valor){
				$('<td class="input-'+tipo+'" id="input-'+tipo+'"></td>').html(valor).appendTo(row);
			});

			$('#products > tbody:last').append(row);
			calculate_total();

		}).error(function(error){
			console.log('error al conectar con el servidor'+ error);
		});
	});


	//eliminar un producto del detalle de la venta
	$(document).on('click', '.input-delete', function(){
		var tr = $(this).closest('tr');
		tr.fadeOut(200, function(){
			tr.remove();
			calculate_total()
		});
	});

	$('#sale_discount').keyup(function(){

		var amount = $('#sale_amount').val();
      var total_amount = amount - $(this).val();
      $('#sale_total_amount').val(total_amount);
	});





});
