function resetForm(withKittens){
  var message = "lo sentimos no se reconoce el comando ingresado intentenlo nuevamente."
  var input = $('.404-input');

  if (withKittens == "gatos"){
    $('.kittens').removeClass('kittens');
    message = "Huzzzzzah Kittehs!"
  }else if(withKittens == "null"){
    message = " "
  }

  $('.new-output').removeClass('new-output');
  input.val('');
  $('.terminal').append('<p class="prompt">' + message + '</p><p class="prompt output new-output clickds"></p>');

  $('.new-output').velocity(
    'scroll'
  ), {duration: 100}
}

function exitform(){
  $('.container-console').addClass('hidden');
  clearform();
}

function clearform(){
  var input = $('.404-input');
  $('.terminal').html('<p class="prompt">Adminitrador@SoftKOI:-$ </p><p class="prompt output new-output clickds"></p>');
  input.val('');
}

  function showKittens(){
    $('.terminal').append("<div class='kittens'>"+
                 "<p class='prompt'>	                             ,----,         ,----,                                          ,---,</p>" +
                 "<p class='prompt'>       ,--.                ,/   .`|       ,/   .`|                     ,--.              ,`--.' |</p>" +
                 "<p class='prompt'>   ,--/  /|    ,---,     ,`   .'  :     ,`   .'  :     ,---,.        ,--.'|   .--.--.    |   :  :</p>" +
                 "<p class='prompt'>,---,': / ' ,`--.' |   ;    ;     /   ;    ;     /   ,'  .' |    ,--,:  : |  /  /    '.  '   '  ;</p>" +
                 "<p class='prompt'>:   : '/ /  |   :  : .'___,/    ,'  .'___,/    ,'  ,---.'   | ,`--.'`|  ' : |  :  /`. /  |   |  |</p>" +
                 "<p class='prompt'>|   '   ,   :   |  ' |    :     |   |    :     |   |   |   .' |   :  :  | | ;  |  |--`   '   :  ;</p>" +
                 "<p class='prompt'>'   |  /    |   :  | ;    |.';  ;   ;    |.';  ;   :   :  |-, :   |   \\ | : |  :  ;_     |   |  '</p>" +
                 "<p class='prompt'>|   ;  ;    '   '  ; `----'  |  |   `----'  |  |   :   |  ;/| |   : '  '; |  \\  \\    `.  '   :  |</p>" +
                 "<p class='prompt'>:   '   \\   |   |  |     '   :  ;       '   :  ;   |   :   .' '   ' ;.    ;   `----.   \\ ;   |  ;</p>" +
                 "<p class='prompt'>'   : |.  \\ |   |  '     '   :  |       '   :  |   '   :  ;/| '   : |  ; .'  /  /`--'  /  `--..`;  </p>" +
                 "<p class='prompt'>|   | '_\\.' '   :  |     ;   |.'        ;   |.'    |   |    \\ |   | '`--'   '--'.     /  .--,_   </p>" +
                 "<p class='prompt'>'   : |     ;   |.'      '---'          '---'      |   :   .' '   : |         `--'---'   |    |`.  </p>" +
                 "<p class='prompt'>;   |,'     '---'                                  |   | ,'   ;   |.'                    `-- -`, ; </p>" +
                 "<p class='prompt'>'---'                                              `----'     '---'                        '---`'</p>" +
                 "<p class='prompt'>                                                              </p></div>");


    var lines = $('.kittens p');
    $.each(lines, function(index, line){
      setTimeout(function(){
        $(line).css({
          "opacity": 1
        });

        textEffect($(line))
      }, index * 100);
    });
    setTimeout(function(){
      var gif;

      $.get('http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=kittens', function(result){
        gif = result.data.image_url;
        $('.terminal').append('<img class="kitten-gif" src="' + gif + '"">');
        resetForm("gatos");
      });
    }, (lines.length * 100) + 1000);
  }

  function softkoiurl(){
    var message = "Ingresa la url a la que deseas acceder";
    var input = $('.404-input');
    $('.new-output').removeClass('new-output');
    input.val('');
    $('.terminal').append('<p class="prompt">' + message + '</p>'+
    '<p class="prompt"> <input type="text" class="txtsoftkoiurl"> <a href="#" class="btn btn-primary" id="softkoiurla">Ir a</a> </p>'+
    '<p class="prompt output new-output clickds"></p>');
    $('#softkoiurla').click(function(){
      var url = $('.txtsoftkoiurl').val();
      window.location.href = "http://localhost:3000/"+url;
    });
  }

  function urlhelp(){
    $('.terminal').append("<div class='urlhelp'>"+
                 "<p class='prompt'>Utiliza ..[ url ].. para ir a una pagina dentro de softkoi</p>" +
                 "<p class='prompt'>El comando ..[ url ].. tiene 3 niveles los niveles se diferencian por un .</p>" +
                 "<p class='prompt'>El primer nuvel es solo ..[ url ].. y se utiliza para ir a un sitio dentro del mismo aplicativo, si se desea cambiar la funcion se tiene que acceder al segundo nivel agregandole al comando url un ..[ . ].. </p>" +
                 "<p class='prompt'>Los comando de segundo nivel sirven para especificar que accion va a hacer el usuario por ejm para buscar en SoftKOI poner el siguiente comando ..[ url.softkoi ].. hay diferentes palabras.</p>" +
                 "<p class='prompt'> </p>" +
                 "<p class='prompt'>Utiliza ..[ url.softkoi ].. para ir a una ruta dentro de softkoi o igual puedes utilizar solo el primer nivel que cumple la misma funcion</p>" +
                 "<p class='prompt'>Utliza ..[ url.google ].. para realizar una busqueda en el navegador utilizando google como motor de busqueda predeterminado.</p>" +
                 "<p class='prompt'>Utiliza ..[ url.youtube ].. para realizar una busqueda en la pagina de youtube</p>" +
                 "<p class='prompt'>Utiliza ..[ url.all ].. para ejecutar todos los comandos de url</p>" +
                 "<p class='prompt'> </p>" +
                 "<p class='prompt'>El comando ..[ url.softkoi ].. cuenta con el 3er nivel el cual es especificar que deseas hacer por ejemplo abrir la modal de registrar para eso utiliza en el 3er nivel ..[ url.softkoi.modal ]..</p>" +
                 "<p class='prompt'></p>" +
                 "<p class='prompt'>Utiliza ..[ url.softkoi.method ].. para ejecutar un metodo debes poner el path de la ruta por ejemplo reservation/new </p>" +
                 "<p class='prompt'></p>"+
                 "</div>");
      resetForm("null");
  }

  function consolehelp(){
    $('.terminal').append("<div class='consolehelp'>"+
                 "<p class='prompt'>Los comandos que puedes ejecutar en la consola son: </p>" +
                 "<p class='prompt'> </p>" +
                 "<p class='prompt'>..[ url ].. Abrir sitios o probar metodos.</p>" +
                 "<p class='prompt'>..[ clear ].. Limpiar la consola.</p>" +
                 "<p class='prompt'>..[ exit ].. Salir de la consola.</p>" +
                 "<p class='prompt'>..[ reload ].. Recargar la pagina.</p>" +
                 "<p class='prompt'>..[ translate...[ segundo nivel ].. ].. traducir palabras en este comando debes poner un segundo nivel.</p>" +
                 "<p class='prompt'>.</p>"+
                 "</div>");
          resetForm("null");
  }

  function transtaleurlespañol(){
    var message = "Ingresa la palabra o frase que quieres traducir del Ingles al Español";
    var input = $('.404-input');
    $('.new-output').removeClass('new-output');
    input.val('');
    $('.terminal').append('<p class="prompt">' + message + '</p>'+
    '<p class="prompt"> <input type="text" class="txttranslateurl"> <a href="#" class="btn btn-info" id="translateurla">Traducir</a> </p>'+
    '<p class="prompt output new-output clickds"></p>');
    $('#translateurla').click(function(){
      var tex = $('.txttranslateurl').val();
      window.open('https://translate.google.com/#en/es/'+tex,'_blank');
    });
  }

  function transtaleurlingles(){
    var message = "Ingresa la palabra o frase que quieres traducir del Español al Ingles";
    var input = $('.404-input');
    $('.new-output').removeClass('new-output');
    input.val('');
    $('.terminal').append('<p class="prompt">' + message + '</p>'+
    '<p class="prompt"> <input type="text" class="txttranslateurl"> <a href="#" class="btn btn-info" id="translateurla">Traducir</a> </p>'+
    '<p class="prompt output new-output clickds"></p>');
    $('#translateurla').click(function(){
      var tex = $('.txttranslateurl').val();
      window.open('https://translate.google.com/#es/en/'+tex,'_blank');
    });
  }

  function translatehelp(){
    $('.terminal').append('<div class="trasnlatehelp">'+
    '<p class="prompt">..[ translate.español ].. Utiliza este comando para traducir del Ingles al Español.</p>'+
    '<p class="prompt">..[ translate.ingles ].. Utiliza este comando para traducir del Español al Ingles.</p>'+
    '</div>');
    resetForm("null");
  }

  function translateerror(){
    $('.terminal').append('<div class="translateerror">'+
    '<p class="prompt">Debes especificar un segundo nivel para este comando los cuales son</p>'+
    '<p class="prompt">Español - Ingles</p>'+
    '<p class="prompt">Ingles - Español</p>'+
    '<p class="prompt"> </p>'+
    '<p class="prompt">Ingresa ..[ translate.help ].. Para ver la estructura del comando </p>'+
    '</div>');
    resetForm("null");
  }

  function softkoiurlmethod(m){

    switch (m) {
      case "method":
          var message = "Ingresa la url del metodo al que deseas acceder";
          var input = $('.404-input');
          $('.new-output').removeClass('new-output');
          input.val('');
          $('.terminal').append('<p class="prompt">' + message + '</p>'+
          '<p class="prompt"> <input type="text" class="txtsoftkoiurl"> <a href="#" class="btn btn-primary" id="softkoiurla">Ejecutar metodo</a> </p>'+
          '<p class="prompt output new-output clickds"></p>');
          $('#softkoiurla').click(function(){
            var url = $('.txtsoftkoiurl').val();
            $.ajax({
              url: "http://localhost:3000/"+url
            }).done(function(done){
              $('html').append(done);
            }).error(function(error){
              console.log('No se puede ejecutar el method ubicado en /'+url+' es posible que no estes en la vista que ejecuta ese metodo.');
            });
          });
        break;
      case "modal":
      var message = "Debes estar en una vista que ejecute modales";
      var input = $('.404-input');
      $('.new-output').removeClass('new-output');
      input.val('');
      $('.terminal').append('<p class="prompt">' + message + '</p>'+
      '<p class="prompt"> <input type="text" class="txtsoftkoiurl"> <a href="#" class="btn btn-primary" id="softkoiurla">Abrir modal</a> </p>'+
      '<p class="prompt output new-output clickds"></p>');
      $('#softkoiurla').click(function(){
        var url = $('.txtsoftkoiurl').val();
        $.ajax({
          url: "http://localhost:3000/"+url
        }).done(function(done){
          $('.terminal').append(done);
        }).error(function(error){
          console.log('No se puede ejecutar el method ubicado en /'+url+' es posible que no estes en la vista que ejecuta ese metodo.');
        });
      });
      break;
      default:
        var message = "Ingresa la url a la cual deseas acceder";
        var input = $('.404-input');
        $('.new-output').removeClass('new-output');
        input.val('');
        $('.terminal').append('<p class="prompt">' + message + '</p>'+
        '<p class="prompt"> <input type="text" class="txtsoftkoiurl"> <a href="#" class="btn btn-primary" id="softkoiurla">Buscar en Softkoi</a> </p>'+
        '<p class="prompt output new-output clickds"></p>');
        $('#softkoiurla').click(function(){
          var url = $('.txtsoftkoiurl').val();
          $.ajax({
            url: "http://localhost:3000/"+url
          }).done(function(done){
            $('html').append(done);
          }).error(function(error){
            console.log('No se puede ejecutar el method ubicado en /'+url+' es posible que no estes en la vista que ejecuta ese metodo.');
          });
        });
        break;
    }
  }

  function googleurl(){
    var message = "Ingresa lo que buscaras en google.";
    var input = $('.404-input');
    $('.new-output').removeClass('new-output');
    input.val('');
    $('.terminal').append('<p class="prompt">' + message + '</p>'+
    '<p class="prompt"> <input type="text" class="txtgoogleurl"> <a href="#" class="btn btn-success" id="googleurla">Buscar en Google</a> </p>'+
    '<p class="prompt output new-output clickds"></p>');
    $('#googleurla').click(function(){
      var url = $('.txtgoogleurl').val();
      window.open('https://www.google.com/search?q='+url,'_blank');
    });
  }

  function youtubeurl(){
    var message = "Ingresa el video que deseas buscar.";
    var input = $('.404-input');
    $('.new-output').removeClass('new-output');
    input.val('');
    $('.terminal').append('<p class="prompt">' + message + '</p>'+
    '<p class="prompt"> <input type="text" class="txtyoutubeurl"> <a href="#" class="btn btn-danger" id="youtubeurla">Buscar en Youtube</a> </p>'+
    '<p class="prompt output new-output clickds"></p>');
    $('#youtubeurla').click(function(){
      var url = $('.txtyoutubeurl').val();
      window.open('https://www.youtube.com/results?search_query='+url,'_blank');
    });

  }

  function textEffect(line){
    var alpha = [';', '.', ',', ':', ';', '~', '`'];
    var animationSpeed = 10;
    var index = 0;
    var string = line.text();
    var splitString = string.split("");
    var copyString = splitString.slice(0);

    var emptyString = copyString.map(function(el){
        return [alpha[Math.floor(Math.random() * (alpha.length))], index++];
    })

    emptyString = shuffle(emptyString);

    $.each(copyString, function(i, el){
        var newChar = emptyString[i];
        toUnderscore(copyString, line, newChar);

        setTimeout(function(){
          fromUnderscore(copyString, splitString, newChar, line);
        },i * animationSpeed);
      })
  }

  function toUnderscore(copyString, line, newChar){
    copyString[newChar[1]] = newChar[0];
    line.text(copyString.join(''));
  }

  function fromUnderscore(copyString, splitString, newChar, line){
    copyString[newChar[1]] = splitString[newChar[1]];
    line.text(copyString.join(""));
  }


  function shuffle(o){
      for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
      return o;
  };
