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
		format: "yyyy/mm/dd"
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

	//payments

	$('.btn_payments').click(function(){
		var id_vent = $(this).attr('data-amount-saleid');
		$.ajax({
			url:'/sales/'+id_vent+'/make_payment_index',
			data:{sale_id:id_vent},
			type:'get'
		}).error(function(error){
			console.log('Error a conectar con el servidor revisar payment');
		});
	});

	// Agenda
	$('.day').click(function(){
		var data_of_tb = $(this).children('.event_description').children('.events_descriptions_data').text();
		var dia_of_tb = $(this).children('.day_of_mount').text();
		var split_date_start, split_date_final;
		split_date_start = $(this).children('#tb_date_finish').val();
		split_date_final = split_date_start.split('-');
		var date_tb = split_date_final[0]+'-'+split_date_final[1]+'-'+split_date_final[2];
		var modal = $('#modals_events');
		if(data_of_tb == ""){
			modal.modal();
			$('.day_numbeer').text("Eventos para el dia #"+dia_of_tb);
			$('.evenets').html('<p>No hay eventos para este dia...</p>');
			$('#btn_new_event_sss').click(function(){
				setTimeout(function(){
					$('#event_start_time').val(date_tb+'T'+'12:00');
				},100);
			});
		}else{
			modal.modal();
			$('.day_numbeer').text("Eventos para el dia #"+dia_of_tb);

			var data_of_modal = '';
			$(this).children('.event_description').children('.events_descriptions_data').each(function(){
			var id_modal_data = $(this).parent('.event_description').children('.events_descriptions_data_id').text();
			var start_time = $(this).parent('.event_description').children('.events_descriptions_data_start_time').text();
				data_of_modal += '<p id="body_evenet" style="height:40px;">'+start_time+' - '+$(this).text()+'<a class="options_modal_events" data-confirm="Estas seguro?" data-method="delete" href="/events/'+id_modal_data+'" style="float: right; color:red;">Eliminar</a></p>';
			});
			$('.evenets').html(data_of_modal);

			$('#btn_new_event_sss').click(function(){
				setTimeout(function(){
					$('#event_start_time').val(date_tb+'T'+'12:00');
				},100);
			});
		}
	});
});
