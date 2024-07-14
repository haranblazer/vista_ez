<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Test.aspx.cs" Inherits="secretadmin_Test" %>




<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <title></title>
</head>
<body>
    
        <div>
        <form runat="server">


 <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.15/css/bootstrap-multiselect.css" rel="stylesheet"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js" type="text/javascript"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/0.9.13/js/bootstrap-multiselect.js" type="text/javascript"></script>





    <asp:ListBox ID="lstFruits" runat="server" SelectionMode="Multiple" DataTextField="catname" DataValueField="catid">
        <%--<asp:ListItem Text="Mango" Value="1" />
        <asp:ListItem Text="Apple" Value="2" />
        <asp:ListItem Text="Banana" Value="3" />
        <asp:ListItem Text="Guava" Value="4" />
        <asp:ListItem Text="Orange" Value="5" />--%>
    </asp:ListBox>
    <asp:Button Text="Submit" runat="server" OnClick="Submit" />


              <script type="text/javascript">
                  $(function () {
                      $('[id*=lstFruits]').multiselect({
                          includeSelectAllOption: true
                      });
                  });
              </script>

            </form>
        </div>
    
</body>
</html>
    </asp:Content>
