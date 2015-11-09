var iniciosAAA={
	 labels : ["Lunes","Martes","Miercoles","Jueves","Viernes","Sabado","Domingo"],
	datasets : [
		{//primer conjunto de datos
			fillColor:"rgb(0, 188, 212)",
			 strokeColor : "rgba(255,255,255,0.8)",
			//  highlightFill:"rgba(229, 137, 0,0.75)",
			//  highlightStroke:"rgba(229, 137,0,1)",
			data :[10,20,30,40,50,40,5]
		},
		{//segundo conjunto de datos
			fillColor:"rgba(151,147,205,0.5)",
			strokeColor : "rgba(151,147,205,0.8)",
			highlightFill:"rgba(151,147,205,0.75)",
			highlightStroke:"rgba(151,147,205,1)",
			data :[15,18,20,11,24,20,31]
		}

	]
}

var inicioAA = document.getElementById("inicioA").getContext("2d");

window.Bar = new Chart(inicioAA).Bar(iniciosAAA,{showScale: false,responsive : true});
