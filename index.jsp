<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="config.Conexao"%>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link href="estilologin.css" rel="stylesheet">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<%
	Statement st = null;
	ResultSet rs = null;
%>

<body>
    <div id="login">
        <div class="container">
            <div id="login-row" class="row justify-content-center align-items-center">
                <div id="login-column" class="col-md-6">
                    <div id="login-box" class="col-md-12">
                        <form id="login-form" class="form" action="index.jsp" method="post">
                            <h3 class="text-center text-info">Login</h3>
                            <div class="form-group">
                                <label for="username" class="text-info">Usuario:</label><br>
                                <input type="text" name="txtusuario" id="txtusuario" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="password" class="text-info">Senha:</label><br>
                                <input type="password" name="txtsenha" id="txtsenha" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="remember-me" class="text-info"><span>Lembrar?</span>�<span><input id="remember-me" name="remember-me" type="checkbox"></span></label><br>
                                <input type="submit" name="submit" class="btn btn-info btn-md" value="Logar">
                            </div>
                            <div id="register-link" class="text-right">
                                <a href="#" class="text-info">Cadastre-se</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <p align="center" class="text-light mt-2">
            	
            	<%
            	
            	String usuario = request.getParameter("txtusuario");
                String senha = request.getParameter("txtsenha");
                String nomeUsuario = "";                		
                String user = "", pass = "";
                int i = 0;    
                
                try{
                	
                st = new Conexao().conectar().createStatement();
                rs = st.executeQuery("SELECT * FROM usuarios where usuario = '"+usuario+"' and senha = '"+senha+"' ");
                while (rs.next()){
                	user = rs.getString(3);
                	pass = rs.getString(4);
                	nomeUsuario = rs.getString(2);
                	rs.last();
                	i = rs.getRow();
                }
                }catch(Exception e){
                   out.print(e);			
                }
                
           	
				if (usuario == null || senha == null ){
                
				}else {
                	  
                if(i > 0 || usuario.equals(user) && senha.equals(pass)){
                		  session.setAttribute("nomeUsuario", nomeUsuario);
                		  response.sendRedirect("usuarios.jsp");
                }else{
                	 	 out.println("Dados incorretos!");
                }
                }
				
            	%>   
            	    
            </p>
        </div>
    </div>
</body>
