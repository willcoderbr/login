
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="config.Conexao"%>

<% String pag = "usuarios.jsp"; %>
<% String buscar = request.getParameter("txtbuscar"); %>

<%
            Statement st = null;
            ResultSet rs = null;
        %>

<% out.print(" <table class='table table-sm table-striped'>"
                                    +"<thead>"
                                        +"<tr>"
                                            +"<th scope='col'>Nome</th>"
                                            +"<th scope='col'>Usuário</th>"
                                            +"<th scope='col'>Senha</th>"
                                            +"<th class='d-none d-md-block' scope='col'>Nível</th>"
                                            +"<th scope='col'>Ações</th>"
                                        +"</tr>"
                                    +"</thead>"
                                    +"<tbody>" ); 
                                                                                  
                                                try {
                                                st = new Conexao().conectar().createStatement();
                                                if (buscar != null) {
                                                   buscar = '%' + buscar + '%';
                                                    rs = st.executeQuery("SELECT * FROM usuarios where nome LIKE '" + buscar + "' order by nome asc");
                                                } else {
                                                    rs = st.executeQuery("SELECT * FROM usuarios order by nome asc");
                                                }
                                                while (rs.next()) {
                                            out.print("<tr>");
                                            
                                            out.print("<td>"+rs.getString(2)+"</td>");
                                            out.print("<td>"+rs.getString(3)+"</td>");
                                            out.print("<td>"+rs.getString(4)+"</td>");
                                            out.print("<td class='d-none d-md-block'>"+rs.getString(5)+"</td>");
                                           
                                            
                                            out.print("<td>");
                                            out.print("<a href='"+pag+"?funcao=editar&id="+rs.getString(1)+"' class='text-info'><i class='far fa-edit'></i></a>");
                                            out.print("<a href='"+pag+"?funcao=excluir&id="+rs.getString(1)+"' class='text-danger'><i class='far fa-trash-alt'></i></a>");
                                            out.print("</td>");
                                                    
                                             out.print("</tr>");
                                          
                                        }
                                            } catch (Exception e) {
                                                out.print(e);
                                            }
                                       
                                    out.print("</tbody>"
                                +"</table>");     
%>