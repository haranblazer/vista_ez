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
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">Update Courier Details</h4>
    <div class="row">
                    <div class="col-sm-2 ">
           
                <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="From"
                    ToolTip="dd/mm/yyyy"></asp:TextBox>
            
        </div>
  
        <div class="col-sm-2 ">
            
                <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="To"
                    ToolTip="dd/mm/yyyy"></asp:TextBox>
           
        </div>
 
        <div class="col-sm-3 ">
            <asp:TextBox ID="txtUserId" runat="server" CssClass="form-control" placeholder="User Id/Courier Company/Docket No"></asp:TextBox>
           
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtUserId"
                Display="Dynamic" ErrorMessage="Invalid User Id!" Font-Names="Arial" Font-Size="10pt"
                ForeColor="#C00000" ValidationExpression="^[a-zA-Z0-9]*$"></asp:RegularExpressionValidator>
        </div>
     <div class="col-sm-1 col-xs-6">
            <button id="btnSearch" runat="server" class="btn btn-primary" title="Search" onserverclick="btnSearch_Click">
                Search
            </button>
        </div>
   
   <div class="col-sm-1 col-xs-6 text-right pull-right">
            <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="~/secretadmin/images/excel.gif"
                OnClick="imgbtnExcel_Click" Width="25px" />
            <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="~/secretadmin/images/word.jpg"
                OnClick="imgbtnWord_Click" Style="margin-left: 0px" Width="26px" />
                
                
        </div>
                </div>

   
      
       

    <%-- <div class="clearfix"> </div>

     <div>
        <label for="MainContent_txtPassword" class="col-sm-2  control-label">
             Docket Id:</label>
        <div class="col-sm-4 ">
          <asp:TextBox ID="txtDocketId" runat="server" CssClass="form-control"></asp:TextBox> <br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtDocketId"
                        Display="Dynamic" ErrorMessage="Invalid docket no!" Font-Names="Arial" Font-Size="10pt"
                        ForeColor="#C00000" ValidationExpression="^[a-zA-Z0-9 .]*"></asp:RegularExpressionValidator>
        </div>
    </div>--%>
    <%--  <div class="clearfix"></div>--%>
    <%--<div>
        <label for="MainContent_txtPassword" class="col-sm-2  control-label">
              Courier Company:</label>
        <div class="col-sm-4 ">
          <asp:TextBox ID="txtCompany" runat="server" CssClass="form-control"></asp:TextBox>&nbsp;
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtCompany"
                        Display="Dynamic" ErrorMessage="Invalid courier company!" Font-Names="Arial"
                        Font-Size="10pt" ForeColor="#C00000" ValidationExpression="^[a-zA-Z0-9 . ]*"></asp:RegularExpressionValidator>
        </div>
    </div>--%>
  
       <hr />
    <asp:Label ID="Label2" runat="server" Font-Bold="True"></asp:Label>
    <div class="table-responsive">
        
        <asp:GridView ID="GridView1" runat="server" EmptyDataText="No record found" AutoGenerateColumns="False"
            Style="width: 100%" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging1" DataKeyNames="sno"
            CssClass="table table-striped table-hover mygrd" PageSize="50" OnRowCommand="GridView1_RowCommand">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %></ItemTemplate>
                    <ItemStyle Font-Bold="True" Height="20px" />
                </asp:TemplateField>
                  <asp:TemplateField HeaderText="User Id">
                    <ItemTemplate>
                        <asp:Label ID="lbluserid" runat="server" Text='<%#Eval("userid") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <%--<asp:BoundField DataField="userid" HeaderText="User Id" />--%>
                <asp:BoundField DataField="docketid" HeaderText="Docket Id" />
                <asp:BoundField DataField="description" HeaderText="Description" />
                <asp:BoundField DataField="couriercompany" HeaderText="Courier Company" />
                <asp:BoundField DataField="dispatcheddate" HeaderText="Dispatched Date" />
                <asp:BoundField DataField="receivedstatus" HeaderText="Status" Visible="false"/>
                            <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                       <h6> <asp:Button ID="Button2" runat="server" Text='<%#Eval("receivedstatus") %>' CommandName="S" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                            CssClass="btn btn-primary btn-sm" /></h6>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
   
    <div class="clearfix"></div>
    </div>
</asp:Content>
