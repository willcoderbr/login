<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="config.Conexao"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8" %>
    
    <%String pag = "usuarios.jsp"; %>
<!DOCTYPE html>
<html>
	<head>
	
		
		<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">
		<link href="estilos.css" rel="stylesheet">
		<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
		
		<meta charset="ISO-8859-1">
		<title>Lista de usuários</title>
	</head>
<%
	Statement st = null;
	ResultSet rs = null;
%>
	<body>
	
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="usuarios.jsp">Lista de Usuários</a>
  <button class="navbar-toggler" type="button" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">

    </ul>
    <form class="form-inline my-2 my-lg-0">
    <span><small>
      <%
			String nomeUsuario = (String) session.getAttribute("nomeUsuario");
			out.print(nomeUsuario);
			
			if(nomeUsuario == null){
				response.sendRedirect("index.jsp");
			}
	   %>
	</small></span>
		
		<a href="logout.jsp"><i class="fas fa-sign-out-alt ml-1"></i></a>
		
    </form>
  </div>
</nav>

	<div class="container">
		<div class="row mt-4 mb-4">
		<a type="button" class="btn-info btn-sm ml-3" href="usuarios.jsp?funcao=novo">Novo Usuário</a>
		<form class="form-inline my-2 my-lg-0 direita" method="get">
      		<input class="form-control form-control-sm mr-sm-2" type="search" id="txtbuscar" name="txtbuscar" placeholder="Buscar pelo nome" aria-label="Search">
     	 	<button class="btn btn-outline-info btn-sm my-2 my-sm-0 d-none d-md-block" type="submit" id="btn-buscar" name="btn-buscar">Buscar</button>
   	    </form>
		</div>
		
		<div id="listar">
                                    
        </div>
		
		
	</div>
</body>
</html>

<!-- Modal -->

<div class="modal fade" id="modal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				
					<%  String titulo = "";
						String btn = "";
						String xid = "";	
						String xnome = "";	
						String xusuario = "";	
						String xsenha = "";	
						String xnivel = "Selecione um nível";	

					if(request.getParameter("funcao") != null && request.getParameter("funcao").equals("editar")) {
						titulo = "Editar Usuário";
						btn = "btn-editar";
						xid = request.getParameter("id");
						
						try{
						 	st = new Conexao().conectar().createStatement();
			                rs = st.executeQuery("SELECT * FROM usuarios where id = '"+ xid +"'");
			                while (rs.next()){
			                	xnome = rs.getString(2);
			                	xusuario = rs.getString(3);
			                	xsenha = rs.getString(4);
			                	xnivel = rs.getString(5);
			                }
			                }catch(Exception e){
			                   out.print(e);			
			                }
					}else{
						titulo = "Inserir Usuário";
						btn = "btn-salvar";
					}
				%>
				<h5 class="modal-title" id="exampleModalLabel"><%= titulo %></h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<form id="cadastro-form" class="form" method="post">
			<div class="modal-body">
			
			<input value="<%=xusuario %>" type="hidden" name="txtantigo" id="txtantigo">
							
				<div class="form-group">
						<label for="username">Nome</label><br>
						<input value="<%=xnome %>" type="text" name="txtnome" id="txtnome"
							class="form-control" required>
					</div>
				
					<div class="form-group">
						<label for="username">Usuario:</label><br>
						<input value="<%=xusuario %>" type="text" name="txtusuario" id="txtusuario"
							class="form-control" required>
					</div>
					<div class="form-group">
						<label for="password">Senha:</label><br> 
						<input value="<%=xsenha %>" type="text" name="txtsenha" id="txtsenha"
							class="form-control" required>
					</div>
					<div class="form-group">
						<label for="exampleFormControlSelect1">Nível</label> <select
							class="form-control" name="txtnivel" id="txtnivel" required>
							<option value="<%=xnivel %>"><%=xnivel %></option>							
							
							 <%
                                    if(!xnivel.equals("Comum")){
                                       out.print(" <option>Comum</option>");
                                    }
                                    if(!xnivel.equals("Admin")){
                                       out.print(" <option>Admin</option>");
                                                            }
                                                            
                             %>
							
						</select>
					</div>
				</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
				<button type="submit" name="<%=btn %>" class="btn btn-primary"><%=titulo %></button>
			</div>
			</form>
		</div>
	</div>
</div>

<% 
	if(request.getParameter("btn-salvar") != null){
		String usuario = request.getParameter("txtusuario");
        String senha = request.getParameter("txtsenha");
        String nivel = request.getParameter("txtnivel");
        String nome = request.getParameter("txtnome");
        
        try{
        	
            st = new Conexao().conectar().createStatement();
            rs = st.executeQuery("SELECT * FROM usuarios where usuario = '" + usuario + "'");
            while (rs.next()){            	
            	 rs.getRow();
            	 if(rs.getRow() > 0){
            		 out.print("<script>alert('Usuário já cadastrado!');</script>");
            		 return;
            	 }
            }
            st.executeUpdate("INSERT into usuarios (nome, usuario, senha, nivel) values ('" +nome+"', '"+usuario+"', '"+senha+"', '"+nivel+"') ");
            response.sendRedirect(pag);
            }catch(Exception e){
               out.print(e);			
            }
		
	}
%>

<% 
	if(request.getParameter("funcao") != null && request.getParameter("funcao").equals("excluir")) {
		
		String id = request.getParameter("id");
		
		 try{
	        	
	            st = new Conexao().conectar().createStatement();
	            st.executeUpdate("DELETE from usuarios where id = '" + id + "'");
	            
	            response.sendRedirect(pag);
	            }catch(Exception e){
	               out.print(e);			
	            }
	}
%>

<% 
	if(request.getParameter("funcao") != null && request.getParameter("funcao").equals("editar")) {
		out.print("<script>$('#modal').modal('show');</script>");
	}
%>

<% 
	if(request.getParameter("funcao") != null && request.getParameter("funcao").equals("novo")) {
		out.print("<script>$('#modal').modal('show');</script>");
	}
%>

<% 
	if(request.getParameter("btn-editar") != null){
		String usuario = request.getParameter("txtusuario");
        String senha = request.getParameter("txtsenha");
        String nivel = request.getParameter("txtnivel");
        String nome = request.getParameter("txtnome");
        String id = request.getParameter("id");
        String antigo = request.getParameter("txtantigo");        
        try{        	
            st = new Conexao().conectar().createStatement();
            if(!antigo.equals(usuario)){
            rs = st.executeQuery("SELECT * FROM usuarios where usuario = '" + usuario + "'");
            while (rs.next()){            	
            	 rs.getRow();
            	 if(rs.getRow() > 0){
            		 out.print("<script>alert('Usuário já cadastrado!');</script>");
            		 return;
            	 }
            }
            }
            st.executeUpdate("UPDATE usuarios SET nome = '" + nome + "', usuario = '" + usuario + "', senha = '" + senha + "', nivel = '" + nivel + "' where id = '"+ id +"' ");
            response.sendRedirect(pag);
            } catch (Exception e) {
               out.print(e);			
            }
		
	}
%>


<% // AJAX PARA LISTAR OS DADOS %>
	
		<script type="text/javascript">

          $(document).ready(function(){
                                  
           $.ajax({
           url: "ajax/listar.jsp",
           method: "post",
           data: $('#frm').serialize(),
           dataType: "html",
           success:function(result){
          	$('#listar').html(result);
          	
             		}
               })
                                  
          	})  
         </script>



<% // AJAX PARA BUSCAR OS DADOS PELO BOTÃO %>
				
								<script type="text/javascript">
                              
                                  $('#btn-buscar').click(function(event){
                                      event.preventDefault();
                                      $.ajax({
                                          url: "ajax/listar.jsp",
                                          method: "post",
                                          data: $('form').serialize(),
                                          dataType: "html",
                                          success:function(result){
                                              $('#listar').html(result);
                                          }
                                      })
                                  })
                                  
                               
                            	</script>




<% // AJAX PARA BUSCAR OS DADOS PELA TXT %>
								
								<script type="text/javascript">
                             
                                  $('#txtbuscar').keyup(function(){
                                     $('#btn-buscar').click();
                                  })
                             
                            	</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.js"></script>