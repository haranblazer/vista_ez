<%@ Page Language="C#" MasterPageFile="MasterPage.master" EnableEventValidation="false"
    AutoEventWireup="true" CodeFile="AddCompanyDetails.aspx.cs" Inherits="winneradmin_ADDProduct"
    Title="Add Bank Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
     <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Set Company's Bank Details</h4>					
				</div>
      
   
    <asp:Panel ID="Panel1" runat="server">
        <div class="row">
            <div class="col-sm-2  control-label">
                Bank Name</div>
            <div class="col-sm-3 ">
                <asp:TextBox ID="txtBankName" runat="server" CssClass="form-control" pattern="^[a-zA-Z][a-zA-Z\s]*$"
                    placeholder="Enter Bank Name" title="Only letters is allowed with or without space."></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvBnkName" runat="server" ControlToValidate="txtBankName"
                    SetFocusOnError="true" Font-Size="Small" Display="Dynamic" ErrorMessage="Please Enter Bank Name."
                    ValidationGroup="aa" ForeColor="#FF0000"></asp:RequiredFieldValidator>
            </div>
            <div class="col-sm-2  control-label">
                A/C Type</div>
            <div class="col-sm-3 ">
                <asp:DropDownList ID="ddlAcType" runat="server" CssClass="form-control">
                    <asp:ListItem Selected="True" Value="0">--Select--</asp:ListItem>
                    <asp:ListItem>SAVING A/C</asp:ListItem>
                    <asp:ListItem>CURRENT A/C</asp:ListItem>
                    <asp:ListItem>CC A/C</asp:ListItem>
                    <asp:ListItem>OD A/C</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvAccType" runat="server" ControlToValidate="ddlAcType"
                    InitialValue="0" SetFocusOnError="true" Font-Size="Small" Display="Dynamic" ErrorMessage="Please Select A/C Type."
                    ValidationGroup="aa" ForeColor="#FF0000"></asp:RequiredFieldValidator>
            </div>
        
      
      
       <div class="clearfix"></div>
            <div class="col-sm-2  control-label">
                A/C No</div>
            <div class="col-sm-3 ">
                <asp:TextBox ID="txtAccNo" runat="server" CssClass="form-control" pattern="^[0-9]*$"
                    placeholder="Enter A/C Number" title="Please enter only numeric value without space."></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAcNo" runat="server" ControlToValidate="txtAccNo"
                    SetFocusOnError="true" Font-Size="Small" Display="Dynamic" ErrorMessage="Please Enter A/C No."
                    ValidationGroup="aa" ForeColor="#FF0000"></asp:RequiredFieldValidator>
            </div>
            <div class="col-sm-2  control-label">
                Branch</div>
            <div class="col-sm-3 ">
                <asp:TextBox ID="txtbranch" runat="server" CssClass="form-control" pattern="^[a-zA-Z][a-zA-Z\s]*$"
                    placeholder="Enter Branch" SetFocusOnError="true" title="Please enter only letters with or without space."></asp:TextBox>
                <asp:RequiredFieldValidator ID="rvfBranch" runat="server" ControlToValidate="txtbranch"
                    Font-Size="Small" Display="Dynamic" ErrorMessage="Please Enter  Branch." ValidationGroup="aa"
                    ForeColor="#FF0000"></asp:RequiredFieldValidator>
            </div>
       
        <div class="clearfix">
        </div>
     
            <label for="MainContent_txtPassword" class="col-sm-2  control-label">
                IFS Code</label>
            <div class="col-sm-3 ">
                <asp:TextBox ID="txtifs" runat="server" CssClass="form-control" pattern="^[a-zA-Z0-9]*$"
                    placeholder="Enter IFS Code" title="Only letters and numbers are allowed without space."></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvIFSC" runat="server" ControlToValidate="txtifs"
                    SetFocusOnError="true" Font-Size="Small" Display="Dynamic" ErrorMessage="Please Enter  IFS Code."
                    ValidationGroup="aa" ForeColor="#FF0000"></asp:RequiredFieldValidator>
            </div>
            <div class="col-sm-1 ">
                <asp:Button ID="btnInsert" runat="server" CssClass="btn btn-primary" OnClick="btnInsert_Click"
                    Text="Submit" ValidationGroup="aa" />
            </div>
            
       
        <div class="clearfix">
        </div>
        
    
            <div class="col-sm-2">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    HeaderText="Please correct the following errors..." ShowSummary="False" ValidationGroup="aa" />
            </div>
        </div>
         <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Bank List</h4>					
				</div>
     
        <div class="row">
            <div class="col-sm-3">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" ValidationGroup="ss"
                    placeholder="Search By Bank Name/A/C No" ToolTip="Search By Bank Name/A/C Number"
                    pattern="^[a-zA-Z0-9\s]*$" SetFocusOnError="true" title="Only letters and numbers are allowed with or without space."></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvSrc" runat="server" ControlToValidate="txtSearch"
                    Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Please Enter Bank Name or A/C Number."
                    ValidationGroup="ss" ForeColor="#FF0000"></asp:RequiredFieldValidator>
                
            </div>
            <div class="col-sm-1">
                <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" ValidationGroup="ss"
                    CssClass="btn btn-primary" Text="Search" />
                
            </div>
            <div class="col-sm-2">
                <asp:DropDownList ID="ddSearch" runat="server" AutoPostBack="True" CssClass="form-control"
                    OnSelectedIndexChanged="ddSearch_SelectedIndexChanged">
                    <asp:ListItem Value="-1">All</asp:ListItem>
                    <asp:ListItem Value="1">Active</asp:ListItem>
                    <asp:ListItem Value="0">InActive</asp:ListItem>
                </asp:DropDownList>
               
            </div>
            <div class="col-sm-2 col-xs-6">
                <asp:Button ID="btnShow" runat="server" OnClick="btnShow_Click" Text="Show All" CssClass="btn btn-primary"
                    ValidationGroup="shw" />
                
            </div>
            <div class="col-sm-1 col-xs-6 text-right">
                <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
                    Style="margin-left: 0px" Width="23px" />
                <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" />
            </div>
        </div>
      <hr />
        <asp:Label ID="lblCount" runat="server" Font-Bold="true" ForeColor="green"></asp:Label>
        <div class="table-responsive">
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                DataKeyNames="SrNo" EmptyDataText="record not found." OnPageIndexChanging="GridView1_PageIndexChanging"
                OnRowCommand="GridView1_RowCommand" OnRowDataBound="GridView1_RowDataBound" PageSize="5"
                CssClass="table table-striped table-hover mygrd" Width="100%">
                <Columns>
                    <asp:TemplateField HeaderText="Sr.No">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%-- <asp:BoundField DataField="SrNo" HeaderText="S.No"/>--%>
                    <asp:BoundField DataField="userid" HeaderText="ID" />
                    <asp:BoundField DataField="name" HeaderText="Name" />
                    <asp:BoundField DataField="CompanyBank" HeaderText="Bank Name" />
                    <asp:BoundField DataField="AccountName" HeaderText="Account Type" />
                    <asp:BoundField DataField="CompanyAccNo" HeaderText="Bank A/C No" />
                    <asp:BoundField DataField="branch" HeaderText="Branch" />
                    <asp:BoundField DataField="ifs" HeaderText="IFS Code" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:Image ID="imgStatus" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkbtnStatus" runat="server" CommandArgument="<%# ((GridViewRow)Container).RowIndex %>"
                                OnClientClick="return Confirmation();" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <i class="fa fa-edit"></i>&nbsp;<asp:LinkButton ID="lnkbtn" runat="server" Text="Edit"
                                OnClick="lnkbtn_Click" CommandArgument="<%# ((GridViewRow)Container).RowIndex %>"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <div class="clearfix">
        </div>
        <br />
    </asp:Panel>
    </div>
    <div class="clearfix"></div>
    </div>
</asp:Content>
