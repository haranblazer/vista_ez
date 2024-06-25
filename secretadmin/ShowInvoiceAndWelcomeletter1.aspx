<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="ShowInvoiceAndWelcomeletter1.aspx.cs" Inherits="yesadmin_ShowInvoiceAndWelcomeletter1" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="title" class="b2" style="padding-top:15px;">
        <h2 class="head">Welcome Letter / Invoice</h2>
        <!-- TitleActions -->
        <!-- /TitleActions -->
    </div>
    <div class="clearfix"> </div> <br />

    <asp:Panel ID="Panel1" runat="server">

      <asp:Panel ID="pnlUtility" runat="server" DefaultButton="btnSubmit">
     <div class="form-group">
            <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
              Select Closing:</label>
            <div class="col-sm-3 col-xs-9">
            <asp:DropDownList ID="ddlDate" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlDate_SelectedIndexChanged" AutoPostBack="True">
                                        <%--  <asp:ListItem Value="0">Select</asp:ListItem>--%>
                                    </asp:DropDownList>
            </div>
            </div>
            <div class="clearfix"></div><br />
            <div class="form-group"> 
                   <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
              Welcome/Invoice:</label>   
            <div class="col-sm-3 col-xs-9">
            
            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                                        <asp:ListItem Value="Select">Select</asp:ListItem>
                                        <asp:ListItem Value="WELCOME">Welcome Letter</asp:ListItem>
                                        <asp:ListItem Value="INVOICE">Invoice</asp:ListItem>
                                    </asp:DropDownList>
            </div>
            </div>
            <div class="clearfix"></div><br />
            <div class="form-group">
            <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
               Report Number (From):</label>
            <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="TxtPaymentTrandraftid" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            </div>
             <div class="clearfix"></div><br />
             <div class="form-group">
            <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
               Report Number (To):</label>
            <div class="col-sm-3 col-xs-9">
            <asp:TextBox ID="TxtNoChq" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            </div>
             <div class="clearfix"></div><br />
             <div class="form-group">            
            <div class="col-sm-2 col-xs-3"> </div>
            <div class="col-sm-2 col-xs-3">
             <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-success"
                                        ValidationGroup="ap" OnClick="btnSubmit_Click" />
             
             </div>
             </div>
</asp:Panel>

<div class="clearfix"> </div> <br />

        <table id="TABLE1" style="width: 100%;">

            <tr>

                <td colspan="3">
                  
                        <table>
                            <tr>

                                <td colspan="6">
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                        ControlToValidate="TxtPaymentTrandraftid" Display="None"
                        ErrorMessage="Please enter report from" ValidationGroup="ap"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TxtPaymentTrandraftid"
                        Display="None" ErrorMessage="Please enter numeric !"
                        ForeColor="#C00000"
                        ValidationExpression="^[0-9]*" ValidationGroup="ap"
                        Width="348px"></asp:RegularExpressionValidator>

                                      <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                        ControlToValidate="TxtNoChq" Display="None"
                        ErrorMessage="Please enter report to" ValidationGroup="ap"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TxtNoChq"
                        Display="None" ErrorMessage="Please enter numeric !"
                        ForeColor="#C00000"
                        ValidationExpression="^[0-9]*" ValidationGroup="ap"
                        Width="348px"></asp:RegularExpressionValidator>


                                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ValidationGroup="ap" />


                                      </td>
                            </tr>
                        </table>
                   
                </td>

            </tr>
            <tr>

                <td colspan="3">
                    <asp:Label ID="lblMsg" runat="server" ForeColor="#CC3300"
                        Font-Names="Arial"></asp:Label></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" AllowPaging="true"
                        PageSize="50" OnPageIndexChanging="GridView1_PageIndexChanging"
                        CssClass="mygrd">
                        <Columns>
                           <%-- <asp:TemplateField HeaderText="Sr.No">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                                <ItemStyle Font-Bold="True" Height="20px" />
                            </asp:TemplateField>--%>
                          

                             <asp:BoundField HeaderText="Report Number" DataField="appmstid"  ItemStyle-Width="100px"/>
                            <asp:BoundField HeaderText="User Id" DataField="appmstregno" ItemStyle-Width="100px">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="Name" DataField="appmstfname">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                           <%-- <asp:BoundField HeaderText="Report Number" DataField="PaymenttranDraftId" />--%>
                        </Columns>
                    </asp:GridView>
                </td>
                <td></td>
            </tr>

        </table>
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlDate"
            Display="None" ErrorMessage="Plaese select closing!" Font-Names="Arial"
            Font-Size="10pt" ForeColor="#C00000"
            Style="position: relative; left: 0px;" ValidationGroup="s"
            InitialValue="Select Closing"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator
            ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtPaymentTrandraftid"
            Display="None" ErrorMessage="Plaese enter report number" Font-Names="Arial"
            Font-Size="10pt" ForeColor="#C00000"
            Style="position: relative; left: 0px;" ValidationGroup="s"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator
            ID="RegularExpressionValidator7" runat="server" ControlToValidate="TxtPaymentTrandraftid"
            Display="None" ErrorMessage="Only numeric value is allowed !"
            Font-Names="Arial" Font-Size="10pt"
            ForeColor="#C00000" ValidationExpression="^[0-9]*" Width="277px"
            ValidationGroup="s"></asp:RegularExpressionValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
            ControlToValidate="TxtNoChq" Display="none" ErrorMessage="Plaese enter number of report!"
            Font-Names="Arial" Font-Size="10pt"
            ForeColor="#C00000" Style="position: static;" ValidationGroup="s"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator
            ID="RegularExpressionValidator1"
            runat="server" ControlToValidate="TxtNoChq"
            Display="None" ErrorMessage="Only numeric value is allowed !"
            Font-Names="Arial" Font-Size="10pt"
            ForeColor="#C00000"
            ValidationExpression="^[0-9]*" Width="237px" ValidationGroup="s"></asp:RegularExpressionValidator>
        <br />
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
            ShowSummary="False" ValidationGroup="s" />


    </asp:Panel>

    <div id="divUserID" style="display: none;" runat="server">
    </div>

<div class="clearfix"> </div> <br />
</asp:Content>

