# Ajax para traer el cliente en venta

$(document).ready ->
   $('#sale_customer_id').change ->
      id_customer = $('#sale_customer_id option:selected').val()
      $.ajax(
         url: '/sales/customer'
         data: customer: id_customer
         type: 'get'
         DataType: 'json'
      ).done((done) ->
         customer_firsname = done['firstname']
         customer_lastname = done['lastname']
         customer_doc = done['document']
         $('#inf_customer_start').addClass 'hidden'
         $('#inf_customer_end').removeClass 'hidden'
         $('#info_customer_finish_name').text customer_firsname + ' ' + customer_lastname
         $('#info_customer_finish_doc').text customer_doc
         return
      ).error (error) ->
         console.log 'error al conectar con el servidor' + error
         return
      return
   return
