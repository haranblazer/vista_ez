<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true" CodeFile="FranchisePaidStatus.aspx.cs" Inherits="franchise_FranchisePaidStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<table style="width: 100%">      
        <tr>
            <td>
             <asp:GridView AllowPaging="true" ID="GridView1" runat="server"  
                    CssClass="mygrd" AutoGenerateColumns="false"
                    PageSize="50" Width="100%" 
                 DataKeyNames="franchiseid,username,id"
                    OnPageIndexChanging="GridView1_PageIndexChanging" 
                    onrowcommand="GridView1_RowCommand" 
                    onrowdatabound="GridView1_RowDataBound" 
                    onrowcancelingedit="GridView1_RowCancelingEdit" >
                    <Columns>
                        <asp:TemplateField HeaderText="SrNo.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="User Name" DataField="username"  Visible="false"/>
                         <asp:BoundField HeaderText="Amount" DataField="depositedamount" />
                      <%--  <asp:BoundField HeaderText="Status" DataField="fstatus" />--%>
                        <asp:BoundField HeaderText="doe" DataField="doe" />

                        <asp:BoundField HeaderText="A-Remarks" DataField="aremarks" />

                         <asp:BoundField HeaderText="f-Remarks" DataField="fremarks" />

             <%--       <asp:TemplateField HeaderText="Remarks">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRemarks" runat="server" Height="40px" Text='<%# Bind("Fremarks") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>



                                 <asp:TemplateField HeaderText="Remarks">

<ItemTemplate >
<asp:LinkButton ID="lnkbtnEdit2" Text="Submit" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="remarks" runat="server" OnClientClick="return confirm('Are you sure you want to giving Remarks?');"  Style="text-align:center"/>



</ItemTemplate>  
</asp:TemplateField> --%>

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



</asp:Content>

