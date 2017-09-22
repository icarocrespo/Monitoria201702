<%@page import="java.math.BigDecimal"%>
<%@page import="dao.ConsoleDAO"%>
<%@page import="modelo.Console"%>
<%@include file="cabecalho.jsp" %>
<%
    Console obj = new Console();
    try {
        if (request.getMethod().equals("POST")) {
            ConsoleDAO dao = new ConsoleDAO();
            obj.setNumSerie(Integer.parseInt(request.getParameter("txtNumSerie")));
            obj.setNome(request.getParameter("txtNome"));
            obj.setMarca(request.getParameter("txtMarca"));

            Double valor = 0.0;
            valor = Double.parseDouble(request.getParameter("txtValor"));
            obj.setValor(new BigDecimal(valor));

            dao.alterar(obj);
            response.sendRedirect("index.jsp");
        } else {
            if (request.getParameter("NumSerie") == null) {
                response.sendRedirect("index.jsp");
                return;
            }
            ConsoleDAO dao = new ConsoleDAO();
            obj = dao.buscarPorChavePrimaria(Integer.parseInt(request.getParameter("NumSerie")));

            if (obj == null) {
                response.sendRedirect("index.jsp");
                return;
            }
        }
    }catch(Exception e){
        response.sendRedirect("upd.jsp?b=1");
    }
%>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">
            Gerenciamento de Consoles
        </h1>
        <ol class="breadcrumb">
            <li>
                <i class="fa fa-dashboard"></i>  <a href="index.jsp">Área Administrativa</a>
            </li>
            <%
                if(request.getParameter("b") != null){
            %>
            <li class="active">
                <i class="fa fa-file"></i> Erro ao atualizar o Console!
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
            Console
        </div>
        <div class="panel-body">
            <form action="#" method="post">
                <div class="col-lg-6">
                    <div class="form-group">
                        <label>Número de série</label>
                        <input class="form-control" type="text" name="txtNumSerie" readonly value="<%=obj.getNumSerie()%>"/>
                    </div>
                    <div class="form-group">
                        <label>Nome</label>
                        <input class="form-control" type="text" name="txtNome" required value="<%=obj.getNome()%>"/>
                    </div>
                    <div class="form-group">
                        <label>Marca</label>
                        <input class="form-control" type="text" name="txtMarca" required value="<%=obj.getMarca()%>"/>
                    </div>
                    <div class="form-group">
                        <label>Valor de mercado</label>
                        <input class="form-control" type="text" name="txtValor" required value="<%=obj.getValor()%>"/>
                    </div>
                    <button class="btn btn-primary btn-sm" type="submit">Salvar</button>
                </div>
            </form>
        </div>
    </div>
    <!-- /.row -->
    <%@include file="../rodape.jsp" %>