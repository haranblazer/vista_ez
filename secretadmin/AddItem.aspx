<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="AddItem.aspx.cs" Inherits="Admin_AddItem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
  
     <table  runat="server"  border="0" cellpadding="0" cellspacing="0" Style="width: 800px; background-color: #f3f3f3; border:2px solid #f3f3f3">

                  <tr>

                      <td style="width: 50px; height: 35px">
                          <asp:Label ID="Label1" runat="server"  Style="color:Red"></asp:Label>
                      </td>
                      <td style="width: 50px;height:35px"></td>
                      <td style="width: 50px; height: 35px"></td>
                      <td style="width: 50px; height: 35px"></td>

                  </tr>
            <tr>
                <td style="width: 50px; height: 35px"></td>
                <td>
                    <span style="font-size: 10pt; font-family: Arial">Product Name:</span></td>
                <td>
                    <asp:TextBox ID="txtpname" runat="server"></asp:TextBox>

                    </td>
                <td style="width: 50px; height: 35px"></td>
            </tr>
            <tr >
                <td style="width: 50px; height: 35px"></td>
                <td>
                    <span style="font-size: 10pt; font-family: Arial">Price With Tax:</span></td>
                <td>
                    <asp:TextBox ID="txtpwt" runat="server" AutoPostBack="True" 
                        ontextchanged="txtpwt_TextChanged"></asp:TextBox>
                </td>
                <td style="width: 50px; height: 35px"></td>
            </tr>
            <tr >
                <td style="width: 50px; height: 35px"></td>
                <td>
                    <span style="font-size: 10pt; font-family: Arial; text-align: left;">Tax%</span></td>
                <td>
                    <asp:TextBox ID="txttax" runat="server" 
                        ontextchanged="txttax_TextChanged" AutoPostBack="True"></asp:TextBox>
                </td>
                <td style="width: 50px; height: 35px"></td>
            </tr>

             <tr>
                <td style="width: 50px; height: 25px"></td>
               <td>
                    <span style="font-size: 10pt; font-family: Arial; text-align: left;">Quantity</span>
                </td>

                 <td >
                    <asp:TextBox ID="txtquantity" runat="server" 
                         ontextchanged="txtquantity_TextChanged" AutoPostBack="True"></asp:TextBox>
                </td>
                <td style="width: 50px; height: 35px"></td>
                </tr>


                  <tr>
                <td style="width: 50px; height: 25px"></td>
               <td>
                    <span style="font-size: 10pt; font-family: Arial; text-align: left;"> 
                    Price&nbsp; without Tax</span>
                </td>

                 <td >
                    <asp:TextBox ID="txtperitem" runat="server" Enabled="false" 
                         Height="22px"></asp:TextBox>
                </td>
                <td style="width: 50px; height: 35px"></td>
                </tr>



                  <tr>
                <td style="width: 50px; height: 25px"></td>
               <td>
                    <span style="font-size: 10pt; font-family: Arial; text-align: left;">Total 
                    Price&nbsp; with Tax</span>
                </td>

                 <td >
                    <asp:TextBox ID="txtamountwithquanity" runat="server" Enabled="false" 
                         Height="22px"></asp:TextBox>
                </td>
                <td style="width: 50px; height: 35px"></td>
                </tr>



             <tr>
                <td style="width: 50px; height: 35px"></td>
                <td>
                    <span style="font-size: 10pt; font-family: Arial; text-align: left;">Actual price(Without 
                    Tax)</span></td>
                <td>
                    <asp:TextBox ID="txtprice" runat="server" Enabled="false"></asp:TextBox>
                </td>
                <td style="width: 50px; height: 35px"></td>
            </tr>
            
            <tr>
                <td style="width: 50px; height: 25px"></td>
               <td>
                    <span style="font-size: 10pt; font-family: Arial; text-align: left;">Tax Amount</span>
                </td>
                <td >
                    <asp:TextBox ID="txtamount" runat="server" Enabled="false"></asp:TextBox>
                </td>
                <td style="width: 50px; height: 35px"></td>
            </tr>

             

            <tr>
                <td style="width: 50px; height: 35px"></td>
                  <td style="width: 50px; height: 35px"></td>
               
                <td  style="height: 35px; width:80px">
                    <table>
                     <tr>
                     <td  style="height: 35px; width:20px ; text-align:"></td>
                     <td  style="height: 35px; width:20px">
                     <asp:Button ID="Insert" runat="server" Text="Submit" onclick="Insert_Click"   ValidationGroup="ap"/>
                      </td>
                     <td style="height: 35px; width:20px">
                         
                         </td>
                     <td style="height: 35px; width:20px">
                     <asp:Button ID="Button1" runat="server" Text="Back" onclick="Button1_Click" />
                     </td>
                     </tr>
                    </table>
                   </td>
                <td style="width: 20px; height: 35px">
                   
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtpname"
                        ErrorMessage="Please enter product name!" Display="None"
                        ValidationGroup="ap"></asp:RequiredFieldValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtpwt"
                        ErrorMessage="Please enter price with Tax" Display="None" ValidationGroup="ap"></asp:RequiredFieldValidator>
                  
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                        ControlToValidate="txttax" Display="None"
                        ErrorMessage="Please enter tax" ValidationGroup="ap"></asp:RequiredFieldValidator>

                          <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                        ControlToValidate="txtprice" Display="None"
                        ErrorMessage="Please enter price" ValidationGroup="ap"></asp:RequiredFieldValidator>

                          <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                        ControlToValidate="txtamount" Display="None"
                        ErrorMessage="Please enter tax amount" ValidationGroup="ap"></asp:RequiredFieldValidator>


                          <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                        ControlToValidate="txtquantity" Display="None"
                        ErrorMessage="Please enter quantity" ValidationGroup="ap"></asp:RequiredFieldValidator>


                    <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="txtpwt"
                        Display="None" ErrorMessage="Enter correct Format for Price with tax!"
                        ForeColor="#C00000"
                        ValidationExpression="[0-9]*\.?[0-9]*" ValidationGroup="ap"
                        Width="348px"></asp:RegularExpressionValidator>

                       <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txttax"
                        Display="None" ErrorMessage="Enter Correct For tax!"
                        ForeColor="#C00000"
                        ValidationExpression="[0-9]*\.?[0-9]*" ValidationGroup="ap"
                        Width="348px"></asp:RegularExpressionValidator>
                    

                      <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtquantity"
                        Display="None" ErrorMessage="Enter Correct Quantity!"
                        ForeColor="#C00000"
                        ValidationExpression="[0-9]*" ValidationGroup="ap"
                        Width="348px"></asp:RegularExpressionValidator>
                    
                    
                         

                    <br />
                    <asp:ValidationSummary ID="ValidationSummary4" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="ap" Width="222px" />

                </td>
            </tr>

          

            
        </table>

        <table>
        
        <tr>
        
        <td>
        
         <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="itemid"
                        EmptyDataText="record not found."
                        OnRowCommand="GridView1_RowCommand" AllowPaging="True"
                        OnPageIndexChanging="GridView1_PageIndexChanging"
                        PageSize="15" Width="858px" CssClass="mygrd" 
                      >
                        <Columns>

                         <asp:BoundField HeaderText="S.No" DataField="itemid"></asp:BoundField>
                            
                            
                            <asp:BoundField HeaderText="Product Name" DataField="productName"></asp:BoundField>

                            
                              <asp:BoundField HeaderText="Quantity" DataField="quantity"></asp:BoundField>
                             
                          

                            <asp:BoundField HeaderText="Rate" DataField="peritemcost"></asp:BoundField>

                            
                             <asp:BoundField HeaderText="Amount" DataField="price"></asp:BoundField>
                            
                              <asp:BoundField HeaderText="Tax" DataField="Tax"></asp:BoundField>
                          
                           
                             
                           
                            <asp:BoundField HeaderText="Tax Amount" DataField="Taxamount"></asp:BoundField>
                          
                           
                             <asp:BoundField HeaderText="Actual Rate" DataField="pricewithtax"></asp:BoundField>
                           
                             
                             <asp:BoundField HeaderText="net amount" DataField="totalprice" ></asp:BoundField>

                              <asp:TemplateField >
                                <ItemTemplate>

                                 <asp:LinkButton ID="LinkButton1" runat="server" CommandName="EditProduct" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CausesValidation="false">Edit</asp:LinkButton>
                                
                                       
                                </ItemTemplate>
                            </asp:TemplateField>



                               <asp:TemplateField >
                                <ItemTemplate>

                                 <asp:LinkButton ID="LinkButton2" runat="server" CommandName="DeleteProduct" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CausesValidation="false">Delete</asp:LinkButton>
                                
                                       
                                </ItemTemplate>
                            </asp:TemplateField>


                            


                          



                        </Columns>


                    </asp:GridView>
        </td>
        </tr>
        </table>
        </ContentTemplate>
          </asp:UpdatePanel>

</asp:Content>

