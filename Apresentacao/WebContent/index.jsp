<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Apresentação</title>
</head>
<body>
<div>
	<h3 style="font-family:verdana;">Acelerômetro</h3>
	<form action="Acelerometro.jsp" method="get">
		<input name="local" type="text" value="Caminho completo do arquivo" size="50"></input>
		<input type="submit" value="Ir" name="Ir"></input>
	</form>
</div>
<div>
	<h3 style="font-family:verdana;">GPS</h3>
	<form action="GPS.jsp" method="get">
		<input name="local" type="text" value="Caminho completo do arquivo" size="50"></input>
		<input type="submit" value="Ir" name="Ir"></input>
	</form>
</div>
</body>
</html>