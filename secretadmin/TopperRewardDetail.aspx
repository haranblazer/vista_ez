<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="TopperRewardDetail.aspx.cs" Inherits="admin_TopperRewardDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <div class="form-group" style=" float:left;  margin:20px 20px 0px 20px"  >

    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td style="height: 35px; text-align: Left">
              <asp:GridView AllowPaging="true" ID="GridView1" runat="server"   DataKeyNames="appmstregno"
                    CssClass="mygrd" AutoGenerateColumns="false"
          
            
                    PageSize="50" Width="100%" 
                    OnPageIndexChanging="GridView1_PageIndexChanging" 
                    >
                  
                                   <Columns>
                        <asp:TemplateField HeaderText="SrNo.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField HeaderText="Name" DataField="appmstfname" />
                        <asp:BoundField HeaderText="User ID" DataField="appmstregno" />
                        <asp:BoundField HeaderText="Mobile" DataField="appmstmobile" />
               

               </Columns>

               </asp:GridView>
           

            </td>

            </tr>

            </table>

 </div>

</asp:Content>

