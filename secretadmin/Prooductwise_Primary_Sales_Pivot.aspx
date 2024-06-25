<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Prooductwise_Primary_Sales_Pivot.aspx.cs" Inherits="secretadmin_Prooductwise_Primary_Sales_Pivot" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link rel="stylesheet" href="css/Master.css" type="text/css" />
    <link rel="stylesheet" href="css/Mystyle.css" type="text/css" />
    <link rel="stylesheet" href="css/Registration.css" type="text/css" />
    <link rel="stylesheet" href="css/sb-admin-2.css" type="text/css" />
    <link rel="stylesheet" href="css/sb-admin-2.min.css" type="text/css" />
    <link rel="stylesheet" href="css/Site.css" type="text/css" />
</head>
<body>
     <form id="form1" runat="server">
        <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>

        <div class="container-fluid">
            <div class="card-header py-3 align-items-center justify-content-between">
                <h6 class="m-0 font-weight-bold text-primary">
                    <center>Productwise Primary Sales</center>
                </h6>
            </div>
            <br />
             <br />
            <div class="row">
                <div class="col-sm-2.5 ">
                    <span class="month" style="color: #bb8f38" aria-setsize="20">Select Number of Months Required :</span>
                    <asp:DropDownList ID="ddlmonth" runat="server">
                        <asp:ListItem Value="0">--Select--</asp:ListItem>
                        <asp:ListItem Value="1">4</asp:ListItem>
                        <asp:ListItem Value="2">6</asp:ListItem>
                        <asp:ListItem Value="3">8</asp:ListItem>
                        <asp:ListItem Value="4">10</asp:ListItem>
                        <asp:ListItem Value="5">12</asp:ListItem>
                    </asp:DropDownList>
                </div>
          

                <div class="col-sm-2 ">
                    <asp:Button ID="ViewRepor" runat="server" Text="View Report" OnClick="ViewRepor_Click" BackColor="#24a0ed" ForeColor="White"></asp:Button>
                </div>
                </div>
                  <div class="col-sm-6" style="width:80%;text-align:right">
                <asp:Button ID="btnexcel" runat="server" Text="Download Excel" OnClick="btnexcel_Click" />
            </div>
              
          
            <br />
           <%-- <asp:GridView ID="grProductprimary" runat="server" ShowFooter="true" OnRowDataBound="grProductprimary_RowDataBound">

                <Columns>
                    <asp:TemplateField HeaderText="Sl No">
                        <ItemTemplate>
                            <asp:Label ID="lblSerial" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>                  
                    
                </Columns>

            </asp:GridView>--%>
            <asp:GridView ID="grdProductprimary" runat="server" OnRowDataBound="grdProductprimary_RowDataBound" ShowFooter="true">
                <Columns>
                    <asp:TemplateField HeaderText="Sl No">
                        <ItemTemplate>
                            <asp:Label ID="lblserial" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

        </div>
    </form>
</body>
</html>
