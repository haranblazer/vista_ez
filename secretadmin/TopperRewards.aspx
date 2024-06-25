<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="TopperRewards.aspx.cs" Inherits="admin_TopperRewards" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <style type="text/css">td,th {padding:5px 0px 5px 5px; border-color:#ddd;}</style>


     <div style="padding-top:15px;">
     <h1 class="head">Rewards </h1>
     </div>
     <div class="clearfix"> </div> <br />

 <div class="form-group" style=" float:left;  margin:20px 20px 0px 20px"  >
        <label style=" float:left; line-height:40px; padding:0 20px 0 0" for="MainContent_txtPassword" >Award Name </label>

        <div style="float:left;">
      
            <asp:DropDownList ID="ddlawardtype" runat="server" CssClass="form-control" 
                Width="150px" Height="40px" 
                onselectedindexchanged="ddlawardtype_SelectedIndexChanged" AutoPostBack="true" >

             <asp:ListItem Value="0">Select</asp:ListItem>
             <asp:ListItem Value="1">Travelling Bag</asp:ListItem>
             <asp:ListItem Value="2">Android Phone</asp:ListItem>
              <asp:ListItem Value="3">Lap Top</asp:ListItem>
              <asp:ListItem Value="4">Bike/Scooty</asp:ListItem>
              <asp:ListItem Value="5">Home Appliances</asp:ListItem>
                <asp:ListItem Value="6">Car</asp:ListItem>
              <asp:ListItem Value="7">Flat</asp:ListItem>
              <asp:ListItem Value="8">Luxary car</asp:ListItem>
               <asp:ListItem Value="9">Villa</asp:ListItem>
            </asp:DropDownList>
       
        </div>
    </div>

      <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td style="height: 35px; text-align: Left">
              <asp:GridView AllowPaging="true" ID="GridView1" runat="server"   DataKeyNames="appmstregno"
                    CssClass="mygrd" AutoGenerateColumns="false"
          
            
                    PageSize="50" Width="100%" 
                    OnPageIndexChanging="GridView1_PageIndexChanging" 
                    onrowcommand="GridView1_RowCommand" >
                  
                                   <Columns>
                        <asp:TemplateField HeaderText="SrNo.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField HeaderText="Name" DataField="appmstfname" />
                        <asp:BoundField HeaderText="User ID" DataField="appmstregno" />
                        <asp:BoundField HeaderText="Doe" DataField="Doe" />
                        <asp:BoundField HeaderText="Achieved" DataField="Achieved" />
                       <%-- <asp:BoundField HeaderText="No Of Toppers" DataField="Total_Member" />--%>


                      <asp:TemplateField HeaderText="No Of Toppers">
                            <ItemTemplate>

                                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Total" CommandArgument='<%# Eval("appmstregno") %>' CausesValidation="false"  Text='<%# Bind("topper") %>'></asp:LinkButton>

<%--                                <asp:LinkButton ID="lnkbtnStatement" CommandName="Total"  CommandArgument='<%#((GridViewRow)Container).RowIndex %>' Text='<%# Bind("Total_Member") %>' 
                                    runat="server" />--%>
                            </ItemTemplate>
                        </asp:TemplateField>
                      
                      </Columns>
                      </asp:GridView>

            </td>

            </tr>

            </table>
</asp:Content>

