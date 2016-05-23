$(document).ready(function() {


	load_datatable();

	$('#registerevent').click(function(){
		$('#myModal').modal();
	});

	// Select autocomplete
	$('#sale_customer_id').select2({
		theme: "bootstrap"
	});

	$('#items_product_id').select2({
		theme: "bootstrap"
	});

	// Datepicker
	$('.datepicker').datepicker({
   	autoclose: true,
		orientation: "bottom auto",
		format: "dd/mm/yyyy"
	});

	//datetimepicker
  $('.datetimepicker').datetimepicker();

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

	// Agenda

	$('.day').click(function(){
		var data_of_tb = $(this).children('.event_description').children('.events_descriptions_data').text();
		var dia_of_tb = $(this).children('.day_of_mount').text();
		var modal = $('#modals_events');
		if(data_of_tb == ""){
			modal.modal();
			$('.day_numbeer').text("Eventos para el dia #"+dia_of_tb);
			$('.evenets').children('#body_evenet').text('No hay eventos para este dia...');
		}else{
			modal.modal();
			$('.day_numbeer').text("Eventos para el dia #"+dia_of_tb);
			$('.evenets').children('#body_evenet').text(data_of_tb);
		}
	});
});
