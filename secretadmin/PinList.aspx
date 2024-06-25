<%@ Page Language="C#" MasterPageFile="user.master" AutoEventWireup="true"
    CodeFile="PinList.aspx.cs" Inherits="user_PinList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <link rel="stylesheet" href="css/jquery.autocomplete.css" type="text/css" />
    <script type="text/javascript" src="js/jquery.autocomplete.js"></script>

  <script >

      $(document).ready(function () {
          var dataUserID = document.getElementById("<%=divUserID.ClientID%>").innerHTML.split(",");
          $('#<%=txtAllotTo.ClientID %>').autocomplete(dataUserID);
      });

    </script>
    <div id="title" class="b2">
        <h2>
            Pin List</h2>
    </div>
    <table style="width: 100%">
        <tr>
            <td class="top_table" style="text-align: center">
                &nbsp;</td>
            <td class="top_table" style="text-align: center">
                <asp:RadioButton ID="rbtnUsed" runat="server"  AutoPostBack="True"
                    GroupName="r" OnCheckedChanged="rbtnUsed_CheckedChanged" Text="USED" />
                <asp:RadioButton ID="rbtnUnUsed" runat="server" AutoPostBack="True" GroupName="r" Checked="true"
                    OnCheckedChanged="rbtnUnUsed_CheckedChanged" Text="UN USED" />
            &nbsp;<asp:RadioButton ID="rbtnAll" runat="server" AutoPostBack="True" GroupName="r" OnCheckedChanged="rbtnAll_CheckedChanged"
                    Text=" ALL" />
            </td>
            <td class="top_table" style="text-align: left">
                &nbsp;</td>
        </tr>
    </table>
    <table style="width: 100%;">
        <tr>
            <td>
                <table style="width: 100%;">
                    <tr>
                        <td>
                            <asp:Label ID="Label4" runat="server" Font-Bold="True" ForeColor="Gray">No of Records:-</asp:Label>
                        &nbsp;<asp:Label ID="Label2" runat="server" Font-Bold="True" ForeColor="Gray"></asp:Label></td>
                         
                        <td align="right" valign="middle">
                            <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="#C00000"></asp:Label>
                        </td>
                        <td align="right" valign="middle" style="right: auto">
                            <asp:ImageButton ID="imgbtnExport" runat="server" Height="18px" ImageUrl="images/excel.gif"
                                OnClick="imgbtnExport_Click" Width="20px" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr runat="server" id="pt">
            <td>
                <table border="0" cellpadding="0" cellspacing="0" class="uiTable" style="margin-top: 10px; width: 100%;">
                     
                    <tr>
                        <td>
                        <h3> TRANSFER PIN</h3><br />
                            <table width="100%">
                                <tr>
                                    <td class="top_table" style="text-align: right">
                                        ALLOT TO :
                                    </td>
                                    <td class="top_table">
                                        <asp:TextBox ID="txtAllotTo" onchange="CallVal();" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtAllotTo"
                                            Display="Dynamic" ErrorMessage="PLEASE ENTER ID!" ForeColor="#C00000" ValidationGroup="pv"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtAllotTo"
                                            Display="Dynamic" ErrorMessage="INVALID INPUT!" ForeColor="#C00000" ValidationExpression="^[A-Za-z0-9 ]*"
                                            ValidationGroup="pv"></asp:RegularExpressionValidator>
                                        <asp:Label ID="lblUser" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="bottom_table" style="text-align: right">
                                        ENTER SERIAL NUMBER(FROM):
                                    </td>
                                    <td class="bottom_table">
                                        <asp:TextBox ID="txtSerialNoFrom" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtSerialNoFrom"
                                            Display="Dynamic" ErrorMessage="PLEASE ENTER PIN SRNO!" ForeColor="#C00000" ValidationGroup="pv"></asp:RequiredFieldValidator><br />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtSerialNoFrom"
                                            Display="Dynamic" ErrorMessage="ONLY NUMERIC VALUE ALLOWED!" ForeColor="#C00000"
                                            ValidationExpression="^[0-9 ]*" ValidationGroup="pv"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="top_table" style="text-align: right">
                                        ENTER SERIAL NUMBER(TO):
                                    </td>
                                    <td class="top_table">
                                        <asp:TextBox ID="txtSerialNoTo" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtSerialNoTo"
                                            Display="Dynamic" ErrorMessage="PLEASE ENTER PIN SRNO!" ForeColor="#C00000" ValidationGroup="pv"></asp:RequiredFieldValidator><br />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtSerialNoTo"
                                            Display="Dynamic" ErrorMessage="ONLY NUMERIC VALUE ALLOWED!" ForeColor="#C00000"
                                            ValidationExpression="^[0-9 ]*" ValidationGroup="pv"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnSubmit" runat="server" Font-Bold="True" OnClick="btnSubmit_Click1"
                                            Text="SUBMIT" ValidationGroup="pv" CssClass="btn" />
                                        <asp:Label ID="lblerror" runat="server" ForeColor="#C00000" Font-Bold="True"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <br />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <center>
                    <asp:GridView HeaderStyle-CssClass="maingri" ID="GridView1" runat="server" PageSize="50"
                        OnPageIndexChanging="GridView1_PageIndexChanging" AutoGenerateColumns="False"
                        AllowPaging="True" Width="100%" Font-Names="Arial" Font-Size="10pt" CellPadding="4"
                        CellSpacing="1" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle"
                        CssClass="mygrd">
                        <PagerSettings PageButtonCount="25" />
                        <Columns>
                            <asp:BoundField DataField="Pinsrno" HeaderText="PIN SR. NO"></asp:BoundField>
                            <%--<asp:BoundField DataField="Pinno" HeaderText="PIN NO"></asp:BoundField> --%>
                            <asp:TemplateField> 
                                <ItemTemplate>
                                    <%#Eval("Pinno")%> (<%#Eval("paidStatus")%>)

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="UsedById" HeaderText="USED FOR"></asp:BoundField>
                            <asp:BoundField DataField="pname" HeaderText="Product"></asp:BoundField>
                            <asp:BoundField DataField="Amount" HeaderText="AMOUNT"></asp:BoundField>
                            <asp:BoundField DataField="joinfor" HeaderText="Point"></asp:BoundField>
                            <asp:BoundField DataField="allotmentdate" HeaderText="ALLOTMENT DATE"></asp:BoundField>
                            <asp:BoundField DataField="PaidAppMstId" HeaderText="STATUS"></asp:BoundField>
                            <asp:HyperLinkField HeaderText="Join Now" DataNavigateUrlFields="ePinno" DataNavigateUrlFormatString="newjoin.aspx?p1={0}"
                                Text="Join Now" />
                        </Columns>
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" CssClass="maingri">
                        </HeaderStyle>
                    </asp:GridView>
                </center>
            </td>
        </tr>
    </table>
    <div class="clearfix">
            <div id="divUserID" style="display: none;" runat="server">
            </div>
        </div>
</asp:Content>
