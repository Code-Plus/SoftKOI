// Instancio el tour y a su vez programo en un array los pasos a seguir
  var tour = new Tour({
    steps: [
    {
      element: "#HomeM",
      title: "Ir al Menu Principal",
      content: "Si Haces Click En Este Icono te llevara al la pantalla principal la cual es en la que nos encontramos en estos momentos."
    },
    {
      element: "#InventarioM",
      title: "Inventario",
      content: "Bueno continuando este boton sirve para ver el control de las existencias de tu negocio aqui podras ......."
    }
    ,
    {
      element: "#VentasM",
      title: "Ventas",
      content: "EN esta parte podras registrar las ventas / abonos y las demas entradas que tenga tu negocio ......."
    }
    ,
    {
      element: "#CambiosM",
      title: "Cambios",
      content: "Aqui vas a registrar los articulos que nesesiten ser cambiados ......."
    }
    ,
    {
      element: "#ConsolasM",
      title: "Consolas",
      content: "En esta seccion se registraran las reservas para las consolas de video juegos ......."
    }
    ,
    {
      element: "#PagosM",
      title: "Pagos - estadisticas",
      content: "En esta parte podras ver todos los reportes de las entradas......."
    },
    {
      element: "#UsuariosM",
      title: "Usuarios",
      content: "Aqui podras registrar un usuario nuevo en caso tal de que se requiera ......."
    },
    {
      element: "#AgendaM",
      title: "Agenda",
      content: "Tambien tienes una agenda la cual guardara tus tareas que tengas pendientes ......."
    },
    {
      element: "#SalirM",
      title: "Salir",
      content: "Y por ultimo el boton de cerrar sesion como su nombre indica es para cerrar tu sesion  ......."
    },
    {
      element: "#ImagenF",
      title: "Pagina Principal",
      content: "Como puedes ver esta es la pagina principal la cual se mostrara cada vez que inicias la sesion en esta pagina puedes ver algunos reportes de como van tus ventas y los ultimos recordatorios proximos a caducar en la agenda.  ......."
    },
    {
      element: "#inicioA",
      title: "Estadistica 1",
      content: "Bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla......."
    },
    {
      element: "#inicioB",
      title: "Estadistica ",
      content: "Bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla ......."
    },
    {
      element: "#ventasE",
      title: "Estadisticas Ventas",
      content: "Bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla  ......."
    },
    {
      element: "#NVentas",
      title: "Numero de Ventas",
      content: "Bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla  ......."
    },
    {
      element: "#EAgenda",
      title: "Recordatorios En la Agenda",
      content: "Bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla  ......."
    },
    {
      element: "#ImagenF",
      title: "Pagina Principal",
      content: "Como puedes ver es muy facil utilizar la pagina principal no hay ciencia en ella y lo mismo es para las paginas siguientes.  ....... TUTORIAL EN CONSTRUCCIÓN HASTA AQUI LLEGA LA DEMO........."
    }
  ]});


  // Inicializo el tour
  tour.init();

  // Comienzo el tour
  tour.start();
