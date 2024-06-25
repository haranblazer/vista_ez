<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    EnableEventValidation="false" AutoEventWireup="true" CodeFile="Title.aspx.cs"
    Inherits="secretadmin_Title" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">       
         $(function () {
            jQuery.noConflict(true);
            $('#<%=txtFromDate.ClientID %>').datepick({ dateFormat: 'dd/mm/yyyy', maxDate: 0 });
            $('#<%=txtToDate.ClientID %>').datepick({ dateFormat: 'dd/mm/yyyy', maxDate: 0 });

        }); 
    </script>
   
        <h2 class="head">
            <i class="fa fa-gift" aria-hidden="true"></i>&nbsp;Title List
        </h2>
   <div class="panel panel-default">
    <div class="col-md-12">
    <div class="clearfx"></div>
    <br />

    <div class="form-group">
        <div class="col-sm-1">
            From
        </div>
        <div class="col-sm-2">
            <div class="input-group">
                <asp:TextBox ID="txtFromDate" runat="server" placeholder="DD/MM/YYYY" pattern="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                    MaxLength="10" CssClass="form-control" title="From date should be as dd/mm/yyyy"
                    required="required"></asp:TextBox>
                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
            </div>
        </div>
        <div class="col-sm-1">
            To
        </div>
        <div class="col-sm-2">
            <div class="input-group">
                <asp:TextBox ID="txtToDate" runat="server" placeholder="DD/MM/YYYY" pattern="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                    MaxLength="10" CssClass="form-control" title="To date should be as dd/mm/yyyy"
                    required="required"></asp:TextBox>
                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
            </div>
            <div class="clearfix">
            </div>
            <br />
        </div>
    <div class="col-sm-1">
            <asp:Button ID="btSearchDatewise" runat="server" Text="Search" 
                CssClass="btn btn-success" onclick="btSearchDatewise_Click"
                 />
           <%-- <div class="clearfix">
            </div>
            <br />--%>
        </div>
        <div class="col-sm-2">
            <asp:DropDownList ID="ddlTitleList" runat="server" AutoPostBack="true" CssClass="form-control"
                OnSelectedIndexChanged="ddlTitleList_SelectedIndexChanged">
            </asp:DropDownList>
        </div>

         <div class="col-sm-2">
            <asp:Textbox ID="txtUser" runat="server" AutoPostBack="true" CssClass="form-control" placeholder="Enter Userid">
            </asp:Textbox>
        </div>
             <div class="col-sm-1">
            <asp:Button ID="btnSearchByDate" runat="server" Text="Search" CssClass="btn btn-success"
                OnClick="btnSearchByDate_Click" />
            <div class="clearfix">
            </div>
            <br />
        </div>
        <div class=" pull-right">
            <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                OnClick="ibtnExcelExport_Click" />
            <asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="images/word.jpg" OnClick="ibtnWordExport_Click" />
        </div>
    </div>
    <div class="clearfix">
    </div>
    <br />
    <div class="col-sm-12">
        
        <asp:Label ID="lblMessage" runat="server" CssClass="control-label" Font-Bold="true"></asp:Label>
        <div class="table table-responsive">
            <asp:GridView ID="GridView1" runat="server" CssClass="table table-striped table-hover mygrd" 
                PageSize="50" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Record Found."
                OnPageIndexChanging="GridView1_PageIndexChanging" AllowPaging="true" >
                 <Columns>
                    <asp:TemplateField HeaderText="Sr No.">
                        <ItemTemplate>
                            <asp:Label ID="lblsrno" runat="server" Text='<%# Container.DataItemIndex +1%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="userid" HeaderText="User ID" />
                    <asp:BoundField DataField="name" HeaderText="User Name" />
                    <asp:BoundField DataField="Title" HeaderText="Title" />
                    <asp:BoundField DataField="doe" HeaderText="Date of Achievement" />
                     </Columns>
            </asp:GridView>
         <%--   <asp:GridView ID="GridViewA" runat="server" CssClass="table table-striped table-hover mygrd" 
                PageSize="50" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Record Found."
                OnPageIndexChanging="GridViewA_PageIndexChanging" AllowPaging="true" 
                >
                <Columns>
                    <asp:TemplateField HeaderText="Sr No.">
                        <ItemTemplate>
                            <asp:Label ID="lblsrno" runat="server" Text='<%# Container.DataItemIndex +1%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="userid" HeaderText="User ID" />
                    <asp:BoundField DataField="name" HeaderText="User Name" />
                    <asp:BoundField DataField="Title" HeaderText="Title" />
                    <asp:BoundField DataField="doe" HeaderText="Date of Achievement" />
               <asp:BoundField DataField="leftpoint" HeaderText="left point" />
                    <asp:BoundField DataField="rightpoint" HeaderText="Right point" />

                    <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                HeaderText="Transaction No.">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtdraftno" runat="server" CssClass="form-control" Text= '<%# Eval("transactionid")%>' Style="max-width: 220px; 
                                        min-width: 180px"></asp:TextBox>
                                </ItemTemplate>
                     </asp:TemplateField>
                    <asp:TemplateField HeaderText="Remarks">
                     <ItemTemplate>
                                    <asp:TextBox ID="txtcomment" runat="server" CssClass="form-control"  Text='<%# Eval("remarks") %>'  Style="max-width: 220px;
                                        min-width: 180px"></asp:TextBox>
                                </ItemTemplate>
                     </asp:TemplateField>




                </Columns>
            </asp:GridView>--%>
        </div>


        
              
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Update" CssClass="btn btn-success" Visible=false/>
           
 
           </div>
           </div>
          <div class="clearfix"></div>
           </div>
    
</asp:Content>
