<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="CostReport.aspx.cs" Inherits="secretadmin_CostReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

       <h2 class="head">
            <i class="fa fa-search" aria-hidden="true"></i>&nbsp;(Package&Upgrade Payout) Profit/Loss Report...</h2>
            <div class="panel panel-default">
  <div class="col-md-12">
        <div class="clearfix">
        </div>
        <br />
     <div class="form-group">
     <div class="col-md-6 col-xs-3">
     <label for="MainContent_myForm_txtPname" class="txt col-sm-6 col-xs-3 control-label">Select Payout:</label>
     </div>
       <div class="col-md-7 col-xs-9">
        <asp:DropDownList ID="ddlpayout"  runat="server"  CssClass="form-control" 
              onselectedindexchanged="ddlpayout_SelectedIndexChanged" AutoPostBack="true">                     
       </asp:DropDownList>
     </div>
    </div>
    <div class="clearfix">
        </div>
        <br />
      <div class="table-responsive">

        <asp:GridView AllowPaging="true" ID="GridView1" runat="server" CssClass="table table-striped table-hover mygrd"
            AutoGenerateColumns="false"  DataKeyNames="mind,maxd"
            Width="100%"  EmptyDataText="No Data Found" onrowcommand="GridView1_RowCommand"
           >
            <Columns>

                <asp:TemplateField HeaderText="Sale" >
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server"  Text='<%#Eval("Sale") %>' CommandName="c1" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                 <asp:TemplateField HeaderText="GST" >
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton2" runat="server"  Text='<%#Eval("tax") %>' ForeColor="Red" CommandName="c2" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Payout" >
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton3" runat="server"  Text='<%#Eval("payout") %>' ForeColor="Red" CommandName="c3" CommandArgument='<%#((GridViewRow)Container).RowIndex %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                   <asp:TemplateField HeaderText="TDS" >
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton7" runat="server"  Text='<%#Eval("tds") %>' CommandName="c4" ForeColor="Red" CommandArgument='<%#((GridViewRow)Container).RowIndex %>' ></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>


                <asp:TemplateField HeaderText="Cost" >
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton4" runat="server"  Text='<%#Eval("cost") %>' ForeColor="Red" Enabled="false"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField> 
                
                 <asp:TemplateField HeaderText="net Profit/Loss" >
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton5" runat="server"  Text='<%#Eval("netpr") %>' Enabled="false"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField> 
                
                 <asp:TemplateField HeaderText="net Profit/Loss %" >
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton6" runat="server"  Text='<%#Eval("netp") %>' Enabled="false" ></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>  
                
                         



            </Columns>
        </asp:GridView>

        </div>

        <br />
        <br />
        </div><div class="clearfix">
        </div>
        </div>
      

   


</asp:Content>

