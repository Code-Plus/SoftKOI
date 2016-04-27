$(document).ready(function() {

	// Select autocomplete
	$('#sale_customer_id').select2({
		theme: "bootstrap"
	});

	$('#items_product_id').select2({
		theme: "bootstrap"
	});

	// Datepicker
	$('.input-group.date').datepicker({
   	autoclose: true,
		orientation: "bottom auto",
		format: "dd/mm/yyyy"
	});

	// Tooltip y alerta
	$('[data-toggle="tooltip"]').tooltip();
	$("#notice_wrapper").slideDown(400).delay(2000).slideUp("slow");

	// Menu lateral izquierdo
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

	$('.McolorHoo').click(function(){
		$(this).trigger("hover");
	});

	//Datatable
	$('#datatable').DataTable({
		"language": {
			"sProcessing":     "Procesando...",
			"sLengthMenu":     "Mostrar  _MENU_  registros",
			"sZeroRecords":    "No se encontraron resultados",
			"sEmptyTable":     "Ningún dato disponible en esta tabla",
			"sInfo":           "_TOTAL_ registros en total.",
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
