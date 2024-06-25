<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="RepliedList.aspx.cs" Inherits="admin_RepliedList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Replied List</h4>					
				</div>

 
    <asp:GridView ID="GridView2" runat="server" AllowPaging="true" CssClass="table table-bordered table-responsive"
        AutoGenerateColumns="false" EmptyDataText="No Data found.">
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="Complaint ID" />
            <asp:BoundField DataField="DistributorID" HeaderText=" Distributor ID" />
            <asp:BoundField DataField="DistributorName" HeaderText="Distributor Name" />
            <asp:BoundField DataField="Emailid" HeaderText="Email Id" />
            <asp:BoundField DataField="ContactNo" HeaderText="Contact No" />
            <asp:TemplateField HeaderText="Grievance Type">
                <ItemTemplate>
                    <asp:Label ID="lblrplyCmplnt" runat="server" Text='<%# Limit(Eval("complainttype"),40) %>'
                        ToolTip='<%# Eval("complainttype") %>'>
                    </asp:Label>
                    <asp:LinkButton ID="ReadRplyMorelnkbtn" runat="server" Text="Read More" Visible='<%# SetVisibility(Eval("complainttype"), 40) %>'
                        OnClick="ReadRplyMorelnkbtn_Click">
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Doe" HeaderText="Complaint Date" />
            <asp:TemplateField HeaderText="Grievance">
                <ItemTemplate>
                    <asp:Label ID="lblremarkgrvnCmplnt" runat="server" Text='<%# Limit(Eval("remarks"),40) %>'
                        ToolTip='<%# Eval("remarks") %>'>
                    </asp:Label>
                    <asp:LinkButton ID="ReadRmrkGrvnMorelnkbtn" runat="server" Text="Read More" Visible='<%# SetVisibility(Eval("remarks"), 40) %>'
                        OnClick="ReadRmrkGrvnMorelnkbtn_Click">
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ReplyDate" HeaderText="Replied Date" />
            <asp:TemplateField HeaderText="Replied Text">
                <ItemTemplate>
                    <asp:Label ID="lblRplidCmplnt" runat="server" Text='<%# Limit(Eval("reply"),40) %>'
                        ToolTip='<%# Eval("reply") %>'>
                    </asp:Label>
                    <asp:LinkButton ID="ReadReplyGrvnMorelnkbtn" runat="server" Text="Read More" Visible='<%# SetVisibility(Eval("reply"), 40) %>'
                        OnClick="ReadReplyGrvnMorelnkbtn_Click">
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    
</asp:Content>
