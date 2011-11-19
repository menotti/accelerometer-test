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

	var teste = "";
	teste.concat("teste 1");
	teste = teste.concat("teste 2");
	document.writeln(teste);
    
    
</script>
<!-- input type="file" value="arquivo" id="arquivo">
<br><br>
<input type="button" value ="exibir conteudo arquivo" onclick="lerArquivo()"> -->
</body>
</html>