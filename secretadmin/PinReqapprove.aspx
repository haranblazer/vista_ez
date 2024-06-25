<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="PinReqapprove.aspx.cs" Inherits="admin_PinReqapprove" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function Confirm() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Do you want to Conform?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
    </script>
    <div align="center">
        <asp:Label ID="lbl_message" runat="server" Text="Label" Visible="False" Font-Size="Larger"
            ForeColor="#FF3300"></asp:Label>
    </div>
    <div align="center">
        <asp:GridView ID="GridView1" runat="server" Width="100%" AutoGenerateColumns="false"
            CssClass="mygrd" OnRowCommand="GridView1_RowCommand" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
            <Columns>
                <asp:TemplateField HeaderText="S.No.">
                    <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ID">
                    <ItemTemplate>
                        <asp:Label ID="lbl_regno" Text='<%#Eval("appmstregno") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Product Name">
                    <ItemTemplate>
                        <asp:Label ID="lblpname" Text='<%# Eval("pname") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Amount">
                    <ItemTemplate>
                        <asp:Label ID="lblamount" Text='<%#Eval("amount") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="No. Of Pins">
                    <ItemTemplate>
                        <asp:Label ID="lblnoofpins" Text='<%# Eval("noofpin") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="150px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Request Date">
                    <ItemTemplate>
                        <asp:Label ID="lbl_DOE" Text='<%# Eval("rdate") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="120px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Remarks">
                    <ItemTemplate>
                        <asp:Label ID="lbl_Circle" Text='<%# Eval("remarks") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="150px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Option">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("srno") %>'
                            CommandName="ap">Approve</asp:LinkButton>
                        <asp:LinkButton ID="LinkButton2" runat="server" Text="Invoice" CommandArgument='<%# Eval("srno") %>'
                            CommandName="re">Reject</asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle Width="100px" />
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <div id="panlID1" runat="server" visible="false" style="margin-left: 30%; background-color: #fff;
        border-radius: 5px; -moz-border-radius: 5px; position: absolute; width: 300px;
        padding: 20px; z-index: 5px; top: 50px; border: solid 5px #013a77;">
        <table>
            <tr>
                <td>
                    Comment:
                </td>
                <td>
                    <asp:TextBox ID="txtcomment" runat="server" CssClass="widthinput" TextMode="MultiLine"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtcomment"
                        Display="None" ErrorMessage="Please Enter  Comments!" ForeColor="#C00000" ValidationGroup="NJ">Please Enter  Comments!</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <asp:Button ID="RaiseDisputetxt" runat="server" Text="Submit" CssClass="btn" OnClick="RaiseDisputetxt_Click"
                        ValidationGroup="NJ" />
                    <asp:Button ID="Button1" runat="server" Text="Skip" CssClass="btn" OnClick="Button1_Click" />
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="NJ" />
                </td>
            </tr>
        </table>
    </div>
    <div id="panapid" runat="server" visible="false" style="margin-left: 30%; background-color: #fff;
        border-radius: 5px; -moz-border-radius: 5px; position: absolute; width: 300px;
        padding: 20px; z-index: 5px; top: 50px; border: solid 5px #013a77;">
        <table>
            <tr>
                <td>
                    User Id
                </td>
                <td>
                    <asp:TextBox ID="txtuserid" runat="server" CssClass="widthinput" Enabled="false"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtuserid"
                        Display="None" ErrorMessage="Please Enter  User Id!" ForeColor="#C00000" ValidationGroup="NJ">Please Enter  User Id!</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Approval Amount:
                </td>
                <td>
                    <asp:TextBox ID="txtapamt" runat="server" CssClass="widthinput" Enabled="false"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtapamt"
                        Display="None" ErrorMessage="Please Enter  User Id!" ForeColor="#C00000" ValidationGroup="NJ">Please Enter  Approval Amount!</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Comment:
                </td>
                <td>
                    <asp:TextBox ID="txtmessage" runat="server" CssClass="widthinput" TextMode="MultiLine"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtcomment"
                        Display="None" ErrorMessage="Please Enter  Comments!" ForeColor="#C00000" ValidationGroup="NJ">Please Enter  Comments!</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <asp:Button ID="btnsubmit" runat="server" Text="Submit" CssClass="btn" ValidationGroup="NJ"
                        OnClick="btnsubmit_Click" />
                    <asp:Button ID="btnskip" runat="server" Text="Skip" CssClass="btn" OnClick="btnskip_Click" />
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="NJ" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
