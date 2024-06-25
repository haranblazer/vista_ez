<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="FranchisePayment.aspx.cs" Inherits="Admin_FranchisePayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="clearfix"> </div> <br />

<div class="table-responsive">
<table style="width: 100%">
  
        <tr>
            <td>
             <asp:GridView AllowPaging="true" ID="GridView1" runat="server"  
                    CssClass="mygrd" AutoGenerateColumns="false"
                    PageSize="50" Width="100%" 
                    OnPageIndexChanging="GridView1_PageIndexChanging" 
                    DataKeyNames="franchiseid,username,id" onrowcommand="GridView1_RowCommand" 
                    onrowdatabound="GridView1_RowDataBound" 
                    onrowcancelingedit="GridView1_RowCancelingEdit" >
                    <Columns>
                        <asp:TemplateField HeaderText="SrNo.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="User ID" DataField="username" />
                        <asp:BoundField HeaderText="Name" DataField="fname" />
                         <asp:BoundField HeaderText="Amount" DataField="depositedamount" />
                        <asp:BoundField HeaderText="Status" DataField="fstatus" />
                        <asp:BoundField HeaderText="doe" DataField="doe" />

                         <asp:BoundField HeaderText="F-Remarks" DataField="fremarks" />

                          <asp:TemplateField HeaderText="Remarks">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRemarks" runat="server" Height="40px" Text='<%# Bind("aremarks") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>



                                 <asp:TemplateField HeaderText="Remarks">

<ItemTemplate >
<asp:LinkButton ID="lnkbtnEdit2" Text="Submit" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="remarks" runat="server" OnClientClick="return confirm('Are you sure you want to giving Remarks?');"  Style="text-align:center"/>



</ItemTemplate>  
</asp:TemplateField> 

                  

                   

                        <asp:TemplateField HeaderText="Approval Status">

<ItemTemplate >
<asp:LinkButton ID="lnkbtnEdit1" Text="Approve" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="approve" runat="server" OnClientClick="return confirm('Are you sure you want to Approve This Status?');"  Style="text-align:center"/>



</ItemTemplate>  
</asp:TemplateField> 

 <asp:TemplateField HeaderText="status" Visible="false">
                          <ItemTemplate>
                              <asp:Label ID="Label1" runat="server" Text='<%#Eval("status") %>'></asp:Label>
                          </ItemTemplate>
                          </asp:TemplateField>

</Columns>

</asp:GridView>
            </td>

            </tr>

            </table>
</div>
</asp:Content>

