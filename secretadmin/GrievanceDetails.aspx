<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true"
    CodeFile="GrievanceDetails.aspx.cs" Inherits="secretadmin_GrievanceDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <script type="text/javascript" language="javascript">
        function ShowPopup() {
            $('#mask').show();
            $('#<%=PopupPanel.ClientID %>').show();
        }
        function HidePopup() {
            $('#mask').hide();
            $('#<%=PopupPanel.ClientID %>').hide();
        }
        $(".btnCancel").live('click', function () {
            HidePopup();
        });
    
    </script>
    <style type="text/css">
        #mask
        {
            position: absolute;
            left: 0px;
            top: 0px;
            z-index: 4;
            opacity: 0.4;
            -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=40)";
            filter: alpha(opacity=40);
            background-color: gray;
            display: none;
            width: 100%;
            height: 100%;
        }
        .style1
        {
            height: 30px;
        }
    </style>
 <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Grievance List</h4>					
				</div>
 
  
    <asp:GridView ID="GridView1" runat="server" CssClass="table table-bordered table-responsive"
        AutoGenerateColumns="false" AllowPaging="true" EmptyDataText="No Data found.">
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="Complaint ID" />
            <asp:BoundField DataField="DistributorID" HeaderText=" Distributor ID" />
            <asp:BoundField DataField="DistributorName" HeaderText="Distributor Name" />
            <asp:BoundField DataField="Emailid" HeaderText="Email Id" />
            <asp:BoundField DataField="ContactNo" HeaderText="Contact No" />
            <asp:TemplateField HeaderText="Grievance Type">
                <ItemTemplate>
                    <asp:Label ID="lblgrvnCmplnt" runat="server" Text='<%# Limit(Eval("complainttype"),40) %>'
                        ToolTip='<%# Eval("complainttype") %>'>
                    </asp:Label>
                    <asp:LinkButton ID="ReadGrvnMorelnkbtn" runat="server" Text="Read More" Visible='<%# SetVisibility(Eval("complainttype"), 40) %>'
                        OnClick="ReadGrvnMorelnkbtn_Click">
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
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
            <asp:BoundField DataField="Doe" HeaderText="Complaint Date" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="lnkReply" runat="server" OnClick="lnkReply_Click">Reply</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
   
    <asp:Panel ID="PopupPanel" runat="server" BackColor="White" Style="z-index: 111;
        width: auto; background-color: White; position: absolute; left: 30%; top: 55%;
        border: outset 1px gray; padding: 20px; display: none">
        <table class="table-responsive">
            <thead>
                <h4 class="h4">
                    Reply
                </h4>
                <hr />
            </thead>
            <tr>
                <td valign="top">
                    <asp:Label ID="lblReply" runat="server" Text="Reply"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtReply" runat="server" TextMode="MultiLine" Columns="30" Rows="5"
                        CssClass="form-control img-rounded" Style="resize: none"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvReply" runat="server" ErrorMessage="Please enter some text to reply."
                        ControlToValidate="txtReply" ValidationGroup="aa" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="right">
                    <asp:Button ID="btnRply" runat="server" Text="Reply" OnClick="btnRply_Click" CssClass="btn btn-success"
                        ValidationGroup="aa" />&nbsp;
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClientClick="HidePopup();"
                        CssClass="btn btn-success" ValidationGroup="cc" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    
</asp:Content>
