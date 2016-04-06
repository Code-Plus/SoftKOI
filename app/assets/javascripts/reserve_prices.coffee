# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  muestraReloj = ->
    fechaHora = new Date
    horas = fechaHora.getHours()
    minutos = fechaHora.getMinutes()
    segundos = fechaHora.getSeconds()
    sufijo = ' AM'
    if horas > 12
      horas = horas - 12
      sufijo = ' PM'
    if horas < 10
      horas = '0' + horas
    if minutos < 10
      minutos = '0' + minutos
    if segundos < 10
      segundos = '0' + segundos
    $('#reserve_start_time').val(horas+':'+minutos+' '+sufijo)
    return
  setTimeout muestraReloj, 1

  window.onload = ->
    setInterval muestraReloj, 60000
    return

  $('#interval').change ->
    fechaHora = new Date
    horas = fechaHora.getHours()
    minutos = fechaHora.getMinutes()
    segundos = fechaHora.getSeconds()
    sufijo = ' AM'
    if horas > 12
      horas = horas - 12
      sufijo = ' PM'
    if horas < 10
      horas = '0' + horas
    if minutos < 10
      minutos = '0' + minutos
    if segundos < 10
      segundos = '0' + segundos
    inter = parseInt($('#interval option:selected').text())
    var_start_time = $('#reserve_start_time').val()
    if var_start_time != ''
      split_time = var_start_time.split(':')
      second_split = split_time[1]
      split_time_f = second_split.split(' ')
      rel_fin = parseInt(split_time_f[0])
      sum_rel_fin = rel_fin + inter
      if sum_rel_fin >= '60'
        h_split = parseInt(split_time[0])
        h_split_f = h_split + 1
        fin = sum_rel_fin - 60
        send_ini = parseInt('00')
        seconds = send_ini + fin
        if seconds < 10
          seconds = '0' + seconds
        $('#reserve_end_time').val h_split_f+':'+seconds+' '+sufijo
      else
        h_split = parseInt(split_time[0])
        h_split_f = h_split + 1
        if h_split_f < 10
          h_split_f = '0' + h_split_f
        seconds = sum_rel_fin
        $('#reserve_end_time').val h_split_f+':'+seconds+' '+sufijo
    return
  return
