<html>
<%@page import="utils.Position" %>
<head>
</head>
<script type="text/javascript">
    
    /*function lerArquivo(){ 
          try{
        	  var arquivo = document.getElementById('arquivo').value;
        	  var fso = new CreateObject("Scripting.FileSystemObject");    
              arquivoTxt = fso.OpenTextFile(arquivo, 1, false, 0);
              var conteudo = arquivoTxt.ReadAll();  document.write(conteudo);  
              arquivoTxt.Close();
              fso = null;
          } catch (e){
        	  document.writeln(e.message);
          }
          
    }*/
        
</script>
<body>
<script type="text/javascript">

	try{
		<%
    	Position position = new Position();
    	%>
    	var teste = <%=position%>
    	document.write(teste.latitude);
	}catch(e)
	{
		document.write(e.message);
	}
    
    
</script>
<!-- input type="file" value="arquivo" id="arquivo">
<br><br>
<input type="button" value ="exibir conteudo arquivo" onclick="lerArquivo()"> -->
</body>
</html>