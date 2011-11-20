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
        function change(text)
    {
    	document.getElementById("test").firstChild.data = text;
    }
</script>
<body>
<h1 id="test">ha!</h1>
<script type="text/javascript">

	change(1.123456/4);
    
</script>

<!-- input type="file" value="arquivo" id="arquivo">
<br><br>
<input type="button" value ="exibir conteudo arquivo" onclick="lerArquivo()"> -->
</body>
</html>