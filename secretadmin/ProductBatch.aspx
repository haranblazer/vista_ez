<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="ProductBatch.aspx.cs" Inherits="secretadmin_ProductBatch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function Confirm() {
            var proceed = confirm("Do you really want to continue?");
            if (proceed == true) {
                return true;
            }
            else {
                return false;
            }
        }
    </script>
   
        <h3 class="head">
           <i class="fa fa-barcode" aria-hidden="true"></i>   Product batch Activation/Deactivation</h3>
             <div class="panel panel-default">
  <div class="col-md-12">
   
           <br />
        <asp:GridView ID="gridapprove" runat="server" AutoGenerateColumns="False" AllowPaging="True"
            PageSize="50" EmptyDataText="No Data Found." DataKeyNames="pid,batchid,status"
            CssClass="table table-striped table-hover" OnPageIndexChanging="gridapprove_PageIndexChanging"
            OnRowCommand="gridapprove_RowCommand">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="pid" HeaderText="Product ID" />
                <asp:BoundField DataField="pname" HeaderText="Product Name" />
                <asp:BoundField DataField="batchno" HeaderText="Batch No" />
                 <asp:BoundField DataField="batchdate" HeaderText="Batch Date" />
                <asp:BoundField DataField="balqty" HeaderText="QTY" />
                <asp:TemplateField HeaderText="Staus">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkactive" runat="server" CommandName="A" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'
                            Text='<%# Eval("pstatus") %>' OnClientClick="return Confirm();"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
  
   
    <div class="clearfix"></div>
      </div>
</asp:Content>
