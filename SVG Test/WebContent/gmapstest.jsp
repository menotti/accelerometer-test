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
       
var j=1;

      	var map;
      	var positions = [];     
      	var passo;
      	var marker;

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
    			alt /= maxAltitude;
    			alt *= 200;
    			alt = 200 - alt;
    			positions[i].yAltitude=alt;
    			
    			var vel = positions[i].speed;
    			vel -= minSpeed;
    			vel /= maxSpeed;
    			vel *= 200;
    			vel = 200 - vel;
    			positions[i].ySpeed = vel;
    		}
    	}
    	
    	function makeMarker(x){
    		var pos = Math.floor(x/passo);
    		marker = new GMarker(new GLatLng(positions[pos].latitude,
					positions[pos].longitude),G_DEFAULT_ICON);
			map.addOverlay(marker);
    	}
    	
    	function removeMarker(){
    		map.removeOverlay(marker);
    	}

      </script>
   </head> 

   <body> 
       <div id="map" style="width: 800px; height: 600px"></div>
       
       <div id="distancia" style="width: 800px; height: 30px"> 
       <script type="text/javascript"> 

       			var teste = "teste";
       			
      			var opcoes_poligono = {geodesic:true};
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
    document.writeln("<polyline id=\"speed\" points=\"" + velocidades + "\" style=\"fill:none;stroke:red;stroke-width:3\" onmouseover=\"MakeTransparent('speed');makeMarker(evt.offsetX)\" onmouseout=\"MakeOpaque('speed');removeMarker()\"/>");
    document.writeln("<polyline id=\"altitude\" points=\"" + alturas + "\" style=\"fill:none;stroke:green;stroke-width:3\" onmouseover=\"MakeTransparent('altitude');makeMarker(evt.offsetX)\" onmouseout=\"MakeOpaque('altitude');removeMarker()\"/>");
    document.writeln("</svg>");</script>
   </body> 
</html> 