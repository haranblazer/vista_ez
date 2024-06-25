<%@ Page Title="" Language="C#" AutoEventWireup="true" EnableEventValidation="false" MasterPageFile="MasterPage.master"
    CodeFile="FranWalReq.aspx.cs" Inherits="secretadmin_FranWalReq" %>

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
    <style type="text/css">
        #tooltip {
            position: absolute;
            border: 2px solid red;
            background-color: #FFFFE1;
            padding: 2px 5px;
            text-align: left;
            font-family: arial;
            font-size: 12px;
            color: #000000;
            display: none;
            width: auto;
            height: auto;
        }
    </style>
    <h4 class="fs-20 font-w600  me-auto float-left mb-0">F-Wallet Request List</h4>
<div class="row">
                   <div class="col-sm-2">
                    <asp:TextBox ID="txtFromdate" runat="server" CausesValidation="True" ToolTip="dd/mm/yyyy"
                        CssClass="form-control" ValidationGroup="a"></asp:TextBox>
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
                <div class="col-sm-2">
                    <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" OnClick="Button1_Click"
                        Text="SHOW" ValidationGroup="tv" />&nbsp;
                        <%--<asp:Button ID="btnShowall" runat="server" CssClass="btn" OnClick="btnShowall_Click"
                    Text="SHOW ALL" ValidationGroup="tv" />--%>
                </div>
                <div class="col-md-2">
                <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" />&nbsp;
                    <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg" OnClick="imgbtnWord_Click" />&nbsp;
                    <asp:ImageButton ID="imgbtnPdf" runat="server" ImageUrl="images/pdf.gif" OnClick="imgbtnPdf_Click" />
            </div>
                </div>     
   <hr />
            <div class="table-responsive">
                <asp:GridView ID="GridView1" DataKeyNames="WalletRequestId" EmptyDataText="No data found."
                    runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="table table-hover mygrd"
                    OnPageIndexChanging="dglst_PageIndexChanging" PageSize="50" Font-Size="9pt" OnRowCommand="GridView1_RowCommand"
                    OnRowDataBound="dglst_RowDataBound" ShowFooter="true">
                    <Columns>
                        <asp:TemplateField HeaderText="SR.NO.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                                <asp:HiddenField ID="hdf_Status" runat="server" Value='<%#Eval("Status") %>' />
                            </ItemTemplate>
                            <FooterTemplate>Total:</FooterTemplate>

                            <ItemStyle Font-Bold="True" Height="20px" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="franchiseid" HeaderText="UserId" />
                        <asp:BoundField DataField="fname" HeaderText="Name" />
                        <asp:BoundField DataField="amt" HeaderText="Amount" />
                         <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:Label ID="lbl_StatusText" runat="server" Text='<%#Eval("StatusText") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Font-Bold="True" Height="20px" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="redate" HeaderText="Request Date" />
                        <%--<asp:TemplateField>
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink3" ToolTip='<%#Eval("payDetail") %>' runat="server" CssClass="tooltip">
                              <b> Payment</b> 
                                </asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        <asp:BoundField DataField="TransactionNo" HeaderText="Tran No" />
                        <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                       
                        <asp:TemplateField HeaderText="E-Password" ItemStyle-Width="150px">
                            <ItemTemplate>
                                <asp:TextBox ID="txtPwd" runat="server" MaxLength="20" TextMode="Password" CssClass="form-control"
                                    placeholder="Enter E-Password" Style="max-width: 160px; min-width: 140px"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <table>
                                    <tr>
                                        <td>
                                             <asp:Label ID="lbl_App_Rej" runat="server"></asp:Label>
                                            <asp:LinkButton ID="LinkButton1" CommandName="Aprove" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                                                runat="server" TabIndex="1" Text="Approve" CssClass="btn btn-primary" OnClientClick="return confirm('Are you sure to approve the user?')"></asp:LinkButton>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="LinkButton2" CommandName="Reject" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'
                                                TabIndex="2" runat="server" CssClass="btn btn-danger" Text="Reject" OnClientClick="return confirm('Are you sure to reject the user?')"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle Font-Size="9pt" />
                </asp:GridView>
            </div>
            <script type="text/javascript">
                $(document).ready(

 function () {

     $('.6').show();
 }
            </script>
       
    
     
</asp:Content>
