<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RepurchasePaidList.aspx.cs" Inherits="secretadmin_RepurchasePaidList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
      
           
       

        <h4 class="fs-20 font-w600  me-auto float-left mb-0">Latest Batch Reports</h4>
        <div id="LoaderImg" class="loader-data" style="display: none;">
            <img src="../images/preloader.gif" alt="" style="height: 200px" />
        </div>
        <br />
         <asp:Label ID="lbl_Test" runat="server" ></asp:Label>
         <asp:Label ID="lbl" runat="server" Style="display: none;"></asp:Label>


        <div class="table-responsive">
            <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border" style="width: 100%">
                <tfoot align="left">
                    <tr>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>

                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </tfoot>
            </table>
        </div>

    </form>
</body>
</html>
