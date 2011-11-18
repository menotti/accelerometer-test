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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Teste</title>
</head>
	<body>
	<%
	String coordenadasx = "";
	String coordenadasy = "";
	String coordenadasz = "";
	String coordenadas = "";
	
		try{
		  // Open the file that is the first 
		  // command line parameter
		  FileInputStream fstream = new FileInputStream("C:\\Users\\Carlos\\Downloads\\Acc 08-11 08.44.36.txt");
		  // Get the object of DataInputStream
		  DataInputStream in = new DataInputStream(fstream);
		  BufferedReader br = new BufferedReader(new InputStreamReader(in));
		  String strLine = br.readLine();
		  
		  int i = 1;
		  //Read File Line By Line
		  while ((strLine = br.readLine()) != null && i<1000)   {
		  // Print the content on the console
		  		String strx = (String)strLine.subSequence(0, 12);
		  		strx = strx.replace(',', '.');
		 		float x = Float.valueOf(strx)*5 + 100;
		  		coordenadasx = coordenadasx.concat(i++ + "," + x + " ");
		  		
		  		String stry = (String)strLine.subSequence(12, 24);
		  		stry = stry.replace(',', '.');
		 		float y = Float.valueOf(stry)*5 + 300;
		  		coordenadasy = coordenadasy.concat(i + "," + y + " ");
		  		
		  		String strz = (String)strLine.subSequence(24, 36);
		  		strz = strz.replace(',', '.');
		 		float z = Float.valueOf(strz)*5 + 400;
		  		coordenadasz = coordenadasz.concat(i + "," + z + " ");
		  		
		  		float total = (x*x + y*y + z*z)*0.001f + 300;
		  		coordenadas = coordenadas.concat(i + "," + total + " ");
		  }
		  //Close the input stream
		  in.close();
		  
		  }catch (Exception e){//Catch exception if any
		  	System.err.println("Error: " + e.getMessage());
		  }%>
		<svg xmlns="http://www.w3.org/2000/svg" version="1.1">
	  		<polyline points="<%=coordenadasx%>" style="fill:none;stroke:green;stroke-width:1" />
	  		<polyline points="<%=coordenadasy%>" style="fill:none;stroke:red;stroke-width:1" />
	  		<polyline points="<%=coordenadasz%>" style="fill:none;stroke:blue;stroke-width:1" />
	  		<polyline points="<%=coordenadas%>" style="fill:none;stroke:black;stroke-width:1" />
		</svg>
	</body>
</html>