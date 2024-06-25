<%@ Page Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="cheqprintaspxnew.aspx.cs" Inherits="admin_cheqprintaspx" %>
<%@ Register Assembly="GridViewPaging.Controls" Namespace="GridViewPaging.Controls"
    TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 
   
      <script type="text/javascript">
          $(function() {
          $('#<%=txtDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
          $('.ChequeDate').datepick({ dateFormat: 'dd/mm/yyyy' });
         
          });   
    </script>
    <div id="title" class="b2">
        <h2>
            Print Cheque</h2>
        <!-- TitleActions -->
        <!-- /TitleActions -->
    </div>

    <script language="javascript" type="text/javascript">
// <!CDATA[

function TABLE1_onclick() {

}

// ]]>
    </script>

    <center>
        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%" id="TABLE1"
            onclick="return TABLE1_onclick()">
            <tr runat="server" >
                <td style="vertical-align: middle; width: 800px; background-color: #f5f5f5; text-align: center">
                    <table style="width: 952px">
                        <tr>
                            <td class="top_table" style="text-align: left">
                    <asp:RadioButton ID="rbtnSBI" runat="server" Font-Bold="True" Font-Names="Arial"
                        Font-Size="Small" GroupName="r" Width="66px" Checked="True" Text="SBI" />&nbsp;<asp:RadioButton 
                                    ID="rbtnAxis" runat="server" Font-Bold="True" Font-Names="Arial"
                                    Font-Size="Small" GroupName="r" Text="Axis " />&nbsp;<asp:RadioButton 
                                    ID="rbtnICICI" runat="server" Font-Bold="True" Font-Names="Arial"
                                    Font-Size="Small" GroupName="r" Text="ICICI " />&nbsp;<asp:RadioButton 
                                    ID="rbtnING" runat="server" Font-Bold="True" Font-Names="Arial"
                                    Font-Size="Small" GroupName="r" Text="ING Vysya" />&nbsp;<asp:RadioButton 
                                    ID="rbtnYes" runat="server" Font-Bold="True" Font-Names="Arial"
                                    Font-Size="Small" GroupName="r" Text="Yes " />&nbsp;<asp:RadioButton 
                                    ID="rbtnPNB" runat="server" Font-Bold="True" Font-Names="Arial"
                                    Font-Size="Small" GroupName="r" Text="PNB " />&nbsp;<asp:RadioButton 
                                    ID="rbtnBOB" runat="server" Font-Bold="True" Font-Names="Arial"
                                    Font-Size="Small" GroupName="r" Height="18px" Text="Bank Of Baroda" />&nbsp;<asp:RadioButton 
                                    ID="rbtnHDFC" runat="server" Font-Bold="True" Font-Names="Arial"
                                    Font-Size="Small" GroupName="r" Text="HDFC" />&nbsp;<asp:RadioButton 
                                    ID="rbtnBOI" runat="server" Font-Bold="True" Font-Names="Arial"
                                    Font-Size="Small" GroupName="r" Text="Bank Of India" /></td>  
                        </tr>
                    </table>
                </td>
            </tr>
          
            <tr>
                <td style="text-align: left" class="bottom_table"><table><tr><td>

                        <asp:DropDownList ID="ddlDate" runat="server" Width="267px"
                        AutoPostBack="True" OnSelectedIndexChanged="ddlDate_SelectedIndexChanged">
                        <asp:ListItem Selected="True">Select Closing</asp:ListItem>
                    </asp:DropDownList>
                        Cheque No:<asp:TextBox ID="TxtPaymentTrandraftid" runat="server" 
                        Width="85px"></asp:TextBox>No of cheques:<asp:TextBox ID="TxtNoChq" runat="server" Width="73px"></asp:TextBox>
                                &nbsp;

                        &nbsp;<asp:Button ID="Button1" runat="server" OnClick="Button1_Click" 
                            Text="Print Cheque" ValidationGroup="vlg" Width="85px" />

                   
                        <span style="font-family: Arial">Change Date<asp:TextBox ID="txtDate" 
                            runat="server" Width="94px"></asp:TextBox>
                        </span></td><td>
                  
                            &nbsp;<span style="font-family: Arial"><asp:Button ID="btnDate" runat="server" OnClick="btnDate_Click" Text="Change" 
                                ValidationGroup="cd" Width="52px" />
                            </span></asp:Panel>
                </td></tr></table>
                  
                </td>
            </tr>
            <tr>
                <td style="text-align: left" class="top_table">
                                <asp:Label ID="lblTotalAmount" runat="server" Font-Bold="true"></asp:Label>
                </td>
            </tr>
            
            
            <tr>
                <td>
                   <cc1:PagingGridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                        AllowPaging="true" EmptyDataText="record not found."
                        CellPadding="1" Height="106px" Width="100%" ForeColor="#333333" GridLines="None"
                        PageSize="50" OnPageIndexChanging="GridView1_PageIndexChanging" Font-Names="Arial"
                        Font-Size="10pt" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating"
                        OnRowCancelingEdit="GridView1_RowCancelingEdit" OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
                        Font-Bold="False" CssClass="mygrd">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr.No">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                                <ItemStyle Font-Bold="True" Height="20px" />
                            </asp:TemplateField>
                            
                            <asp:BoundField HeaderText="User ID" DataField="appmstregno" ReadOnly="True">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField HeaderText="Name" DataField="name" ReadOnly="True">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Cheque Number">
                                <ItemTemplate>
                               
                                                <asp:Label ID="lblPid" runat="server" Text='<%#Eval("PaymenttranDraftId")%>' />  
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                          <asp:TemplateField HeaderText="Total Amount">
                            <EditItemTemplate><asp:TextBox ID="txtTotalAmount"   Text='<%# DataBinder.Eval(Container.DataItem,"dispachedamt") %>' runat="server" /></EditItemTemplate>
                                <ItemTemplate>
                                     <asp:Label ID="lblTotalAmount" runat="server" Text='<%#Eval("dispachedamt")%>' />   
                                </ItemTemplate>
                            </asp:TemplateField>
                           
                            
                            <asp:TemplateField>
                            <EditItemTemplate><asp:TextBox ID="txtChequeDate"  CssClass="ChequeDate" Text='<%# DataBinder.Eval(Container.DataItem,"chequedate") %>' runat="server" /></EditItemTemplate>
                                <ItemTemplate>
                                     <asp:Label ID="lblChequeDate" runat="server" Text='<%#Eval("chequedate")%>' />   
                                </ItemTemplate>
                            </asp:TemplateField>
                         
                            <asp:CommandField  ShowEditButton="True" />
                        </Columns>
                   </cc1:PagingGridView>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnprint" runat="server" OnClick="btnprint_Click" Text="Print Cheque"
                        Width="86px" Height="29px" CssClass="mybtn" /></td>
            </tr>
        </table>
    </center>
    
    
   <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" Display="None"
                            ControlToValidate="ddlDate" ErrorMessage="Please select closing !"
                            Font-Names="Arial" Font-Size="10pt" 
        ForeColor="#C00000" ValidationGroup="vlg" InitialValue="Select Closing"></asp:RequiredFieldValidator>
    
    
   <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="None"
                            ControlToValidate="TxtPaymentTrandraftid" ErrorMessage="Please enter cheque no!"
                            Font-Names="Arial" Font-Size="10pt" ForeColor="#C00000" ValidationGroup="vlg"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                ID="RegularExpressionValidator1" runat="server" ControlToValidate="TxtPaymentTrandraftid"
                                ErrorMessage="Invalid input!" Font-Names="Arial" Font-Size="10pt" ForeColor="#C00000"
                                ValidationGroup="vlg" ValidationExpression="^[0-9]*" Display="None"></asp:RegularExpressionValidator><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtNoChq"
                                    ErrorMessage="Please enter number of  cheques!" Font-Names="Arial" Font-Size="10pt"
                                    ForeColor="#C00000" ValidationGroup="vlg" Display="None"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                        ID="RegularExpressionValidator2" runat="server" ControlToValidate="TxtNoChq"
                                        ErrorMessage="Invalid input!" Font-Names="Arial" Font-Size="10pt" ForeColor="#C00000"
                                        ValidationGroup="vlg" ValidationExpression="^[0-9]*" Display="None"></asp:RegularExpressionValidator><asp:ValidationSummary
                                            ID="ValidationSummary1" runat="server"  ValidationGroup="vlg" ShowMessageBox="true" ShowSummary="false" />
                                            
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please enter date dd/mm/yy format!"
        ControlToValidate="txtDate" Font-Bold="False" ForeColor="#C00000" ValidationGroup="cd"
        Display="None"></asp:RequiredFieldValidator><asp:RegularExpressionValidator ID="RegularExpressionValidator23" runat="server"
                                            ControlToValidate="txtDate" ErrorMessage="Please enter date dd/mm/yy format!"
                                            Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9/]*" 
                                            Display="none"  ValidationGroup="cd"></asp:RegularExpressionValidator><asp:ValidationSummary
                                            ID="ValidationSummary2" runat="server"  ValidationGroup="cd" ShowMessageBox="true" ShowSummary="false" />
</asp:Content>
