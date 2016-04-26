# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

  $('div.inline.pull-right').addClass 'm_r_b_reservas'
  $('div.m_r_b_reservas').click ->
    setTimeout cargar_elemento, 1000

  return

cargar_elemento = ->
  if $('#new_reserve').length
    Cargar_En_Reserva()
  return
return
