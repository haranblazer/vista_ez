<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CCAvenue_Request.aspx.cs" Inherits="CCAvenue_Request" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#nonseamless").submit();
        });
    </script>
    <title></title>
</head>
<body>
    <form id="nonseamless" method="post" name="redirect" action="<%=method.CCA_url%>">
        <input type="hidden" id="encRequest" name="encRequest" value="<%=strEncRequest%>" />
        <input type="hidden" name="access_code" id="Hidden1" value="<%=method.CCA_access_code%>" />
    </form>
</body>
</html>
