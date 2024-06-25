<%@ Page Language="C#" MasterPageFile="MasterPage.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="ADDProduct.aspx.cs" Inherits="winneradmin_ADDProduct" Title="Add Product" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <link href="../css/CSS.css" rel="stylesheet" type="text/css" />
  
    <div id="title" class="b2">
        <h2>Add Product</h2>
        <!-- TitleActions -->
        <!-- /TitleActions -->
    </div>




    <asp:Panel ID="Panel1" runat="server">
        <center>  
            
            <div style="padding:0px 5px 5px 5px">
                
              <table border="0" cellpadding="0" cellspacing="0" style="width: 800px; background-color: #f3f3f3; border:2px solid #f3f3f3">

                  <tr>

                      <td style="width: 50px; height: 35px">

                      </td>
                      <td style="width: 50px; height: 35px"></td>
                      <td style="width: 50px; height: 35px"></td>
                      <td style="width: 50px; height: 35px"></td>

                  </tr>
            <tr>
                <td style="width: 50px; height: 35px"></td>
                <td>
                    <span style="font-size: 10pt; font-family: Arial">Product Name:</span></td>
                <td>
                    <asp:TextBox ID="txtProduct" runat="server"></asp:TextBox>
                <td style="width: 50px; height: 35px"></td>
            </tr>
            <tr >
                <td style="width: 50px; height: 35px"></td>
                <td>
                    <span style="font-size: 10pt; font-family: Arial">Price:</span></td>
                <td>
                    <asp:TextBox ID="txtPrice" runat="server"></asp:TextBox>
                </td>
                <td style="width: 50px; height: 35px"></td>
            </tr>
            <tr >
                <td style="width: 50px; height: 35px"></td>
                <td>
                    <span style="font-size: 10pt; font-family: Arial; text-align: left;">PV:</span></td>
                <td>
                    <asp:TextBox ID="txtPV" runat="server"></asp:TextBox>
                </td>
                <td style="width: 50px; height: 35px"></td>
            </tr>
             <tr>
                <td style="width: 50px; height: 35px"></td>
                <td>
                    <span style="font-size: 10pt; font-family: Arial; text-align: left;">Reward Point:</span></td>
                <td>
                    <asp:TextBox ID="txtRewardPoint" runat="server"></asp:TextBox>
                </td>
                <td style="width: 50px; height: 35px"></td>
            </tr>
             <tr>
                <td style="width: 50px; height: 35px"></td>
                <td>
                    <span style="font-size: 10pt; font-family: Arial; text-align: left;">Tour Point:</span></td>
                <td>
                    <asp:TextBox ID="txttourPoint" runat="server"></asp:TextBox>
                </td>
                <td style="width: 50px; height: 35px"></td>
            </tr>
             <tr>
                <td style="width: 50px; height: 35px"></td>
                <td>
                    <span style="font-size: 10pt; font-family: Arial; text-align: left;">Tax:</span></td>
                <td>
                    <asp:TextBox ID="txtTax" runat="server"></asp:TextBox>
                </td>
                <td style="width: 50px; height: 35px"></td>
            </tr>

             <tr>
                <td style="width: 50px; height: 35px"></td>
                <td>
                    <span style="font-size: 10pt; font-family: Arial; text-align: left;">Direct Income:</span></td>
                <td>
                    <asp:TextBox ID="txtdirectincome" runat="server"></asp:TextBox>
                </td>
                <td style="width: 50px; height: 35px"></td>
            </tr>

             <tr>
                <td style="width: 50px; height: 35px"></td>
                <td>
                    Image<span style="font-size: 10pt; font-family: Arial; text-align: left;">:</span></td>
                <td>
                    <asp:Image ID="Image1" runat="server"  Width="50px" Height="50px" />    
                </td>
                <td style="width: 50px; height: 35px"></td>
            </tr>


            <tr>
                <td style="width: 50px; height: 25px"></td>
                <td  style="height: 25px; text-align: center"> </td>
                <td style="width: 50px; height: 25px">
                  <asp:FileUpload ID="FileUpload1" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="width: 50px; height: 35px"></td>
                  <td style="width: 50px; height: 35px"></td>
               
                <td  style="height: 35px; width:80px">
                    <table>
                     <tr>
                     <td  style="height: 35px; width:20px"></td>
                     <td  style="height: 35px; width:20px"><asp:Button ID="btnInsert" runat="server" OnClick="btnInsert_Click" Text="Submit" 
                        ValidationGroup="ap" /></td>
                     <td style="height: 35px; width:20px"> </td>
                     <td style="height: 35px; width:20px"></td>
                     </tr>
                    </table>
                   </td>
                <td style="width: 20px; height: 35px"></td>
            </tr>
            <tr>
                <td style="width: 50px; height: 35px">&nbsp;</td>
                <td colspan="2" style="height: 35px; text-align: center; border-right-width: 1px; border-right-color: #000000">

                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtProduct"
                        ErrorMessage="Please enter product name!" Display="None"
                        ValidationGroup="ap"></asp:RequiredFieldValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPrice"
                        ErrorMessage="Please enter price!" Display="None" ValidationGroup="ap"></asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtPrice"
                        ErrorMessage="Invalid input!" MaximumValue="100000" MinimumValue="1"
                        Type="Double" Display="None" ValidationGroup="ap"></asp:RangeValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                        ControlToValidate="txtPV" Display="None"
                        ErrorMessage="Please enter PV!" ValidationGroup="ap"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="txtPV"
                        Display="None" ErrorMessage="Please enter numeric PV !"
                        ForeColor="#C00000"
                        ValidationExpression="^[0-9]*" ValidationGroup="ap"
                        Width="348px"></asp:RegularExpressionValidator>
                    
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtRewardPoint" Display="None"
                        ErrorMessage="Please enter Reward point" ValidationGroup="ap"></asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="txtRewardPoint"
                        ErrorMessage="Invalid input!" MaximumValue="100000" MinimumValue="0"
                        Type="Double" Display="None" ValidationGroup="ap"></asp:RangeValidator>

                     <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txttourPoint" Display="None"
                        ErrorMessage="Please enter Tour point" ValidationGroup="ap"></asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="RangeValidator3" runat="server" ControlToValidate="txttourPoint"
                        ErrorMessage="Invalid input!" MaximumValue="100000" MinimumValue="0"
                        Type="Double" Display="None" ValidationGroup="ap"></asp:RangeValidator>

                     <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtTax" Display="None"
                        ErrorMessage="Please enter Tax" ValidationGroup="ap"></asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="RangeValidator4" runat="server" ControlToValidate="txtTax"
                        ErrorMessage="Invalid input!" MaximumValue="100000" MinimumValue="1"
                        Type="Double" Display="None" ValidationGroup="ap"></asp:RangeValidator>


                         <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtdirectincome" Display="None"
                        ErrorMessage="Please enter Tax" ValidationGroup="ap"></asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="RangeValidator5" runat="server" ControlToValidate="txtdirectincome"
                        ErrorMessage="Invalid input!" MaximumValue="100000" MinimumValue="0"
                        Type="Double" Display="None" ValidationGroup="ap"></asp:RangeValidator>

                    <br />
                    <asp:ValidationSummary ID="ValidationSummary4" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="ap" Width="222px" />



                </td>
                <td style="width: 50px; height: 35px">&nbsp;</td>
            </tr>
        </table>
                </div>
            </center>
        <table class="style1">
            <tr>
                <td class="style28">&nbsp;</td>
                <td class="style3"
                    style="color: black; font-size: x-large; font-weight: normal; font-style: normal; border-left-style: none; border-left-width: thin; border-left-color: #000000; text-decoration: underline;">Product List-<br />
                </td>
            </tr>
        </table>

        <table class="style1">
            <tr>
                <td class="style21"align="left">&nbsp;&nbsp;
                </td>
                <td  align="left">By Product Name
                </td>
                <td align="left">
                    <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Enter Text " ControlToValidate="txtSearch" ValidationGroup="aaa" SetFocusOnError="false" Display="None"></asp:RequiredFieldValidator>
               
                     </td>
                <td class="style51" width="100px">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" Width="64px" ValidationGroup="aaa"
                        OnClick="btnSearch_Click" Style="margin-left: 0px" />
                </td>
                <td class="style49">&nbsp;</td>
                <td class="style39">
                    <asp:DropDownList ID="ddSearch" runat="server" >                        
                        <asp:ListItem Value="0">Active</asp:ListItem>
                        <asp:ListItem Value="1">InActive</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="style52">
                    <asp:Button ID="btnShow" runat="server" Text="Show All" Width="67px"
                        OnClick="btnShow_Click" />
                </td>
                <td class="style33">Page Size:<asp:DropDownList ID="ddPageSize" runat="server"
                    OnSelectedIndexChanged="ddPageSize_SelectedIndexChanged"
                    Style="margin-left: 0px" Width="44px" AutoPostBack="True">
                    <asp:ListItem>25</asp:ListItem>
                    <asp:ListItem>50</asp:ListItem>
                    <asp:ListItem>100</asp:ListItem>
                    <asp:ListItem>All</asp:ListItem>
                </asp:DropDownList>
                </td>
                <td class="style33">
                    <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="images/word.jpg"
                        OnClick="imgbtnWord_Click" Style="margin-left: 0px" Width="23px" />
                </td>
                <td class="style34">
                    <asp:ImageButton ID="imgbtnExcel" runat="server"
                        ImageUrl="Images/excel.gif" OnClick="imgbtnExcel_Click" />
                </td>
                <td class="style35">
                    <asp:ImageButton ID="imgbtnPdf" runat="server" ImageUrl="images/pdf.gif"
                        OnClick="imgbtnPdf_Click" />
                </td>
            </tr>
        </table>
        <table class="style1">
            <tr>
                <td class="style43">&nbsp;</td>
                    <asp:ValidationSummary ID="ValidationSummary1"  runat="server" ValidationGroup="aaa" />
                <td class="style42">&nbsp;</td>
                <td class="style13">&nbsp;</td>
                <td class="style17">&nbsp;</td>
                <td class="style19">&nbsp;</td>
                <td class="style22">&nbsp;</td>
                <td class="style21">&nbsp;</td>
                <td class="style25">&nbsp;</td>
                <td class="style23">&nbsp;</td>
                <td class="style24">&nbsp;</td>
                <td>&nbsp;</td>
                <td class="style12">&nbsp;</td>
            </tr>
            <tr>
                <td class="style43">&nbsp;</td>
                <td class="style42">
                   

                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="SrNo,imagename"
                        EmptyDataText="record not found." OnRowDataBound="GridView1_RowDataBound"
                        OnRowCommand="GridView1_RowCommand" AllowPaging="True"
                        OnPageIndexChanging="GridView1_PageIndexChanging"
                        PageSize="5" Width="858px" CssClass="mygrd" 
                        onrowupdating="GridView1_RowUpdating">
                        <Columns>

                            
                            <asp:BoundField HeaderText="S.No" DataField="SrNo"></asp:BoundField>
                            <asp:BoundField HeaderText="Name" DataField="productName"></asp:BoundField>
                            <asp:BoundField HeaderText="Price" DataField="amount"></asp:BoundField>
                            <asp:BoundField HeaderText="PV" DataField="joinfor"></asp:BoundField>
                            <asp:BoundField HeaderText="Reward Point" DataField="Rewardpoint"></asp:BoundField>
                            <asp:BoundField HeaderText="Tour Point" DataField="tourpoint"></asp:BoundField>
                            <asp:BoundField HeaderText="Tax" DataField="tax"></asp:BoundField>
                            <asp:BoundField HeaderText="DOE" DataField="DOE"></asp:BoundField>

                             <asp:BoundField HeaderText="Direct Income" DataField="DirectIncome"></asp:BoundField>

                             <asp:TemplateField HeaderText="Image">
                                <ItemTemplate>
            <asp:ImageButton ID="imgStatus1" runat="server" Width="120px" Height="75px"  ImageUrl='<%# Eval("imagename","~/ProductImage/{0}") %>' /> 
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <ItemTemplate>
            <asp:ImageButton ID="imgStatus" runat="server"  /> 
                                </ItemTemplate>
                            </asp:TemplateField>

                              <asp:TemplateField >
                                <ItemTemplate>

                                 <asp:LinkButton ID="LinkButton1" runat="server" CommandName="EditProduct" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"  CausesValidation="false">Edit</asp:LinkButton>
                                
                                       
                                </ItemTemplate>
                            </asp:TemplateField>


                            


                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkbtnStatus" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"  runat="server" OnClientClick="return confirm('Are you sure?')" />
                                </ItemTemplate>
                            </asp:TemplateField>



                             <asp:TemplateField >
                                <ItemTemplate>

                                 <asp:LinkButton ID="LinkButton2" runat="server" CommandName="AddItem" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"  CausesValidation="false">AddItem</asp:LinkButton>
                                
                                       
                                </ItemTemplate>
                            </asp:TemplateField>



                            <%--<asp:TemplateField>

<ItemTemplate>
<asp:LinkButton ID="lnkbtnEdit" Text="Edit" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="EditProduct" runat="server" />

</ItemTemplate>   
</asp:TemplateField>--%>
                        </Columns>


                    </asp:GridView>
                   

                </td>
                <td class="style13">&nbsp;</td>
                <td class="style17" colspan="9">&nbsp;</td>
            </tr>
            <tr>
                <td class="style43">&nbsp;</td>
                <td class="style42">&nbsp;</td>
                <td class="style16">&nbsp;</td>
                <td class="style18">&nbsp;</td>
                <td class="style20">&nbsp;</td>
            </tr>
            <tr>
                <td class="style43">&nbsp;</td>
                <td class="style42">&nbsp;</td>
                <td class="style16">&nbsp;</td>
                <td class="style18">&nbsp;</td>
                <td class="style20">&nbsp;</td>
            </tr>
            <tr>
                <td class="style43">&nbsp;</td>
                <td class="style42">&nbsp;</td>
                <td class="style16">&nbsp;</td>
                <td class="style18">&nbsp;</td>
                <td class="style20">&nbsp;</td>
            </tr>
            <tr>
                <td class="style43">&nbsp;</td>
                <td class="style42">&nbsp;</td>
                <td class="style16">&nbsp;</td>
                <td class="style18">&nbsp;</td>
                <td class="style20">&nbsp;</td>
            </tr>
        </table>
    </asp:Panel>

    
      



</asp:Content>

