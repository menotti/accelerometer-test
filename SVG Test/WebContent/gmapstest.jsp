<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page import="java.io.FileInputStream" %>
<%@page import="java.io.DataInputStream" %>
<%@page import="java.io.BufferedReader" %>
<%@page import="java.io.InputStreamReader" %>

 <head> 
      <meta http-equiv="content-type" content="text/html; charset=UTF-8"/> 

      <title>Introdução a Google Maps - CriarWeb</title> 

      <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=ABQIAAAA6anCkVyidsSJCA_dEzdF3BRi3wpk5lbMH8syDB3v1sMtT0NrVxQ-2yj4eNoqQ7-NcGDbUw9HBWjh7A" type="text/javascript"></script>
      <script type="text/javascript">
       
     	var map;
      	var positions = [];     
      	var passo;
      	var marker;
      	      	
      	var myIcon = new GIcon(G_DEFAULT_ICON);
        myIcon.image = "http://4.bp.blogspot.com/_N3XQ5L0Zxeg/S9RFttKDzWI/AAAAAAAAAis/DLysdwl4XeQ/s400/180px-Cactuar.png";
        myIcon.iconSize = new GSize(30,35);
        
		var markerOptions = { icon:myIcon };
		
		
       	function init(evt) {
    	    if ( window.svgDocument == null ) {
    	      svgDocument = evt.target.ownerDocument;
    	    }
    	}
     
      	function MakeTransparent(name) {
      		var element = svgDocument.getElementById(name);
      		element.setAttributeNS(null,"opacity","0.5");
      		element.setAttributeNS(null,"stroke-width","5");
    	}

    	function MakeOpaque(name) {
    		var element = svgDocument.getElementById(name);
      		element.setAttributeNS(null,"opacity","1");
      		element.setAttributeNS(null,"stroke-width","3");
    	}

    	function normalizeGPS(){
    		
    		var maxAltitude = positions[0].altitude;
    		var minAltitude = positions[0].altitude;
    		
    		var maxSpeed = positions[0].speed;
    		var minSpeed = positions[0].speed; 
    		
    		for(var i=1;i<positions.length;i++)
    		{
    			var altitude = positions[i].altitude;
    			var speed = positions[i].speed;
    			
    			if(maxAltitude < altitude)
    				maxAltitude = altitude;
    			else if(minAltitude > altitude)
    				minAltitude = altitude;
    			
    			if(maxSpeed < speed)
    				maxSpeed = speed;
    			else if(minSpeed > speed)
    				minSpeed = speed;
    		}

    		passo = 800/positions.length;
    		
    		for(var i=0;i<positions.length;i++)
    		{
    			positions[i].x=passo*i;
    			
    			var alt = positions[i].altitude;
    			alt -= minAltitude;
    			alt /= (maxAltitude-minAltitude);
    			alt *= 200;
    			alt = 200 - alt;
    			positions[i].yAltitude = alt;
    			
    			var vel = positions[i].speed;
    			vel -= minSpeed;
    			vel /= (maxSpeed - minSpeed);
    			vel *= 200;
    			vel = 200 - vel;
    			positions[i].ySpeed = vel;
    		}
    	}
    	
    	function mouseOver(x){
    		var pos = Math.floor(x/passo);
    		marker = new GMarker(new GLatLng(positions[pos].latitude,
					positions[pos].longitude),markerOptions);
    		
			map.addOverlay(marker);
    	}
    	
    	function removeMarker(){
    		map.removeOverlay(marker);
    	}
    	
		function infos(evt){
    		
    		var element = svgDocument.getElementById('info');
    		if(evt.offsetX<690){
    			element.setAttributeNS(null,"x",evt.offsetX+20);	
    		}
    		if(evt.offsetY<120){
    			element.setAttributeNS(null,"y",evt.offsetY);
    		}
      		
      		element = svgDocument.getElementById('textAlt');
      		if(evt.offsetX<690){
      			element.setAttributeNS(null,"x",evt.offsetX+30);
      		}
      		if(evt.offsetY<120){
    			element.setAttributeNS(null,"y",evt.offsetY+20);
    		}
      		
      		element = svgDocument.getElementById('textVel');
      		if(evt.offsetX<690){
      			element.setAttributeNS(null,"x",evt.offsetX+30);
      		}
      		if(evt.offsetY<120){
    			element.setAttributeNS(null,"y",evt.offsetY+45);
    		}
      		
      		element = svgDocument.getElementById('textTmp');
      		if(evt.offsetX<690){
      			element.setAttributeNS(null,"x",evt.offsetX+30);
      		}
      		if(evt.offsetY<120){
    			element.setAttributeNS(null,"y",evt.offsetY+70);
    		}
      		
      		var pos = Math.floor(evt.offsetX/passo);
      		
      		svgDocument.getElementById('textAlt').firstChild.data = "Alt: " + positions[pos].altitude + "m";
      		svgDocument.getElementById('textVel').firstChild.data = "Vel: " + positions[pos].speed + "m/s";
      		svgDocument.getElementById('textTmp').firstChild.data = "Tmp: " + (positions[pos].time-positions[0].time)/1000 + "s";
      		
    	}
      </script>
      
   </head> 

   <body> 
       <div id="map" style="width: 800px; height: 600px"></div>
       
       <div id="distancia" style="width: 800px; height: 30px; font-family: verdana; font-size: 12; font-weight: bold" > 
       <script type="text/javascript"> 

      			
      			
			try{
				<%
					FileInputStream fstream = new FileInputStream("C:\\Users\\Carlos\\Downloads\\GPS 18-11 16.36.53.txt");
					DataInputStream in = new DataInputStream(fstream);
			  		BufferedReader br = new BufferedReader(new InputStreamReader(in));

			  		String strLine = br.readLine();

			  		while ((strLine = br.readLine())!=null){%>

			  			var position = new Object();
				  			
				  		position.latitude = <%=Double.valueOf(strLine.substring(0, 12).replace(',', '.'))%>;
				  		position.longitude = <%=Double.valueOf(strLine.substring(12, 24).replace(',', '.'))%>;
				  		position.altitude = <%=Float.valueOf(strLine.substring(24, 33).replace(',', '.'))%>;
				  		position.speed = <%=Float.valueOf(strLine.substring(33,39).replace(',', '.'))%>;
				  		position.time = <%=Long.valueOf(strLine.substring(56, 69))%>;
					  	
					  	positions = positions.concat(position);
					<%}%>

					normalizeGPS(positions);
					
					var alturas = "";
			  		var velocidades = "";
			  		
			  		var coordenadas = [];

					if(positions != null){

			  			for(var i=0;i<positions.length;i++){
				  			
				  			coordenadas = coordenadas.concat(new GLatLng(positions[i].latitude,
												positions[i].longitude));
				  			alturas = alturas.concat(positions[i].x + "," + positions[i].yAltitude + " ");
				  			velocidades = velocidades.concat(positions[i].x + "," + positions[i].ySpeed + " ");
				  			
				  		}
					  	
				  		map = new GMap2(document.getElementById("map"));
						map.setMapType(G_NORMAL_MAP);
						map.addControl(new GLargeMapControl3D());
						map.setUIToDefault();
						map.setCenter(new GLatLng(positions[0].latitude,
										positions[0].longitude), 18);
						
						var markerInicio = new GMarker(new GLatLng(positions[1].latitude,
												positions[1].longitude),G_DEFAULT_ICON);
						map.addOverlay(markerInicio);
						
					  	var markerFim = new GMarker(new GLatLng(positions[positions.length-1].latitude,
										positions[positions.length-1].longitude),G_DEFAULT_ICON);
						map.addOverlay(markerFim);
						
						var opcoes_poligono = {geodesic:true};
						var poligono = new GPolyline(coordenadas,
					             "#0000cc", 3, 0.7, opcoes_poligono); 
						map.addOverlay(poligono);
						
						var comprimento = poligono.getLength();
						document.write("Distância percorrida: " + comprimento + " metros.");
						
					}
					else
					{
						document.writeln("Erro - positions é null");
					}
       			}
       			catch(e)
       			{
       				document.writeln(e.message);
       			}
    </script> 
    </div>
    
    <script type="text/javascript">
    document.writeln("<svg width=\"800\" height=\"200\" version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" onload=\"init(evt)\" >");
    document.writeln("<polyline id=\"speed\" points=\"0,200 " + velocidades + " 800,200\" "+
    				"style=\"fill:red;fill-opacity:0.3;stroke:red;stroke-width:3\""+
    				"onmouseover=\"MakeTransparent('speed');mouseOver(evt.offsetX)\" "+
    				"onmouseout=\"MakeOpaque('speed');removeMarker()\" "+
    				"onmousemove=\"removeMarker(evt.offsetX);mouseOver(evt.offsetX);infos(evt)\"/>");
    document.writeln("<polyline id=\"altitude\" points=\"0,200 " + alturas + " 800,200\" "+
    				"style=\"fill:green;fill-opacity:0.3;stroke:green;stroke-width:3\" "+
    				"onmouseover=\"MakeTransparent('altitude');mouseOver(evt.offsetX)\" "+
    				"onmouseout=\"MakeOpaque('altitude');removeMarker()\" "+
    				"onmousemove=\"removeMarker(evt.offsetX);mouseOver(evt.offsetX);infos(evt)\"/>");
	document.writeln("<rect id=\"info\" x=\"0\" y=\"0\" width=\"100\" height=\"80\" "+
					"style=\"fill:grey;stroke-width:3;stroke:black;stroke-opacity:0.7;fill-opacity:0.5\"/>");
	document.writeln("<text id=\"textAlt\" x=\"10\" y=\"10\" font-family=\"Verdana\" font-size=\"12\" font-weight=\"bold\"> </text>");
	document.writeln("<text id=\"textVel\" x=\"10\" y=\"40\" font-family=\"Verdana\" font-size=\"12\" font-weight=\"bold\"> </text>");
	document.writeln("<text id=\"textTmp\" x=\"10\" y=\"70\" font-family=\"Verdana\" font-size=\"12\" font-weight=\"bold\"> </text>");
    document.writeln("</svg>");
   	</script>
  </body> 
</html> 