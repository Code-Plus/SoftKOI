var Mes1={
	 labels : ["Lunes","Martes","Miercoles","Jueves","Viernes","Sabado","Domingo"],


	datasets : [
		{//primer conjunto de datos
			fillColor:"rgb(0, 188, 212)",
			 strokeColor : "rgba(255,255,255,0.8)",
			//  highlightFill:"rgba(229, 137, 0,0.75)",
			//  highlightStroke:"rgba(229, 137,0,1)",
			data :[10,20,30,40,50,40,5]
		}/*,
		{//segundo conjunto de datos
			fillColor:"rgba(151,147,205,0.5)",
			strokeColor : "rgba(151,147,205,0.8)",
			highlightFill:"rgba(151,147,205,0.75)",
			highlightStroke:"rgba(151,147,205,1)",
			data :[15,18,20,11,24,20,31]
		}*/
	]
}

//mes 2
var Mes2={
	 labels : ["Lunes","Martes","Miercoles","Jueves","Viernes","Sabado","Domingo"],


	datasets : [
		{//primer conjunto de datos
			fillColor:"rgb(139, 195, 74)",
			 strokeColor : "rgba(255,255,255,0.8)",
			//  highlightFill:"rgba(229, 137, 0,0.75)",
			//  highlightStroke:"rgba(229, 137,0,1)",
			data :[50,20,30,40,70,100,5]
		}/*,
		{//segundo conjunto de datos
			fillColor:"rgba(151,147,205,0.5)",
			strokeColor : "rgba(151,147,205,0.8)",
			highlightFill:"rgba(151,147,205,0.75)",
			highlightStroke:"rgba(151,147,205,1)",
			data :[15,18,20,11,24,20,31]
		}*/




	]
}



// mes 3
var Mes3={
	 labels : ["Lunes","Martes","Miercoles","Jueves","Viernes","Sabado","Domingo"],


	datasets : [
		{//primer conjunto de datos
			fillColor:"rgb(229, 137, 0)",
			 strokeColor : "rgba(255,255,255,0.8)",
			//  highlightFill:"rgba(229, 137, 0,0.75)",
			//  highlightStroke:"rgba(229, 137,0,1)",
			data :[10,20,30,40,50,100,5]
		}/*,
		{//segundo conjunto de datos
			fillColor:"rgba(151,147,205,0.5)",
			strokeColor : "rgba(151,147,205,0.8)",
			highlightFill:"rgba(151,147,205,0.75)",
			highlightStroke:"rgba(151,147,205,1)",
			data :[15,18,20,11,24,20,31]
		}*/




	]
}


// meses pequeños


var Meses={
	 labels : ["Semana 1","Semana 2","Semana 3","Semana 4","Semana 5","Semana 6"],


	datasets : [
		{//primer conjunto de datos
			fillColor:"rgb(255, 255, 255)",
			 strokeColor : "rgba(220,220,220,0.8)",
			//  highlightFill:"rgba(220,220,220,0.75)",
			//  highlightStroke:"rgba(220,220,220,1)",
			data :[10,20,30,40,50,100,5]
		}
	]
}


var contexto = document.getElementById("canvas").getContext("2d");
var Meses1 = document.getElementById("pcanvas").getContext("2d");
var Meses2 = document.getElementById("pcanvas2").getContext("2d");
var Meses3 = document.getElementById("pcanvas3").getContext("2d");



window.Linea = new Chart(contexto).Line(Mes3,{showScale: true,responsive : true});
window.Bar = new Chart(Meses1).Bar(Meses,{showScale: false,responsive : true});
window.Bar = new Chart(Meses2).Bar(Meses,{showScale: false,responsive : true});
window.Bar = new Chart(Meses3).Bar(Meses,{showScale: false,responsive : true});
