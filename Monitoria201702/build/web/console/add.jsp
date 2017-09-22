<%@page import="java.math.BigDecimal"%>
<%@page import="dao.ConsoleDAO"%>
<%@page import="modelo.Console"%>
<%@include file="cabecalho.jsp" %>
<%
    try {
        if (request.getParameter("txtNome") != null) {
            ConsoleDAO dao = new ConsoleDAO();
            Console obj = new Console();
            obj.setNome(request.getParameter("txtNome"));
            obj.setMarca(request.getParameter("txtMarca"));

            Double valor = 0.0;
            valor = Double.parseDouble(request.getParameter("txtValor"));
            obj.setValor(new BigDecimal(valor));

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
            Gerenciamento de Consoles
        </h1>
        <ol class="breadcrumb">
            <li>
                <i class="fa fa-dashboard"></i>  <a href="index.jsp">Área Administrativa</a>
            </li>
            <%
                if(request.getParameter("a") != null) {
            %>
            <li class="active">
                <i class="fa fa-file"></i> Erro ao inserir o Console!
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
                        <label>Nome</label>
                        <input class="form-control" type="text" name="txtNome" required />
                    </div>
                    <div class="form-group">
                        <label>Marca</label>
                        <input class="form-control" type="text" name="txtMarca" required />
                    </div>
                    <div class="form-group">
                        <label>Valor</label>
                        <input class="form-control" type="text" name="txtValor" required />
                    </div>
                    <button class="btn btn-primary btn-sm" type="submit">Salvar</button>
                </div>
            </form>
        </div>
    </div>
    <!-- /.row -->
    <%@include file="../rodape.jsp" %>