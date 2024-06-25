<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="CourierEntries.aspx.cs" Inherits="admin_CourierEntries" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script> 
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" /> 

    <script> var $JD = $.noConflict(true); </script>
     <script type="text/javascript"> 
         $JD(function () { 
             $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
             $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' }); 
        }); 
    </script>

   <%-- <script type="text/javascript">
        $(document).ready(function () {
            var dataUserID = document.getElementById("<%=divUserID.ClientID%>").innerHTML.split(",");
            $('#<%=txtUserId.ClientID %>').autocomplete(dataUserID);
        });
    </script>--%>
    <style>
    td,
    th {
      padding:5px 5px; border-color:#ddd;
    }    
    </style>

  <div class="accordion accordion-rounded-stylish accordion-bordered" id="accordion-eleven">
<div class="accordion-item mb-0 row">
<div class="col-md-6">
<div class="accordion-header rounded-lg collapsed " id="accord-11One" data-bs-toggle="collapse" data-bs-target="#collapse11One" aria-controls="collapse11One" aria-expanded="false" role="button">
<span class="accordion-header-icon"></span>
<h4 class="fs-20 font-w600  me-auto float-left mb-0">Courier Entries</h4>
<span class="fa fa-sort-desc plus float-left"></span>
</div>
</div>
    
    <div id="collapse11One" class="accordion__body collapse" aria-labelledby="accord-11One" data-bs-parent="#accordion-eleven" style="">
<div class="accordion-body-text">
<div class="form-group card-group-row row">
     
        <div class="col-sm-2" >
            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
   
       
      
        <div class="col-sm-2">
            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
  
  
        <div class="col-sm-4">
           <asp:TextBox ID="txtUserId" placeholder="User Id / Courier Company / Docket No"  runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtUserId"
                        Display="Dynamic" ErrorMessage="Invalid User Id!" Font-Names="Arial" Font-Size="10pt"
                        ForeColor="#C00000" ValidationExpression="^[a-zA-Z0-9]*"></asp:RegularExpressionValidator>
        </div>
         <div class="col-sm-1 col-xs-6">
           <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary" OnClick="btnSearch_Click"
                        Text="Search" />
         </div>
         <div class="col-sm-2 col-xs-6 text-right pull-right"> <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="~/secretadmin/images/excel.gif"
                        OnClick="imgbtnExcel_Click" Width="25px" />
                    <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="~/secretadmin/images/word.jpg"
                        OnClick="imgbtnWord_Click" Style="margin-left: 0px" Width="26px" />
                   <%-- <asp:ImageButton ID="imgbtnpdf" runat="server" ImageUrl="~/admin/images/pdf.gif"
                        OnClick="imgbtnpdf_Click" />--%></div>
</div>
</div>
</div>
</div>
  


  
    <%-- <div class="clearfix"> </div>

     <div>
        <label for="MainContent_txtPassword" class="col-sm-2 col-xs-3 control-label">
             Docket Id:</label>
        <div class="col-sm-4 col-xs-9">
          <asp:TextBox ID="txtDocketId" runat="server" CssClass="form-control"></asp:TextBox> <br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtDocketId"
                        Display="Dynamic" ErrorMessage="Invalid docket no!" Font-Names="Arial" Font-Size="10pt"
                        ForeColor="#C00000" ValidationExpression="^[a-zA-Z0-9 .]*"></asp:RegularExpressionValidator>
        </div>
    </div>--%>
   <%--  <div class="clearfix"></div>--%>

     <%--<div>
        <label for="MainContent_txtPassword" class="col-sm-2 col-xs-3 control-label">
              Courier Company:</label>
        <div class="col-sm-4 col-xs-9">
          <asp:TextBox ID="txtCompany" runat="server" CssClass="form-control"></asp:TextBox>&nbsp;
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtCompany"
                        Display="Dynamic" ErrorMessage="Invalid courier company!" Font-Names="Arial"
                        Font-Size="10pt" ForeColor="#C00000" ValidationExpression="^[a-zA-Z0-9 . ]*"></asp:RegularExpressionValidator>
        </div>
    </div>--%>
  
    

        <table id="TABLE1" onclick="return TABLE1_onclick()" style="width: 100%">    
            <tr>
                <td style="text-align: left; width: 325px;">
                    <asp:Label ID="Label2" runat="server" Font-Bold="True"></asp:Label>
                    <div id="divUserID" runat="server" style="display: none;">
                    </div>
                </td>
               
            </tr>
        </table>
        <div class="table-responsive">
                    <asp:GridView ID="GridView1" runat="server" EmptyDataText="No record found" AutoGenerateColumns="False" style="width:100%"
                        AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging1" CssClass="table table-striped table-hover mygrd"
                        PageSize="50">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr.No">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %></ItemTemplate>
                                <ItemStyle Font-Bold="True" Height="20px" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="userid" HeaderText="User Id" />
                            <asp:BoundField DataField="docketid" HeaderText="Docket Id" />
                            <asp:BoundField DataField="description" HeaderText="Description" />
                            <asp:BoundField DataField="couriercompany" HeaderText="Courier Company" />
                            <asp:BoundField DataField="dispatcheddate" HeaderText="Dispatched Date" />
                            <asp:BoundField DataField="receivedstatus" HeaderText="Status" />
                        </Columns>
                    </asp:GridView>
               </div>
</asp:Content>
