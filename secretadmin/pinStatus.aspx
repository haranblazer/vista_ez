<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    Debug="true" CodeFile="pinStatus.aspx.cs" Inherits="admin_pinStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="title" class="b2">
        <h2>
            Pin Status</h2>
        <!-- TitleActions -->
        <!-- /TitleActions -->
    </div>
   <script >      
           $(document).ready(function() {

           var dataUserID = document.getElementById("<%=divPins.ClientID%>").innerHTML.split(",");
           $('#<%=txtPinSrNo.ClientID %>').autocomplete(dataUserID);
           });      
    </script>
    <table style="width: 100%;">
        <tr>
            <td>
                <table style="width: 100%;">
                    <tr id="trtxt" runat="server">
                        <td style="text-align: left" class="top_table" >
                            Enter pin serial no.&nbsp; :</td>
                        <td class="top_table" >
                            <asp:TextBox ID="txtPinSrNo" runat="server" Height="19px" onkeypress="return Checknumeric()"></asp:TextBox>&nbsp;
                            <asp:Label ID="lblMsg1" runat="server" Text="Label" Width="75px" ForeColor="White"
                                Visible="False" Font-Size="Small"></asp:Label>
                <asp:Button ID="btnSubmit" runat="server" Style="position: relative" Text="Submit"
                    OnClick="btnSubmit_Click" TabIndex="13" ValidationGroup="ps" CssClass="btn" />
                &nbsp;</td>
                    </tr>
                    <tr id="trpinno" runat="server">
                        <td >
                            Pin serial no. :</td>
                        <td>
                            <asp:Label ID="lblPinNo" runat="server" ></asp:Label></td>
                    </tr>
                    <tr id="trstatus" runat="server">
                        <td style="width: 137px" class="alignr">
                            Pin status&nbsp; :</td>
                        <td>
                            <asp:Label ID="lblStatus" runat="server" 
                                Font-Bold="True"></asp:Label></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="Tr1" runat="server">
            <td colspan="1">
                <asp:GridView ID="dglst" runat="server" AutoGenerateColumns="False" CellPadding="4"
                    Font-Size="Small" GridLines="None" PageSize="50" CssClass="mygrd">
                    <Columns>
                        <asp:TemplateField HeaderText="SrNo">
                            <ItemStyle Font-Bold="True" Height="20px" />
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="PinSrNo" HeaderText="PinSerialNo" />
                        <asp:BoundField DataField="Allotedto" HeaderText="Alloted To" />
                        <asp:BoundField DataField="name" HeaderText="User Name"></asp:BoundField>
                        <asp:BoundField DataField="appmstmobile" HeaderText="Mobile No" />
                        <asp:BoundField DataField="Allotmentdate" HeaderText="Allotment Date" />
                        <asp:BoundField DataField="UsedBy" HeaderText="Used By" />
                        <asp:BoundField DataField="uname" HeaderText="UsedBy Name" />
                        <asp:BoundField DataField="Amount" HeaderText="Amount" />
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr id="trdeac" runat="server">
            <td>
                &nbsp;<asp:CheckBox ID="chkDeactivate" runat="server" Text="Do u want to deactivate it?"
                    CssClass="radios" />
                <asp:Button ID="btnDeActivate" runat="server" Style="position: relative" Text="De Activate"
                    OnClick="btnDeActivate_Click" TabIndex="13" CssClass="btn" />
                </td>
        </tr>
        <tr id="tractive" runat="server">
            <td>
                &nbsp;<asp:CheckBox ID="chkActiavte" runat="server" Text="Do you want to activate it?"
                    CssClass="radios" />
                <asp:Button ID="btnActivate" runat="server" 
                    Style="position: relative; top: 0px; left: 0px;" Text="Activate"
                    OnClick="btnActivate_Click" TabIndex="13" CssClass="btn" />
                </td>
        </tr>        
        <tr>
            <td colspan="1" style="text-align: center">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtPinSrNo"
                                ErrorMessage="Please enter pin serial number!" 
                    ForeColor="#C00000" ValidationGroup="ps" Display="None"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" 
                    runat="server" ControlToValidate="txtPinSrNo"
                                ErrorMessage="Only numeric value is allowed!" 
                    ForeColor="#C00000" ValidationGroup="ps"
                                ValidationExpression="^[0-9]*" Display="None"></asp:RegularExpressionValidator>&nbsp;
                <br />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                    ShowMessageBox="True" ShowSummary="False" ValidationGroup="ps" />
                <br />
            </td>
        </tr>
    </table>
<div id="divPins" style="display: none;" runat="server">
                        </div>
   

</asp:Content>
