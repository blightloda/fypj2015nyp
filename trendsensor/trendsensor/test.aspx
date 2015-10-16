<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="trendsensor.test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

</head>
    <script src="http://d3js.org/d3.v3.min.js"></script>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
    <script>
        var nodes = d3.range(n).map(function () {
            var i = Math.floor(Math.random() * m),
                r = Math.sqrt((i + 1) / m * -Math.log(Math.random())) * maxRadius,
                d = { cluster: i, radius: r };
            if (!clusters[i] || (r > clusters[i].radius)) clusters[i] = d;
            return d;
        });
        
        var data = [
      ["bubble1", [10, 22, 15, 16, 30]],
      ["bubble2", [11, 23, 16, 17, 31]],
        ];
        
        console.log(nodes);
    </script>
</body>
</html>
