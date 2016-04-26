$(document).ready(function() {

	//Calcular el total de la venta cuando se agregar o retiran productos
	function calculate_total() {
		var sum = 0;
		$('.input-price').each (function(){
			var t = $(this).find("input:eq(0)").val();
			sum += parseInt(t.replace(".",""));
		});
		$('#sale_amount').val(sum);
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

			form_data['product'] = product_name + "<input type='hidden' name='tblproducto[]' id='tblproducto' value='"+product_name+"'>";

			form_data['price'] = product_price +"<input type='hidden' name='tblprecio[]' id='tblprecio' value='"+product_price+"'>";

			form_data['eliminar'] = "<input type='button' value='eliminar' class='tbncerrar btn btn-danger'></input>";

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
	$(document).on('click', '.input-eliminar', function(){
		var tr = $(this).closest('tr');
		r.fadeOut(200, function(){
			tr.remove();
			calculate_total()
		});
	});
});
