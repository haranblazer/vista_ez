<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="AddLeader.aspx.cs" Inherits="secretadmin_AddLeader" %>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 <script language="javascript" type="text/javascript">
     function CallVal(txt) {
         ServerSendValue(txt.value, "ctx");
     }
     function ServerResult(arg) {

         if (arg == "You cannot leave blank field here !") {
             document.getElementById("lblUser.ClientID").style.color = "Red";
             document.getElementById("lblUser.ClientID").innerHTML = arg;
         }
         else {
             document.getElementById("<%=lblUser.ClientID%>").style.color = "darkblue";
             document.getElementById("<%=lblUser.ClientID%>").innerHTML = arg;
         }
     }
     function ClientErrorCallback() {
     }
    </script>
    
     <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Add Leaders  </h4>					
				</div>
                <asp:Panel ID="Panel1" runat="server">
                    <div class="row">
                        <div class="col-md-1">
                            <div class="control-label">
                                Leader:<span style="color: Red">*</span></div>
                        </div>
                        <div class="col-md-2">
                            <asp:TextBox ID="ddlLeader" runat="server" CssClass="form-control" onchange="return CallVal(this);" >
                            
                                <%-- <asp:ListItem Value="0">Select</asp:ListItem>
                            <asp:ListItem Value="1">Associate</asp:ListItem>    
                            <asp:ListItem Value="2">Trainer</asp:ListItem>    --%>
                            </asp:TextBox>
                            <asp:Label ID="lblUser" runat="server" ForeColor="Black"></asp:Label>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="DdlState"
                                SetFocusOnError="true" Display="None" ErrorMessage="Please Select State!" ForeColor="#C00000"
                                InitialValue="0" ValidationGroup="NJ"></asp:RequiredFieldValidator>
                           
                            
                        </div>
                        <div class="col-md-1 control-label">
                          
                                State:<span style="color: Red">*</span>
                        </div>
                        <div class="col-md-2">
                            <asp:DropDownList ID="DdlState" runat="server" CssClass="form-control">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="ContryExp" runat="server" ControlToValidate="DdlState"
                                SetFocusOnError="true" Display="None" ErrorMessage="Please Select State!" ForeColor="#C00000"
                                InitialValue="0" ValidationGroup="NJ"></asp:RequiredFieldValidator>
                        </div>
                         <div class="col-md-2 control-label">
                           
                                Training Type:<span style="color: Red">*</span>
                        </div>
                        <div class="col-md-2">
                            <asp:DropDownList ID="ddlttype" runat="server" CssClass="form-control">
                                <asp:ListItem Value="0">Select</asp:ListItem>
                                <asp:ListItem Value="1">Training Business</asp:ListItem>
                                <asp:ListItem Value="2">Product Training</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DdlState"
                                SetFocusOnError="true" Display="None" ErrorMessage="Please Select State!" ForeColor="#C00000"
                                InitialValue="0" ValidationGroup="NJ"></asp:RequiredFieldValidator>
                            <div class="clearfix">
                            </div>
                           
                        </div>
                        
                        <div class="clearfix"></div>
                       
                    
                    
                    <div class="col-md-1 control-label">
                            
                                City:<span style="color: Red">*</span>
                        </div>
                        <div class="col-md-2">
                            <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="Enter your City"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="txtCity"
                                Display="None" ErrorMessage="Please Enter City!" ForeColor="#C00000" ValidationGroup="NJ"
                                SetFocusOnError="true"></asp:RequiredFieldValidator>
                        </div>
                 
                   
                      
                        <div class="col-md-1">
                            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Save"
                                OnClick="btnSubmit_Click" />
                        </div>
                    </div>
                  
                    <div class="clearfix">
        </div> 
                   <br />
                        <div class="table-responsive">
                            <asp:GridView ID="gridTrnReq" EmptyDataText="No Record Found." CssClass="table table-striped table-hover mygrd"
                                runat="server" AllowPaging="true" AutoGenerateColumns="false" PageSize="25" OnPageIndexChanging="gridTrnReq_PageIndexChanging"
                                OnRowDataBound="gridTrnReq_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr.No">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="appmstregno" HeaderText="UserId" />
                                    <asp:BoundField DataField="appmstfname" HeaderText="Name" />
                                    <asp:BoundField DataField="State" HeaderText="State" />
                                    <asp:BoundField DataField="City" HeaderText="City" />
                                    <asp:BoundField DataField="typeofrequest" HeaderText="Type Of Request" />
                                    <asp:BoundField DataField="trainingtype" HeaderText="Training Type" />
                                    <asp:BoundField DataField="requestdate" HeaderText="Request Date" DataFormatString="{0:dd/MM/yyyy}" />
                                    <%-- <asp:TemplateField HeaderText="Action">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkSubmit" runat="server" CssClass="btn btn-success btn-sm"><i class="fa fa-paper-plane-o"></i>&nbsp;Make Payment</asp:LinkButton>
                                            <asp:LinkButton ID="lnlGetInvoice" runat="server" Visible="false" CssClass="btn btn-default btn-sm"><i class="fa fa-print"></i>&nbsp;Invoice</asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="CollectType" HeaderText="Receive Type" />
                                    <asp:BoundField DataField="DeliverStatus" HeaderText="Deliver Status" />--%>
                                </Columns>
                            </asp:GridView>
                        </div>
                 
                </asp:Panel>
           
     
        <div class="clearfix">
        </div>
    </div>
   
</asp:Content>
