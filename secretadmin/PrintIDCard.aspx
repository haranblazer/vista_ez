<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="PrintIDCard.aspx.cs" Inherits="admin_PrintIDCard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
   <%-- <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />--%>
     <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Print ID Card</h4>					
				</div>



   
            <div class="row">
                    <div class="col-sm-2">
                    <asp:TextBox ID="txtUserSearch" runat="server" CssClass="form-control" placeholder="Enter User Id"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvUserSearch" runat="server" ErrorMessage="Please Enter User Id."
                        ControlToValidate="txtUserSearch" ValidationGroup="us" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                   
                </div>
                <div class="col-sm-1">
                    <%--   <asp:Button ID="btnUserSearch" runat="server" Text="Search" CssClass="btn btn-success"
                OnClick="btnUserSearch_Click" ValidationGroup="us" />--%>
                    <button runat="server" id="btnUserSearch" title="Search" class="btn btn-primary"
                        onserverclick="btnUserSearch_Click" validationgroup="us">
                        Search
                    </button>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="ds"
                        ShowMessageBox="true" ShowSummary="false" HeaderText="Please check the following..." />
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ValidationGroup="us"
                        HeaderText="Please check the following..." ShowMessageBox="true" ShowSummary="false" />
                </div>
            </div>
           <hr />
            
                <div class="table table-responsive">
                    <table id="tblView" runat="server" width="100%">
                        <tr>
                            <td>
                                <asp:GridView ID="GridUserDisplay" AutoGenerateColumns="false" Width="100%" CssClass="table table-striped table-hover mygrd"
                                    EmptyDataRowStyle-ForeColor="Red" runat="server" AllowPaging="true" PageSize="25"
                                    EmptyDataText="No Data." >
                                    <Columns>
                                       <asp:TemplateField HeaderText="SrNo" ItemStyle-Width="25px">
                                                <ItemTemplate>
                                                    <%#Container.DataItemIndex+1 %>
                                                    <asp:Label ID="lblUID" runat="server" Text='<%#Eval("appmstregno") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblUserName" runat="server" Text='<%#Eval("appmstfname") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblUserAddress" runat="server" Text='<%#Eval("UserAddress") %>'
                                                        Visible="false"></asp:Label>
                                                     <asp:Label ID="lblUserState" runat="server" Text='<%#Eval("Appmststate") %>'
                                                        Visible="false"></asp:Label>
                                                     <asp:Label ID="lblCompanyLogo" runat="server" Text='<%#Eval("CompanyLogo") %>'
                                                        Visible="false"></asp:Label>
                                                     <asp:Label ID="lblCompanyWebsite" runat="server" Text='<%#Eval("CoWebsite") %>'
                                                        Visible="false"></asp:Label>
                                                        <asp:Label ID="lblCompanyAddress2" runat="server" Text='<%#Eval("CoAddres2") %>'
                                                        Visible="false"></asp:Label>
                                                        <asp:Label ID="lblCompanyAddress" runat="server" Text='<%#Eval("CoAddress") %>'
                                                        Visible="false"></asp:Label>
                                                         <asp:Label ID="lblGenRank" runat="server" Text='<%#Eval("RePurchase_rankName") %>'
                                                        Visible="false"></asp:Label>
                                                         <asp:Label ID="lblBinRank" runat="server" Text='<%#Eval("Binary_rank") %>'
                                                        Visible="false"></asp:Label>
                                                        <asp:Label ID="lblCustomercare" runat="server" Text='<%#Eval("CustomerCareNo") %>'
                                                        Visible="false"></asp:Label>
                                                    <asp:Label ID="lblDOJ" runat="server" Text='<%#Eval("AppMstDOJ","{0:dd/MM/yyyy}") %>'
                                                        Visible="false"></asp:Label>
                                                    <asp:Label ID="lblSponsorId" runat="server" Text='<%#Eval("SponsorID") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblCompanyName" runat="server" Text='<%#Eval("companyname") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblCAddress" runat="server" Text='<%#Eval("Address") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblMobileNo" runat="server" Text='<%#Eval("AppmstMobile") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblimg" runat="server" Text='<%#Eval("imagename") %>' Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        <asp:BoundField DataField="appmstregno" HeaderText="User ID" ItemStyle-Width="150px">
                                            <HeaderStyle HorizontalAlign="Left" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="appmstfname" HeaderText="Name" ItemStyle-Width="150px">
                                            <HeaderStyle HorizontalAlign="Left" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="AppmstMobile" HeaderText="Mobile No" ItemStyle-Width="150px">
                                            <HeaderStyle HorizontalAlign="Left" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="ChkMem" runat="server" Height="20px"></asp:CheckBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:Button ID="btnSubmit" runat="server" Text="SUBMIT" OnClick="btnSubmit_Click"
                                    CssClass="btn btn-primary" />
                            </td>
                        </tr>
                      
                    </table>
                </div>
          
        
   
</asp:Content>
