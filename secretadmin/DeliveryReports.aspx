<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="DeliveryReports.aspx.cs" Inherits="secretadmin_DeliveryReports" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script> 
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" /> 
    <script> var $JD = $.noConflict(true); </script>
    <style>
       @media only screen and (max-width: 480px) {
.head {
    font-size: 16px !important;
}

        }
       
    </style>
    <script type="text/javascript">
        $(function () {
            $JD(function () {
                $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
                $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
                $JD('#<%=txtDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        }); 
    </script>
    <script>
        $(document).ready(function () {
            $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(13)").each(function () {
                $(this).find('a').click(function () {
                    //hide all spanded tag
                    $('#<%=GridView1.ClientID %> tr:gt(0)').find("td:eq(13)").each(function () {
                        $(this).find('a').css("display", "block");
                        $(this).find('span').css("display", "none");
                    });
                    //show specific span tag
                    $(this).parent().find('span').css("display", "block");
                    $(this).css("display", "none");
                });
            });
        });
        function Reser() {
            $('#<%=ddl_RoleWise.ClientID%>').val('');
            $('#<%=DropDownList2.ClientID%>').val(0);
            $('#<%=TxtSponsorId.ClientID%>').val('');
            $('#<%=ddl_Status.ClientID%>').val('-1');
            $('#<%=ddl_paymode.ClientID%>').val('');
        }
    </script>
    
        <asp:ScriptManager ID="ScriptManager1" runat="server" />  
     <h4 class="fs-20 font-w600  me-auto float-left mb-0">Delivery Report</h4>
     <div class="form-group card-group-row row">
                   <div class="col-sm-2">
               
                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"
                        placeholder="From"></asp:TextBox>
               
            </div>
            
            <div class="col-sm-2">
               
                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"
                        placeholder="To"></asp:TextBox>
               
            </div>
            <div class="col-sm-2 control-label">
              
                    Role wise</div>
            <div class="col-sm-2">
                <asp:DropDownList ID="ddl_RoleWise" runat="server" CssClass="form-control">
                </asp:DropDownList>
            </div>
    
       
            
            <div class="col-sm-2 control-label">
              
                    Type</div>
            <div class="col-sm-2">
                <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-control">
                    <asp:ListItem Value="0" Selected="True">All </asp:ListItem>
                    <asp:ListItem Value="1">Package</asp:ListItem>
                    <asp:ListItem Value="2">Upgrade</asp:ListItem>
                   <%-- <asp:ListItem Value="3">Repurchase</asp:ListItem>--%>
                   <asp:ListItem Value="4">Free Sample</asp:ListItem>
                </asp:DropDownList>
            </div>
      
            <div class="col-sm-2 control-label">
               
                    Search By</div>
            <div class="col-sm-2">
                <asp:TextBox ID="TxtSponsorId" runat="server" MaxLength="30" CssClass="form-control"
                    ToolTip="InvNo/UserID/Name" placeholder="Search By InvNo/UserID/Name"></asp:TextBox>
                   </div>
            <div class="col-sm-2 control-label">
               
                 Delivery   Status</div>
            <div class="col-sm-2">
                <asp:DropDownList ID="ddl_Status" runat="server" CssClass="form-control">
                    <asp:ListItem Value="-1" Selected="True">All </asp:ListItem>
                    <asp:ListItem Value="1">Delivery</asp:ListItem>
                    <asp:ListItem Value="0">UnDelivery</asp:ListItem>
                </asp:DropDownList>
            </div>
       
     
            <div class="col-sm-2 control-label">
                
                    Pay Mode</div>
            <div class="col-sm-2">
                <asp:DropDownList ID="ddl_paymode" runat="server" CssClass="form-control">
                    <asp:ListItem Value="" Selected="True">All </asp:ListItem>
                     <asp:ListItem Value="Wallet">Wallet</asp:ListItem>
                    <asp:ListItem Value="Online Payment" Enabled="false">Online Payment</asp:ListItem>
                    <asp:ListItem Value="Cash">Cash</asp:ListItem>
                    <asp:ListItem Value="Cheque">Cheque</asp:ListItem>
                    <asp:ListItem Value="Net Banking">Net Banking</asp:ListItem>
                    <asp:ListItem Value="DD">DD</asp:ListItem>
                </asp:DropDownList>
            </div>
           
             <div class="col-sm-4">
              <button title="Search" id="btnSearch" runat="server" class="btn btn-primary" onserverclick="btnSearch_Click">
                    Search
                </button>

                   <button type="button" title="reset" class="btn btn-danger" onclick="Reser()"   >
                    Reset
                </button>
            </div>
             <div class="col-sm-2 col-xs-4 pull-right text-right">
            
                  <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                                Width="25px" />
                            <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                                Style="margin-left: 0px" Width="26px" />
                </div>
                </div>
  
   <hr />
       
       
            <div class="col-sm-1" id="divUserID" style="display: none;" runat="server">
            </div>
        
        <div class="clearfix">
        </div>
       
        <table  style="width: 100%">
            <tr>
                <td colspan="2">
                    <asp:Label ID="lblTotal" runat="server" Font-Bold="true" ForeColor="Green"></asp:Label>
                </td>
                   <td colspan="2">
                <asp:Image ID="imgadmin" runat="server" ImageUrl="images/BlueLight.jpg" Width="20px" />&nbsp;
                <asp:Label ID="lbladmin" runat="server" Text="Counter"></asp:Label>&nbsp; 
                        <asp:Image ID="imgFranchise" runat="server" ImageUrl="images/white.png" Width="20px"  style="border:1px solis #333"/>&nbsp;
                       <asp:Label ID="lblfran" runat="server" Text="Counter"></asp:Label>&nbsp; 
                  </td>
              
            </tr>
        </table>
        <div class="table-responsive">
          <asp:GridView AllowPaging="true" ID="GridView1" runat="server" CssClass="table table-striped table-hover mygrd"
                AutoGenerateColumns="false" DataKeyNames="invoiceno,monthname" PageSize="50"
                Width="100%" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand"
                EmptyDataText="No Data Found" EmptyDataRowStyle-ForeColor="Red" 
                onrowcancelingedit="GridView1_RowCancelingEdit" 
                onrowdatabound="GridView1_RowDataBound" >
                <Columns>
                    <asp:TemplateField HeaderText="SrNo.">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:HyperLinkField DataTextField="invoiceno" HeaderText="Invoice No." DataNavigateUrlFields="srno,status"
                        Text="Print" DataNavigateUrlFormatString="GSTBill.aspx?id={0}&st={1}" ControlStyle-ForeColor="Blue"/>
                    <asp:TemplateField HeaderText="Cancel" Visible="false">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkbtnEdit1" Text='<%#Eval("Status_Text") %>' CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                CommandName="cancel" runat="server" OnClientClick="return confirm('Are you sure you want to cancel this bill?');"
                                Style="text-align: center; color: Blue;" />
                            <asp:Label ID="lbl_cancelled" runat="server" Style="color: Red"></asp:Label>
                        </ItemTemplate>
                                            </asp:TemplateField>
                          <asp:TemplateField HeaderText="Billby" Visible="false">
                             <ItemTemplate>
                            <asp:Label ID="lblbillby" runat="server" Text='<%#Eval("BillBy") %>'></asp:Label>
                        </ItemTemplate>
                      </asp:TemplateField>
                    <asp:BoundField HeaderText="Seller ID" DataField="saleby" />
                    <asp:BoundField HeaderText="Seller Name" DataField="salebyname" />
                    <asp:BoundField HeaderText="Buyer ID" DataField="soldto" />
                    <asp:BoundField HeaderText="Buyer Name" DataField="SoldToName" />
                    <asp:BoundField HeaderText="Sponsor ID" DataField="sponsorid" Visible="false" />
                    <asp:BoundField HeaderText="Sponsor Name" DataField="Sponsorname" Visible="false" />
                    <asp:BoundField HeaderText="No.Of Product" DataField="NoOFProduct" />
                    <asp:BoundField HeaderText="Amount" DataField="amt" />
                    <asp:BoundField HeaderText="Gross" DataField="grossAmt" />
                    <asp:BoundField HeaderText="GST" DataField="tax" />
                     <asp:BoundField HeaderText="Net Amount" DataField="netAmt" />
                    <asp:TemplateField HeaderText="status" Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%#Eval("status") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Bill Date" DataField="doe" />
                    <asp:BoundField HeaderText="Payment Mode" DataField="paymode" />   
                     <asp:TemplateField HeaderText="Delivery" >
                             <ItemTemplate>
                             
                              <asp:DropDownList ID="ddldelivery" runat="server" Width="100px" AutoPostBack="true"
                              onselectedindexchanged="ddldelivery_SelectedIndexChanged" CssClass="form-control" >
                <asp:ListItem Value="1">Counter</asp:ListItem>
                    <asp:ListItem Value="2" >Courier</asp:ListItem>
                    </asp:DropDownList>
                    <asp:Label ID="lbldilsts" Visible="false" runat="server" Text='<%#Eval("DeliveryStatus") %>'></asp:Label>
                      <asp:Label ID="lbldiltype" Visible="false" runat="server" Text='<%#Eval("DeliveryType") %>'></asp:Label>
                        <asp:Label ID="lblinvoice" Visible="false" runat="server" Text='<%#Eval("invoiceno") %>'></asp:Label>
                        </ItemTemplate>
                      </asp:TemplateField>
                       <asp:TemplateField HeaderText="Remark" >
                             <ItemTemplate>
                            <asp:TextBox ID="txtremark" runat="server"  Text='<%#Eval("DeliveryRemark") %>' TextMode="MultiLine" Rows="2"></asp:TextBox>
                        </ItemTemplate>
                      </asp:TemplateField> 
                      <asp:TemplateField>
                <ItemTemplate>
               <asp:LinkButton ID="lnkbtnsubmit" CommandName="Submit" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                runat="server" TabIndex="1" Text="Submit" ></asp:LinkButton>
                           
                </ItemTemplate>
            </asp:TemplateField>                  
                </Columns>
            </asp:GridView>
        </div>

         <asp:Button ID="btnShowPopup" runat="server" style="display:none" />
        <cc1:ModalPopupExtender ID="lnkbtnpopex" runat="server" BackgroundCssClass="Overlay" 
            Enabled="True" TargetControlID="btnShowPopup" PopupControlID="pnlSelect" CancelControlID="hyprlnkClose">
        </cc1:ModalPopupExtender>
     
       <asp:Panel CssClass="PopUpPanel" Width="60%" ID="pnlSelect"  Visible="false" runat="server" 
  BackColor="White">           
    
       <h2 class="head">
        <i class="fa fa-rocket" aria-hidden="true"></i>&nbsp;Dispatch Courier
          <asp:HyperLink id="hyprlnkClose" runat="server" CssClass="ClosePopupCls" ForeColor="#ffffff">[x]&nbsp;</asp:HyperLink>

        </h2>
        <br />
    <div class="form-group">
     <div class="col-sm-12 col-md-12">  <label> Dispatch To(Id No):<span style="color: Red"><strong>*</strong></span>        
         <asp:RequiredFieldValidator ID="rfvDispatchNo" runat="server" ControlToValidate="txtIdNo"
                ErrorMessage="Please Enter Id!" Font-Names="Arial" Font-Size="Small" ForeColor="#C04000"
                Display="None" ValidationGroup="aa"></asp:RequiredFieldValidator>
           </label>
            <asp:TextBox ID="txtIdNo" runat="server" CssClass="form-control" placeholder="Enter Id No"></asp:TextBox>
             </div>
 
     <div class="col-sm-12 col-md-12">
        <label>Description:<span style="color: Red"><strong>*</strong></span><asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                ErrorMessage="Please Enter Description!" Font-Names="Arial" Font-Size="Small"
                ForeColor="#C04000" Display="None" ValidationGroup="aa"></asp:RequiredFieldValidator></label> 
            <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" CssClass="form-control"
                placeholder="Type Your Description"></asp:TextBox><br />
           
        </div>
    
     <div class="col-sm-12 col-md-12">
        <label>Courier Company &nbsp; <asp:RequiredFieldValidator ID="rfvCourierCompany" runat="server" ControlToValidate="txtCompany"
                ErrorMessage="Please Enter Company Name!" Font-Names="Arial" Font-Size="Small"
                ForeColor="#C04000" Display="None" ValidationGroup="aa"></asp:RequiredFieldValidator></label>
            <asp:TextBox ID="txtCompany" runat="server" CssClass="form-control" placeholder="Enter Courier Company Name"></asp:TextBox><br />
           
        </div> 
         <div class="col-sm-12 col-md-12">
        <label>
            Docket Number    <asp:RequiredFieldValidator ID="rfvDocketNo" runat="server" ControlToValidate="txtDocketNumber"
                ErrorMessage="Please Enter Docket Number!" Font-Names="Arial" Font-Size="Small"
                ForeColor="#C04000" Display="None" ValidationGroup="aa"></asp:RequiredFieldValidator></label>
            <asp:TextBox ID="txtDocketNumber" runat="server" CssClass="form-control" placeholder="Enter Docket Number"></asp:TextBox><br />
         
        </div>
        <div class="col-sm-12 col-md-12">
        <label> Date:<span style="color: Red"><strong>*</strong></span></label>

            <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" placeholder="dd/mm/yyyy"
                ToolTip="Date Format Should be dd/mm/yyyy"></asp:TextBox>
        </div>  
        <div class="col-sm-12 col-md-12">
            <asp:ValidationSummary ID="ValidationCourierForm" runat="server" ValidationGroup="aa"
                ShowMessageBox="true" ShowSummary="false" HeaderText="Correct the following errors..." />
        </div>
               <div class="col-sm-12 col-md-12">
               <br />
            <asp:Button ID="btndispatch" runat="server"  Text="Dispatch" CssClass="btn btn-success"
                ValidationGroup="aa" onclick="btndispatch_Click"  />
            <div id="div1" runat="server" style="display: none;">
            </div>
        </div>
        </div>
    </asp:Panel>
   
  <!-- Trigger the modal with a button -->
 <%-- <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Open Modal</button>
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    &times;</button>
                <h4 class="modal-title"> Dispatch Courier</h4>
         
        </div>
    </div>
</div>
            <script type='text/javascript'>
                function openModal() {
                    $('[id*=myModal]').modal('show');
                    // data-toggle="modal" data-target="#myModal"
                } 
            </script>
        </div>--%>
 
</asp:Content>

