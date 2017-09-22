<%@page import="java.util.List"%>
<%@page import="dao.ConsoleDAO"%>
<%@page import="modelo.Console"%>
<%@page import="dao.JoystickDAO"%>
<%@page import="modelo.Joystick"%>
<%@include file="cabecalho.jsp" %>
<%
    Joystick obj = new Joystick();
    ConsoleDAO conDAO = new ConsoleDAO();
    List<Console> clista = conDAO.listar();
    
    try {
        if (request.getMethod().equals("POST")) {
            JoystickDAO dao = new JoystickDAO();
            obj.setId(Integer.parseInt(request.getParameter("txtId")));
            obj.setModelo(request.getParameter("txtModelo"));
            obj.setQuantidadeBotao(Integer.parseInt(request.getParameter("txtqtdBotao")));

            Console console = new Console();
            console.setNumSerie(Integer.parseInt(request.getParameter("selConsole")));
            obj.setConsoleId(console);
            
            dao.alterar(obj);
            response.sendRedirect("index.jsp");
        } else {
            if (request.getParameter("id") == null) {
                response.sendRedirect("index.jsp");
                return;
            }
            JoystickDAO dao = new JoystickDAO();
            obj = dao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("id")));

            if (obj == null) {
                response.sendRedirect("index.jsp");
                return;
            }
        }
    } catch (Exception e) {
        response.sendRedirect("upd.jsp?b=1");
    }
%>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">
            Gerenciamento de Joysticks
        </h1>
        <ol class="breadcrumb">
            <li>
                <i class="fa fa-dashboard"></i>  <a href="index.jsp">Área Administrativa</a>
            </li>
            <%
                if (request.getParameter("b") != null) {
            %>
            <li class="active">
                <i class="fa fa-file"></i> Erro ao atualizar o Joystick!
            </li>
            <%
                }
            %>
        </ol>
    </div>
</div>
<!-- /.row -->
<div class="row">
    <div class="panel panel-default">
        <div class="panel-heading">
            Joystick
        </div>
        <div class="panel-body">
            <form action="#" method="post">

                <div class="col-lg-6">
                    <div class="form-group">
                        <label>Id</label>
                        <input class="form-control" type="text" name="txtId" readonly value="<%=obj.getId()%>"/>
                    </div>

                    <div class="form-group">
                        <label>Modelo</label>
                        <input class="form-control" type="text" name="txtModelo" required value="<%=obj.getModelo()%>"/>
                    </div>
                    <div class="form-group">
                        <label>Quantidade de botões</label>
                        <input class="form-control" type="text" name="txtqtdBotao" required value="<%=obj.getQuantidadeBotao()%>"/>
                    </div>
                    <div class="form-group">
                        <label>Categoria</label>
                        <select name ="selConsole" class="form-control"> 
                            <option>Selecione</option>
<%
                                String marcadoC;
                                for (Console con : clista) {
                                    if (con.getNumSerie() == obj.getConsoleId().getNumSerie()) {
                                        marcadoC = "selected";
                                    } else {
                                        marcadoC = "";
                                    }
                            %>
                            <option value="<%=con.getNumSerie()%>"<%=marcadoC%>><%=con.getNome()%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    <button class="btn btn-primary btn-sm" type="submit">Salvar</button>
            </form>
        </div>
    </div>
</div>
<!-- /.row -->
<%@include file="../rodape.jsp" %>