<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="FranchisePrintID.aspx.cs" Inherits="secretadmin_FranchisePrintID" %>

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
     <h4 class="fs-20 font-w600  me-auto float-left mb-0">Print Franchise ID Card</h4>
   <div class="row">
                   <div class="col-sm-2">
        
                <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"></asp:TextBox>
          
            <asp:RequiredFieldValidator ID="rfvFromDate" runat="server" Display="None" ControlToValidate="txtFromDate"
                ValidationGroup="ds" SetFocusOnError="true" ErrorMessage="Please Enter From Date in dd/mm/yyyy format."></asp:RequiredFieldValidator>
        </div>
       
        <div class="col-sm-2">
         
                <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"></asp:TextBox>
           
            <asp:RequiredFieldValidator ID="rfvToDate" runat="server" Display="None" ControlToValidate="txtToDate"
                ValidationGroup="ds" SetFocusOnError="true" ErrorMessage="Please Enter To Date in dd/mm/yyyy format."></asp:RequiredFieldValidator>
           
           
        </div>
        <div class="col-sm-1">
            <button runat="server" id="btnSearch" title="Search" class="btn btn-primary" onserverclick="btnSearch_Click"
                validationgroup="ds">
               Search
            </button>
             <div class="clearfix">
            </div>
           
        </div>
        <div class="col-sm-3">
            <asp:TextBox ID="txtUserSearch" runat="server" CssClass="form-control" placeholder="Enter Franchise Id"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvUserSearch" runat="server" ErrorMessage="Please Enter Franchise Id."
                ControlToValidate="txtUserSearch" ValidationGroup="us" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
            <div class="clearfix">
            </div>
            
        </div>
        <div class="col-sm-2">
            <button runat="server" id="btnUserSearch" title="Search" class="btn btn-primary"
                onserverclick="btnUserSearch_Click" validationgroup="us">
                <i class="fa fa-search"></i>&nbsp;Search
            </button>
        </div>
                </div>
     


    
    <div class="form-group">
        <div class="col-sm-3">
            <asp:ValidationSummary ID="ValidateDS" runat="server" ValidationGroup="ds" ShowMessageBox="true"
                ShowSummary="false" HeaderText="Please check the following..." />
            <asp:ValidationSummary ID="ValidateFranchise" runat="server" ValidationGroup="us"
                HeaderText="Please check the following..." ShowMessageBox="true" ShowSummary="false" />
        </div>
    </div>
    <div class="clearfix">
    </div>
   
  <hr />
        <div class="table table-responsive">
            <table id="tblView" runat="server" width="100%">
                <tr>
                    <td style="padding-left: 5px;" align="center">
                        <asp:GridView ID="GridUserDisplay" AutoGenerateColumns="false" Width="100%" CssClass="table table-striped table-hover mygrd"
                            EmptyDataRowStyle-ForeColor="Red" runat="server" AllowPaging="true" PageSize="50"
                            EmptyDataText="No Data Found." OnPageIndexChanging="GridUserDisplay_PageIndexChanging">
                            <Columns>
                                <asp:TemplateField HeaderText="SrNo" ItemStyle-Width="25px">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                        <asp:Label ID="lblFID" runat="server" Text='<%#Eval("FranchiseId") %>' Visible="false"></asp:Label>
                                        <asp:Label ID="lblFranName" runat="server" Text='<%#Eval("FName") %>' Visible="false"></asp:Label>
                                        <asp:Label ID="lblFranAddress" runat="server" Text='<%#Eval("franaddress") %>' Visible="false"></asp:Label>
                                        <asp:Label ID="lblDOJ" runat="server" Text='<%#Eval("doe","{0:dd/MM/yyyy}") %>' Visible="false"></asp:Label>
                                        <asp:Label ID="lblFranSponsorId" runat="server" Text='<%#Eval("SponsorID") %>' Visible="false"></asp:Label>
                                        <asp:Label ID="lblCompanyName" runat="server" Text='<%#Eval("companyname") %>' Visible="false"></asp:Label>
                                        <asp:Label ID="lblCAddress" runat="server" Text='<%#Eval("CAddress") %>' Visible="false"></asp:Label>
                                        <asp:Label ID="lblMobileNo" runat="server" Text='<%#Eval("mobile") %>' Visible="false"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="FranchiseId" HeaderText="Franchise ID" ItemStyle-Width="150px">
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="FName" HeaderText="Name" ItemStyle-Width="150px">
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Mobile" HeaderText="Mobile No" ItemStyle-Width="150px">
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
                            CssClass="btn btn-success" />
                    </td>
                </tr>
            </table>
        </div>
    
</asp:Content>
