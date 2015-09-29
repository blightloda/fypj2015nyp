<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mysql.aspx.cs" Inherits="TrendSensor2013.mysql" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <%for (int i = 0; i < result.Count; i++)%>
        <% { %>
            <p><%=result[i] %></p>
        <% } %>
    </div>
    </form>
</body>
</html>
