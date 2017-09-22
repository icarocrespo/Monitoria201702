<%@page import="java.util.List"%>
<%@page import="dao.ConsoleDAO"%>
<%@page import="modelo.Console"%>
<%@page import="dao.JoystickDAO"%>
<%@page import="modelo.Joystick"%>
<%@include file="cabecalho.jsp" %>
<%
    ConsoleDAO cDAO = new ConsoleDAO();
    List<Console> clista = cDAO.listar();

    try {
        if (request.getParameter("txtModelo") != null) {
            JoystickDAO dao = new JoystickDAO();
            Joystick obj = new Joystick();

            obj.setModelo(request.getParameter("txtModelo"));
            obj.setQuantidadeBotao(Integer.parseInt(request.getParameter("txtqtdBotao")));

            Console console = new Console();
            console.setNumSerie(Integer.parseInt(request.getParameter("selConsole")));
            obj.setConsoleId(console);
            
            dao.incluir(obj);
            response.sendRedirect("index.jsp");
        }
    } catch (Exception e) {
        response.sendRedirect("add.jsp?a=1");
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
                if (request.getParameter("a") != null) {
            %>
            <li class="active">
                <i class="fa fa-file"></i> Erro ao inserir o Joystick!
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
                        <label>Modelo</label>
                        <input class="form-control" type="text" name="txtModelo" required />
                    </div>

                    <div class="form-group">
                        <label>Quantidade de botões</label>
                        <input class="form-control" type="text" name="txtqtdBotao" required />
                    </div>

                    <div class="form-group">
                        <label>Console</label>
                        <select name ="selConsole" class="form-control"> 
                            <option>Selecione</option>
                            <%
                                for (Console con : clista) {
                            %>
                            <option value="<%=con.getNumSerie()%>" ><%=con.getNome()%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>

                    <button class="btn btn-primary btn-sm" type="submit">Salvar</button>
                </div>
            </form>
        </div>
    </div>
    <!-- /.row -->
    <%@include file="../rodape.jsp" %>