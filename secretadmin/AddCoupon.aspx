<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" EnableEventValidation = "false" CodeFile="AddCoupon.aspx.cs" Inherits="secretadmin_AddCoupon" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<style>
.btn-lg, .btn-group-lg > .btn {
    padding: 6px 4px;
    font-size: 18px;
}
a {
    color: #7c7c7c;
}
</style>
    
      <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />

     <script type="text/javascript">
         $(function () {
             jQuery.noConflict(true);
             $('#<%=txtfromdate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
             $('#<%=txttodate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
         }); 
    </script>
    <script type="text/javascript">
     
         function CheckNumericValue(e) {
             var key = e.which ? e.which : e.keyCode;
             //enter key  //backspace //tabkey      //escape key                  
             if ((key >= 48 && key <= 57) || key == 13 || key == 8 || key == 9 || key == 27) {
                 return true;
             }
             else {
                 alert("Please Enter Numeric Only");
                 return false;
             }
         }
        

    </script> 
     
         <h2 class="head">
         <i class="fa fa-tag fa-lg"></i>
                    Add Voucher</h2>
  <div class="panel panel-default">
  <div class="col-md-12">
    <br />
   
    <div class="clearfix">
    </div>
    <br />
    <div>
        <div class="form-group">
            <div class="col-md-3">
               <label>User Id:&nbsp;  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUserId"  EnableClientScript="true"
                                                Text="*"  Display="None" ErrorMessage="Enter UserId." SetFocusOnError="true" ValidationGroup="A"></asp:RequiredFieldValidator>
                                     </label>   
                                     <asp:TextBox ID="txtUserId" runat="server" AutoPostBack="true" CssClass="form-control" 
                                CausesValidation="True" ontextchanged="txtUserId_TextChanged"></asp:TextBox>
                            <asp:Label ID="lblUser" runat="server" ForeColor="Black"></asp:Label>  
                                   
            </div>
             <div class="col-md-3">
               <label>Voucher Amt. &nbsp; <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtcouponamt" Display="None"
                                   EnableClientScript="true" Text="*"   ErrorMessage="Enter Voucher Amt." SetFocusOnError="true" ValidationGroup="A"></asp:RequiredFieldValidator></label>
                <asp:TextBox ID="txtcouponamt" ValidationGroup="A" onkeypress="return CheckNumericValue(event)" runat="server" CausesValidation="true" CssClass="form-control" ></asp:TextBox>
               </div>
                  <div class="col-md-3">
               <label>Minimum Voucher Amt. &nbsp; <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Text="*" runat="server" ControlToValidate="txtminamt"
                                      Display="None" EnableClientScript="true"  ErrorMessage="Enter Minimum Voucher Amt." SetFocusOnError="true" ValidationGroup="A"></asp:RequiredFieldValidator></label>
                <asp:TextBox ID="txtminamt" ValidationGroup="A" runat="server" onkeypress="return CheckNumericValue(event)" ToolTip="Coupan Condition Amount " CausesValidation="true" CssClass="form-control" ></asp:TextBox>
               </div>
                 <div class="col-md-3"> <br />
                <asp:Button ID="btnsave" runat="server" Text="Save" CssClass="btn btn-success" 
                         ValidationGroup="A" onclick="btnsave_Click" />
            </div>
        </div> 
        <div class="clearfix">
    </div><hr />
         <div class="form-group">
            <div class="col-md-2"> <label>From Date</label>
              <asp:TextBox ID="txtfromdate" runat="server" CssClass="form-control" ToolTip="From Date"
                        placeholder="DD/MM/YYYY"></asp:TextBox>
          
        </div>
         <div class="col-md-2"> <label>To Date</label>
           <asp:TextBox ID="txttodate" runat="server" CssClass="form-control" ToolTip="To Date"
                        placeholder="DD/MM/YYYY"></asp:TextBox>
          
        </div>
         <div class="col-md-2"> <label>User Id </label>
          <asp:TextBox ID="txtviewuserid" runat="server" CssClass="form-control" ToolTip="plz enter user id"></asp:TextBox>
                        
        </div>
         <div class="col-md-2"> <label>Status</label>
            <asp:DropDownList ID="ddlsts" runat="server" CssClass="form-control">
                    <asp:ListItem Value="-1" Selected="True">All </asp:ListItem>
                    <asp:ListItem Value="0">Unused</asp:ListItem>
                    <asp:ListItem Value="1">Used</asp:ListItem>
                </asp:DropDownList>
        </div>
         <div class="col-md-2"> <label><br /></label><br />
            <asp:Button ID="btnSearch" runat="server" Text="Search" 
                 CssClass="btn btn-success" onclick="btnSearch_Click" />
          
        </div>
        </div>
        
          <div class="form-group">
          <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
            ShowSummary="False" ValidationGroup="A" HeaderText="Please correct the following errors..." />
                            </div>
    <div class="clearfix">
    </div><hr />
      <div class="form-group">
            <div class="col-md-7">      
       <asp:Label ID="lblTotal" runat="server" Font-Bold="true" ForeColor="Green"></asp:Label>
       </div> <div class="col-md-3">  
               <asp:Image ID="imgused" runat="server" ImageUrl="../user_images/BlueLight.jpg" Width="20px" />&nbsp;
              <asp:Label ID="lblused" runat="server" Text="Used"></asp:Label>&nbsp; 
                        <asp:Image ID="imgunused" runat="server" ImageUrl="../user_images/white.jpg" Width="20px"  style="border:1px solis #333"/>&nbsp;
                       <asp:Label ID="lblunused" runat="server" Text="Unused"></asp:Label>       
        </div>
       <div class="col-md-2" style="text-align:right;"> 
       
       <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                                Width="25px" />
                            <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                                Style="margin-left: 0px" Width="26px" /> &nbsp;</div>    
  </div>
    <div class="clearfix">
    </div>
    <br />
    <div class="table-responsive">
               <asp:GridView ID="GRDCOUPAN" runat="server" CssClass="table table-striped table-hover mygrd"
            PageSize="15" AutoGenerateColumns="false"  DataKeyNames="CouponId" EmptyDataText="No Record Found."
            AllowPaging="true" onpageindexchanging="GRDCOUPAN_PageIndexChanging" onrowdatabound="GRDCOUPAN_RowDataBound" 
                    >
            <Columns>
                <asp:TemplateField HeaderText="Sr No.">
                    <ItemTemplate>
                       <%# Container.DataItemIndex +1%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="User Id">
                    <ItemTemplate>
                      <asp:Label ID="lbluserid"  runat="server" Text='<%#Eval("AppMstRegNo") %>'></asp:Label>                   
              </ItemTemplate>
                </asp:TemplateField>
                  <asp:TemplateField Visible="false">
                    <ItemTemplate>
                        <asp:Label ID="lblapname" runat="server" Text='<%#Eval("AppMstFName") %>'>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                  <asp:TemplateField HeaderText="Voucher Amt." HeaderStyle-Width="125px">
                    <ItemTemplate>
                      <asp:Label ID="lblcopamt"  runat="server" Text='<%#Eval("CouponAmount") %>'></asp:Label>
              </ItemTemplate>
                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Min Voucher Amt." HeaderStyle-Width="150px" >
                    <ItemTemplate>
                      <asp:Label ID="lblcondamt"  runat="server" Text='<%#Eval("ConditionAmount") %>'></asp:Label>
              </ItemTemplate>
              </asp:TemplateField>
               <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                      <asp:Label ID="lblfullstatus"  runat="server" Text='<%#Eval("UseStatus") %>'></asp:Label>
                      <asp:Label ID="lblsts"  Visible="false" runat="server" Text='<%#Eval("IsUsed") %>'></asp:Label>
              </ItemTemplate>
                </asp:TemplateField>
               <asp:TemplateField HeaderText="Type">
                    <ItemTemplate>
                      <asp:Label ID="lblvouchertype"  runat="server" Text='<%#Eval("VoucherType") %>'></asp:Label>
              </ItemTemplate>
                </asp:TemplateField>
                   <asp:BoundField HeaderText="D.O.E." DataField="Doe" />
                      <asp:BoundField HeaderText="Expiry Date" DataField="ExpiryDate" />
                <asp:TemplateField>
                    <ItemTemplate>
                    <asp:LinkButton ID="lnkEdit" CssClass="btn btn-defaul btn-lg" runat="server" 
                   TabIndex="1"  onclick="lnkEdit_Click" OnClientClick="return confirm('Are you sure you want to edit this voucher ?');"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> </asp:LinkButton> 
                       <asp:LinkButton ID="lnkdelete" CssClass="btn btn-defaul btn-lg" runat="server" 
                   TabIndex="1" onclick="lnkdelete_Click" OnClientClick="return confirm('Are you sure you want to delete this voucher ?');" ><i class="fa fa-trash" aria-hidden="true"></i> </asp:LinkButton> 
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
                 
                          
    </div>
    </div>
    </div>
    <div class="clearfix"></div>
    </div>

</asp:Content>

