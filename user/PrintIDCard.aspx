<%@ Page Title="" Language="C#" MasterPageFile="user.master" AutoEventWireup="true"
    CodeFile="PrintIDCard.aspx.cs" Inherits="admin_PrintIDCard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   
    <style>
    tr:nth-child(even) {background-color: #f8f8f8;}
    </style>   

   <div class="container-fluid page__heading-container">
                        <div class="page__heading d-flex align-items-center">
                            <div class="flex">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb mb-0">
                                        <li class="breadcrumb-item"><a href="#">My Information</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Print ID Card</li>
                                    </ol>
                                </nav>
                                <h1 class="m-0">Print ID Card</h1>
                            </div>
                             <a href="javascript:history.go(-1)"><i class="fa fa-arrow-left"></i></a>
                        </div>
                    </div>
          
   <div class="container-fluid page__container">            
         <div class="panel card card-body">
        <div class="panel panel-default">          
            <div class="panel-body">         
                <div class="form-group" style="display:none">
                    <div class="col-sm-1">
                        <label>From</label>
                    </div>
                    <div class="col-sm-2">
                        <div class="input-group">
                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"></asp:TextBox><span
                                class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvFromDate" runat="server" Display="None" ControlToValidate="txtFromDate"
                            ValidationGroup="ds" SetFocusOnError="true" ErrorMessage="Please Enter From Date in dd/mm/yyyy format."></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-sm-1">
                        <label>
                            To</label>
                    </div>
                    <div class="col-sm-2">
                        <div class="input-group">
                            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" placeholder="DD/MM/YYYY"></asp:TextBox><span
                                class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvToDate" runat="server" Display="None" ControlToValidate="txtToDate"
                            ValidationGroup="ds" SetFocusOnError="true" ErrorMessage="Please Enter To Date in dd/mm/yyyy format."></asp:RequiredFieldValidator>
                        <div class="clearfix">
                        </div>
                        <br />
                    </div>
                    <div class="col-sm-1">
                        <%-- <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success"
                OnClick="btnSearch_Click" ValidationGroup="ds" />--%>
                        <button runat="server" id="btnSearch" title="Search" class="btn btn-success" onserverclick="btnSearch_Click"
                            validationgroup="ds">
                            <i class="fa fa-search"></i>&nbsp;Search
                        </button>
                        <div class="clearfix">
                        </div>
                        <br />
                    </div>
                    <div class="col-sm-2">
                        <asp:TextBox ID="txtUserSearch" runat="server" CssClass="form-control" placeholder="Enter User Id"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvUserSearch" runat="server" ErrorMessage="Please Enter User Id."
                            ControlToValidate="txtUserSearch" ValidationGroup="us" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                        <div class="clearfix">
                        </div>
                        <br />
                    </div>
                    <div class="col-sm-1">
                        <%--   <asp:Button ID="btnUserSearch" runat="server" Text="Search" CssClass="btn btn-success"
                OnClick="btnUserSearch_Click" ValidationGroup="us" />--%>
                        <button runat="server" id="btnUserSearch" title="Search" class="btn btn-success"
                            onserverclick="btnUserSearch_Click" validationgroup="us">
                            <i class="fa fa-search"></i>&nbsp;Search
                        </button>
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="ds"
                            ShowMessageBox="true" ShowSummary="false" HeaderText="Please check the following..." />
                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" ValidationGroup="us"
                            HeaderText="Please check the following..." ShowMessageBox="true" ShowSummary="false" />
                    </div>
                </div>
               
                <br />
                
                    <div id="tblView" runat="server" class="table table-responsive">
                       
                                    <asp:GridView ID="GridUserDisplay" AutoGenerateColumns="false" Width="100%" CssClass="dataTable no-footer"
                                        EmptyDataRowStyle-ForeColor="Red" runat="server" AllowPaging="true" PageSize="25"
                                        EmptyDataText="No Data." OnPageIndexChanging="GridUserDisplay_PageIndexChanging">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SrNo" ItemStyle-Width="25px">
                                                <ItemTemplate>
                                                    <%#Container.DataItemIndex+1 %>
                                                    <asp:Label ID="lblUID" runat="server" Text='<%#Eval("appmstregno") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblUserName" runat="server" Text='<%#Eval("appmstfname") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblUserAddress" runat="server" Text='<%#Eval("AppmstAddress1") %>'
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
                              
                             <br />
                                    <asp:Button ID="btnSubmit" runat="server" Text="SUBMIT" OnClick="btnSubmit_Click"
                                        CssClass="btn btn-success" />
                               
                       
                    </div>
                

                </div>
                </div>
                </div>
                </div>
    </div>
   
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
   
    <script type="text/javascript">
        $(function () {
           
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy', maxDate: 0 });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy', maxDate: 0 });
        });
    
    </script>
</asp:Content>
