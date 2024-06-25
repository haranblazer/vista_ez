<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="userWalletRequestApproved.aspx.cs" MasterPageFile="MasterPage.master" Inherits="secretadmin_userWalletRequestApproved" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script> 
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" /> 
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript"> 
        $JD(function () {
            $JD('#<%=txtFromdate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtTodate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">C-Wallet Request List</h4>
    <div class="row">
                   <div class="col-sm-2">
                    <asp:TextBox ID="txtFromdate" runat="server" CausesValidation="True" CssClass="form-control"
                        ToolTip="dd/mm/yyyy" ValidationGroup="a"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFromDate" runat="server" ControlToValidate="txtFromdate" Display="None"
                        ErrorMessage="From date require." SetFocusOnError="True" ValidationGroup="a"></asp:RequiredFieldValidator>
                </div>
                
                <div class="col-sm-2">
                    <asp:TextBox ID="txtTodate" runat="server" CausesValidation="True" ToolTip="dd/mm/yyyy"
                        CssClass="form-control" ValidationGroup="a"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvToDate" runat="server" ControlToValidate="txtTodate"
                        Display="Dynamic" ErrorMessage="To date require." ValidationGroup="a"></asp:RequiredFieldValidator>
                    
                </div>
                 <div class="col-sm-2">
                     <asp:DropDownList ID="ddl_Status" runat="server" CssClass="form-control">
                         <asp:ListItem Value="0">Waiting</asp:ListItem>
                        <asp:ListItem Value="1">Approved</asp:ListItem>
                    </asp:DropDownList>
                   
                </div>

                <div class="col-sm-1 col-xs-6">
                    <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" OnClick="Button1_Click"
                        Text="SHOW" ValidationGroup="tv" />
                    
                </div>
                <div class="pull-right text-right col-sm-2 col-xs-6">
                    <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" />&nbsp;
                        <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click" />&nbsp;
                        <asp:ImageButton ID="imgbtnPdf" runat="server" ImageUrl="images/pdf.gif" OnClick="imgbtnPdf_Click" />
                </div>
                </div>

    <hr />
   
            <div class="form-group">
                <asp:Label ID="LblTotalRecord" runat="server" Font-Bold="True"></asp:Label>
                <asp:Label ID="LblAmount" runat="server" Font-Bold="True"></asp:Label>
            </div>
            <div class="table-responsive">
                <asp:GridView ID="GridView1" DataKeyNames="srno" EmptyDataText="No data found." runat="server"
                    AllowPaging="True" AutoGenerateColumns="False" CssClass="table table-hover mygrd"
                    Width="100%" OnPageIndexChanging="dglst_PageIndexChanging" PageSize="50" Font-Size="9pt" 
                     ShowFooter="true" OnRowDataBound="GridView1_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="SR.NO.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                                <asp:HiddenField ID="hdf_Status" runat="server" Value='<%#Eval("statusVal") %>' />
                            </ItemTemplate>
                            <FooterTemplate>Total:</FooterTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="userid" HeaderText="UserId" />
                        <asp:BoundField DataField="fname" HeaderText="Name" />
                        <asp:BoundField DataField="amt" HeaderText="Amount" />
                        <asp:BoundField DataField="redate" HeaderText="Request Date" />
                          <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:Label ID="lbl_StatusText" runat="server" Text='<%#Eval("Status") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Font-Bold="True" Height="20px" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="apdate" HeaderText="Approved Date" />
                    </Columns>
                    <HeaderStyle Font-Size="9pt" />
                </asp:GridView>
            </div>
            <script type="text/javascript">
                $(document).ready(

 function () {

     $('.6').show();
 }
);
            </script>


</asp:Content>
