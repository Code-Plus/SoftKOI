$(document).ready(function() {

	$('#sale_customer_id').select2({
		theme: "bootstrap"
	});

	$('#sale_customer_id').change(function(){
		var id_customer = $('#sale_customer_id option:selected').val();
		$.ajax({
			url: '/sales/customer',
			data:{customer:id_customer },
			type: 'get',
			DataType: 'json'
		}).done(function(done){
			var customer_firsname = done['firstname'];
			var customer_lastname = done['lastname'];
			var customer_doc = done['document'];
			$('#inf_customer_start').addClass('hidden');
			$('#inf_customer_end').removeClass('hidden');
			$('#info_customer_finish_name').text(customer_firsname+' '+customer_lastname);
			$('#info_customer_finish_doc').text(customer_doc);
		}).error(function(error){
			console.log('error al conectar con el servidor'+error);
		});

	});


	$('.input-group.date').datepicker({
   	autoclose: true,
		orientation: "bottom auto",
	});

	$('[data-toggle="tooltip"]').tooltip();
	$("#notice_wrapper").slideDown(400).delay(2000).slideUp("slow");

	$("#iconmenu").on("click",function(){
		$(".menusuperior").toggleClass("normal");
		$(".menusuperior").toggleClass("desplegado");
		$(".menulateral").toggleClass("normal");
		$(".menulateral").toggleClass("desplegado");
		$(".container1").toggleClass("normal");
		$(".container1").toggleClass("desplegado");
		$(".menu").toggleClass("normal");
		$(".menu").toggleClass("desplegado");
		$("li").toggleClass("Mnormal");
		$("li").toggleClass("Mdesplegado");
		$(".HomeM").toggleClass("Hnormal");
		$(".HomeM").toggleClass("Hdesplegado");
	});

	// Menu
	$('.McolorHoo').click(function(){
		$(this).trigger("hover");
	});


	$('table').DataTable({
		"language": {
			"sProcessing":     "Procesando...",
			"sLengthMenu":     "Mostrar  _MENU_  registros",
			"sZeroRecords":    "No se encontraron resultados",
			"sEmptyTable":     "Ningún dato disponible en esta tabla",
			"sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
			"sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
			"sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
			"sInfoPostFix":    "",
			"sSearch":         "Buscar:",
			"sUrl":            "",
			"sInfoThousands":  ",",
			"sLoadingRecords": "Cargando...",
			"oPaginate": {
				"sFirst":    "Primero",
				"sLast":     "Último",
				"sNext":     "Sigiente &nbsp;<i class='fa fa-angle-right'></i>",
				"sPrevious": "<i class='fa fa-angle-left'></i>&nbsp; Anterior"
			},
			"oAria": {
				"sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
				"sSortDescending": ": Activar para ordenar la columna de manera descendente"
			}
		}
	});



});
