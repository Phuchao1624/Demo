<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Booking Movie</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>

    <body>
         <%-- thông báo nổi --%>
        <%
            String success = request.getParameter("success");
            if ("1".equals(success)) {
        %>
        <script>
            alert("🎉 Đăng ký thành công! Vui lòng đăng nhập !");
        </script>
        <% }%>

        <%-- Header --%>

        <jsp:include page="Includes/header.jsp" />
        <jsp:include page="Includes/banner.jsp" />
        <jsp:include page="Includes/list_product.jsp" />
        <jsp:include page="Includes/footer.jsp" />



        <%-- Nội dung khác --%>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
