<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page import="java.io.FileInputStream" %>
<%@page import="utils.Functions" %>
<%@page import="utils.Position" %>
<%@page import="java.util.Vector" %>

<% Vector<Position> positions = new Vector<Position>();%>
 <head> 
      <meta http-equiv="content-type" content="text/html; charset=UTF-8"/> 

      <title>Introdução a Google Maps - CriarWeb</title> 

      <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=ABQIAAAA6anCkVyidsSJCA_dEzdF3BRi3wpk5lbMH8syDB3v1sMtT0NrVxQ-2yj4eNoqQ7-NcGDbUw9HBWjh7A" type="text/javascript"></script>
      <script type="text/javascript"> //SVG functions
       
      	var map;
      
       	function init(evt) {
    	    if ( window.svgDocument == null ) {
    	      svgDocument = evt.target.ownerDocument;
    	    }
    	}
       
      	function MakeTransparent(name) {
      		var element = svgDocument.getElementById(name);
      		element.setAttributeNS(null,"opacity","0.5");
    	}

    	function MakeOpaque(name) {
    		var element = svgDocument.getElementById(name);
      		element.setAttributeNS(null,"opacity","1");
    	}
    	
    	
      </script>
   </head> 

   <body> 
       <div id="map" style="width: 800px; height: 600px"></div>
       <div id="distancia" style="width: 800px; height: 30px"> 
       <script type="text/javascript"> 
                
       
      			var opcoes_poligono = {geodesic:true};
      			
      			
      			
				<%
					FileInputStream fstream = new FileInputStream("C:\\Users\\Carlos\\Downloads\\GPS 08-11 18.13.41.txt");
					positions = Functions.readGPS(fstream);
				  	
					Functions.normalizeGPS(positions);
					String alturas = "";
			  		String velocidades = "";

			  		%>
			  		var coordenadas = [];
			  		<%
					if(positions != null){
						
				  		for(int i=0;i<positions.size();i++){
				  			%>
				  				coordenadas = coordenadas.concat(new GLatLng(<%=positions.get(i).getLatitude()%>,
				  											   <%=positions.get(i).getLongitude()%>));
				  			<%
				  			alturas = alturas.concat(positions.get(i).getX() + "," + positions.get(i).getyAltitude() + " ");
				  			velocidades = velocidades.concat(positions.get(i).getX() + "," + positions.get(i).getySpeed() + " ");
				  		}
					  	%>
				  		
				  		map = new GMap2(document.getElementById("map")); 
						map.setMapType(G_NORMAL_MAP);
						map.addControl(new GLargeMapControl3D());
						map.setUIToDefault();
						map.setCenter(new GLatLng(<%=positions.get(positions.size()/2).getLatitude()%>,
										<%=positions.get(positions.size()/2).getLongitude()%>), 18);
						
						var markerInicio = new GMarker(new GLatLng(<%=positions.get(0).getLatitude()%>,
												<%=positions.get(0).getLongitude()%>),G_DEFAULT_ICON);
						map.addOverlay(markerInicio);
						
					  	var markerFim = new GMarker(new GLatLng(<%=positions.get(positions.size()-1).getLatitude()%>,
					  							<%=positions.get(positions.size()-1).getLongitude()%>),G_DEFAULT_ICON);
						map.addOverlay(markerFim);
					  	
						var poligono = new GPolyline(coordenadas,
					             "#0000cc", 3, 0.7, opcoes_poligono); 
						map.addOverlay(poligono);
						
						var comprimento = poligono.getLength();
						document.write("Distância percorrida: " + comprimento + " metros.");
						<%
					}
					else
					{
						out.println("Erro - positions é null");
					}
			  		%>
    </script> 
    </div>
	<svg width="800" height="200" version="1.1"
			xmlns="http://www.w3.org/2000/svg" onload="init(evt)" >
	  		<polyline id="altitude" points="<%=alturas%>" style="fill:none;stroke:green;stroke-width:3" 
	  			onmouseover="MakeTransparent('altitude')" onmouseout="MakeOpaque('altitude')"/>
	  		<polyline id="speed" points="<%=velocidades%>" style="fill:none;stroke:red;stroke-width:3" 
	  			onmouseover="MakeTransparent('speed')" onmouseout="MakeOpaque('speed')"/>
	  		<!-- rect id="aux" x="0" y="0" width="800" height="200" fill="black" opacity="0"
	  			onmouseover="createMarker(evt.offsetX)"/>-->
	</svg>
   </body> 
</html> 