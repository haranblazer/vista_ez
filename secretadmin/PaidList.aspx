<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="PaidList.aspx.cs" Inherits="admin_PaidList" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
   <script type="text/javascript">
       $(function () {
           jQuery.noConflict(true);
           $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
           $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
       }); 
    </script>
   
     
    <h2 class="head">
        <i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp;Paid List</h2>
         <div class="panel panel-default">
         <br />
     <div class="col-md-12">
    
    <div class="form-group">
        <div class="col-sm-2">
           
                <asp:TextBox ID="txtFromDate" runat="server"  CssClass="form-control" placeholder="From"
                    ToolTip="dd/mm/yyyy"></asp:TextBox>
            <div class="clearfix">
            </div>
          
        </div>
        <div class="col-sm-2">
            
                <asp:TextBox ID="txtToDate" runat="server"  CssClass="form-control" placeholder="To"
                    ToolTip="dd/mm/yyyy"></asp:TextBox>
            <div class="clearfix">
            </div>
           
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txtid" runat="server" ValidationGroup="p" CssClass="form-control"
                placeholder="Search By User Id" ToolTip="Search By User Id"></asp:TextBox>
            <div class="clearfix">
            </div>
            
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txtfname" runat="server" CssClass="form-control" placeholder="Search By First Name"
                ToolTip="Search By First Name"></asp:TextBox>
            <div class="clearfix">
            </div>
          
        </div>
        <div class="col-sm-2" style="display: none">
            <asp:TextBox ID="txtlname" runat="server" CssClass="form-control" placeholder="Search By Last Name"
                ToolTip="Search By Last Name"></asp:TextBox>
            <div class="clearfix">
            </div>
            
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txtcity" runat="server" CssClass="form-control" placeholder="Search By City"
                ToolTip="Search By City"></asp:TextBox>
            <div class="clearfix">
            </div>
           
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txtstate" runat="server" CssClass="form-control" placeholder="Search By State"
                ToolTip="Search By State"></asp:TextBox>
            <div class="clearfix">            </div>
        </div>
         <div class="col-sm-2">
            <asp:TextBox ID="txtMobileNo" runat="server" MaxLength="10" CssClass="form-control"
                placeholder="Search By Mobile No" ToolTip="Search By Mobile No"></asp:TextBox>
            <div class="clearfix">
            </div>
           
        </div>
        <div class="col-sm-2">
            <asp:TextBox ID="txtPan" runat="server" MaxLength="10" CssClass="form-control" placeholder="Search By PAN No"
                ToolTip="Search By PAN No"></asp:TextBox>
            <div class="clearfix">
            </div>
            
        </div>
        <div class="col-sm-1 col-xs-6">
            <button id="Button2" runat="server" class="btn btn-success" title="Show" onserverclick="Button1_Click">
                <i class="fa fa-eye"></i>&nbsp;Show
            </button>
        </div>
<div class="col-sm-2 col-xs-6 text-right pull-right">
        <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
            Width="25px" />
        <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click"
            Style="margin-left: 0px" Width="26px" />
        <%--<asp:ImageButton ID="imgbtnpdf" runat="server" ImageUrl="~/admin/images/pdf.gif"
                        OnClick="imgbtnpdf_Click" />--%>
    </div>
    </div>
    <div class="clearfix">
    </div>
  
    
    <div class="col-sm-10 pull-right">
        <asp:CheckBoxList ID="chkListProduct" runat="server" RepeatColumns="3" Visible="false">
        </asp:CheckBoxList>
    </div>
    
    
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="center" style="height: 50px; text-align: left" valign="middle">
            <asp:Label ID="Label2" runat="server" Font-Bold="true" ForeColor="Green"/>
            </td>
        </tr>
        <tr>
            <td align="center" style="text-align: center;" valign="top">
            </td>
        </tr>
    </table>
    <div class="table-responsive">
        <asp:Panel ID="Panel1" runat="server">
            <asp:GridView ID="dglst" runat="server" AllowPaging="True" CellPadding="4" CssClass="table table-striped table-hover"
                Font-Names="Arial" Font-Size="Small" ForeColor="#333333" GridLines="None" PageSize="50"
                EmptyDataText="No Data Found" EmptyDataRowStyle-ForeColor="Red" AutoGenerateColumns="False"
                OnPageIndexChanging="dglst_PageIndexChanging" OnRowDataBound="dglst_RowDataBound"
                OnRowCommand="dglst_RowCommand">
                <FooterStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="Sr.No">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %></ItemTemplate>
                        <ItemStyle Font-Bold="True" Height="20px" />
                    </asp:TemplateField>
                     <asp:BoundField DataField="AppMstregno" HeaderText="User ID" />
                       <asp:BoundField DataField="appmstfname" HeaderText="Name" />
                        <asp:BoundField DataField="appmstpassword" HeaderText="Pwd" />
                     <asp:BoundField DataField="appmstmobile" HeaderText="Mobile" />
                    <asp:BoundField DataField="email" HeaderText="Email ID" />
                  
                    <asp:BoundField DataField="SponsorID" HeaderText="Sponsor ID" />
                   
                     <asp:BoundField DataField="Sponsorname" HeaderText="Sponsor Name" />
                    <asp:BoundField DataField="gname" HeaderText="Father Name" />
                 
                    <asp:BoundField DataField="tlper" HeaderText="Rank" />
                    <asp:BoundField DataField="appmstaddress1" HeaderText="Address" />
                    <asp:BoundField DataField="AppMstCity" HeaderText="City" />
                    <asp:BoundField DataField="AppMstState" HeaderText="State" />
                    <asp:BoundField DataField="appmstpincode" HeaderText="Pincode" />
                    <asp:BoundField DataField="panno" HeaderText="PAN"></asp:BoundField>
                    <asp:BoundField DataField="nom_name" HeaderText="Nominee"></asp:BoundField>
                    <asp:BoundField DataField="nom_rela" HeaderText="Nom_rela"></asp:BoundField>
                    <asp:BoundField DataField="Bankname" HeaderText="Bank"></asp:BoundField>
                    <asp:BoundField DataField="branch" HeaderText="Branch"></asp:BoundField>
                    <asp:BoundField DataField="acountno" HeaderText="A/C"></asp:BoundField>
                    <asp:BoundField DataField="ifscode" HeaderText="IFSCODE"></asp:BoundField>
                    <asp:BoundField DataField="appmstpaid" HeaderText="Status" />
                    <%--
                                  <asp:TemplateField>
                                <ItemTemplate>
               <asp:LinkButton ID="LinkButton1" runat="server" CommandName="PRINT" CommandArgument='<%# Eval("Appmstregno") %>' CausesValidation="false">Invoice</asp:LinkButton>

                                </ItemTemplate>
                            </asp:TemplateField>--%>
                </Columns>
            </asp:GridView>
        </asp:Panel>
    </div>
    <div class="clearfix">
    </div>
    <br />
    </div>
    <div class="clearfix"></div>
    </div>
</asp:Content>
