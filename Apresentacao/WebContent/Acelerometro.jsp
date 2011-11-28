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
<title>Acelerômetro</title>
<style type="text/css">
.estilo {
	height:200px;
	width:1000px;
}
</style>
</head>
	<body>
	<%
	String coordenadasx = "";
	String coordenadasy = "";
	String coordenadasz = "";
	
		try{
		  // Open the file that is the first 
		  // command line parameter
		  FileInputStream fstream = new FileInputStream("C:\\Users\\Carlos\\Desktop\\Acc 27-11 20.07.42.txt");
		  // Get the object of DataInputStream
		  DataInputStream in = new DataInputStream(fstream);
		  BufferedReader br = new BufferedReader(new InputStreamReader(in));
		  String strLine = br.readLine();
		  boolean ler = true;
		  int i = 0;
		  
		  while(ler){
			  %><div class="estilo">
	 			<svg xmlns="http://www.w3.org/2000/svg" version="1.1"><%
		  //Read File Line By Line
		  	//long currTime = 0;
		  	//long lastTime = 0;
			  while ((strLine = br.readLine()) != null && i<1000)   {
			  // Print the content on the console
			  		String strx = strLine.substring(0, 12);
			  		strx = strx.replace(',', '.');
			 		float x = 100 - 5*Float.valueOf(strx);
				  		
			  		String stry = strLine.substring(12, 24);
			  		stry = stry.replace(',', '.');
			 		float y = 100 - 5*Float.valueOf(stry);
			  		
			  		String strz = strLine.substring(24, 36);
			  		strz = strz.replace(',', '.');
			 		float z = 100 - 5*Float.valueOf(strz);
			 		
			 		/*String strt = strLine.substring(37, 50);
			 		long time = Long.valueOf(strt);
			  		
			 		currTime = time;*/
			  		
			 		
			  		//float total = 100 - x*5;
		 			
			 		coordenadasx = coordenadasx.concat(i++ + "," + x + " ");
			 		coordenadasy = coordenadasy.concat(i++ + "," + y + " ");
			 		coordenadasz = coordenadasz.concat(i++ + "," + z + " ");
			 		
		 			i++;
		 			if(i%40==0){//currTime-lastTime>=500000000){
		 				%>
	 					<polyline points="<%=i%>,0 <%=i%>,200" style="fill:none;stroke:black;stroke-width:1" />
	 					<%
	 					//lastTime=currTime;
		 			}
			  }
		  %>
					<polyline points="<%=coordenadasx%>" style="fill:none;stroke:red;stroke-width:2" />
					<polyline points="<%=coordenadasy%>" style="fill:none;stroke:green;stroke-width:2" />
					<polyline points="<%=coordenadasz%>" style="fill:none;stroke:blue;stroke-width:2" />
					<polyline points="0,100 1000,100" style="fill:none;stroke:black;stroke-width:1" />
					<polyline points="0,0 0,200" style="fill:none;stroke:black;stroke-width:1" />
					<polyline points="1000,0 1000,200" style="fill:none;stroke:black;stroke-width:1" />
					<polyline points="0,200 1000,200" style="fill:none;stroke:black;stroke-width:3" />
					
					<polyline points="0,0 1000,0" style="fill:none;stroke:black;stroke-width:1" />
					<text x="5" y="13" font-family="Verdana" font-size="12"> 20</text>
					<polyline points="0,50 1000,50" style="fill:none;stroke:black;stroke-width:1" />
					<text x="5" y="47" font-family="Verdana" font-size="12"> 10</text>
					<polyline points="0,150 1000,150" style="fill:none;stroke:black;stroke-width:1" />
					<text x="0" y="147" font-family="Verdana" font-size="12">-10</text>
					<text x="0" y="195" font-family="Verdana" font-size="12">-20</text>
					
					<text x="30" y="13" font-family="Verdana" font-size="12" 
								font-weight="bold" fill="red">x</text>
					<text x="45" y="13" font-family="Verdana" font-size="12" 
								font-weight="bold" fill="green">y</text>
					<text x="60" y="13" font-family="Verdana" font-size="12" 
								font-weight="bold" fill="blue">z</text>
		  		</svg>
		  </div>
		  <%
		  	if(i<1000)
		  		ler = false;
	  	  	coordenadasx = "";
	  	  	coordenadasy = "";
	  		coordenadasz = "";
	  	  	i = 0;
		  }
		  //Close the input stream
		  in.close();
		  
		  }catch (Exception e){//Catch exception if any
		  	System.err.println("Error: " + e.getMessage());
		  }%>
	</body>
</html>