<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="CurrentPinList.aspx.cs" Inherits="yesadmin_CurrentPinList"  EnableEventValidation="false" %>
<%@ Register Assembly="GridViewPaging.Controls" Namespace="GridViewPaging.Controls" 
    TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server" > 
    <link href="css/PagingGridView.css" rel="stylesheet" type="text/css" />

    <link rel="Stylesheet" type="text/css" href="../datepick/jquery.datepick.css"></link>

    <script src="../datepick/jquery-1.4.2.min.js" type="text/javascript"></script>

    <script type="text/javascript" src="../datepick/jquery.datepick.js"></script>

    <%--end date picker link--%>

    <script type="text/javascript">
        $(function () {
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });   
    </script>
 <div id="title" class="b2">
        <h2>
           Pin Details</h2>
        <!-- TitleActions -->
        <!-- /TitleActions -->
    </div>
    
    <table style="width: 100%">
        <tr>
            <td  class="top_table" style="width:100px">
                Pin No 
            </td>
            <td class="top_table" style="width: 136px">
                <asp:TextBox ID="txtpinno" ToolTip="PLEASE ENTER SEARCH WORDS" runat="server" 
                    ValidationGroup="p"></asp:TextBox>
                <br />
                
            </td>

            <td>
            <asp:Button ID="Button2" runat="server" Text="search" onclick="Button2_Click" />

            </td>

            <td  class="top_table" style="width:100px">
               Search Member
            </td>
            <td class="top_table" style="width: 136px">
                <asp:TextBox ID="txtsearch" ToolTip="PLEASE ENTER SEARCH WORDS" runat="server" 
                    ValidationGroup="p" ></asp:TextBox>
                <br />
                
            </td>

            <td>
              <asp:Button ID="Button3" runat="server" Text="search" onclick="Button3_Click" />
            </td>

            </tr>

           <tr> 

            <td colspan="3">
                <b>Date&nbsp; </b>From:
                <asp:TextBox ID="txtFromDate" runat="server" ToolTip="dd/mm/yyyy" Width="80px" 
                   ></asp:TextBox>
                To:
                <asp:TextBox ID="txtToDate" runat="server" ToolTip="dd/mm/yyyy" Width="80px" 
                   ></asp:TextBox>
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Search" 
                    CssClass="btn" />
                &nbsp;Page Size <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
                            <asp:ListItem Value="25">25</asp:ListItem>
                            <asp:ListItem Value="50">50</asp:ListItem>
                            <asp:ListItem Value="100">100</asp:ListItem>
                            <asp:ListItem>All</asp:ListItem>
                        </asp:DropDownList>

                             </td>

                        <td colspan="3" style=" padding:10px 10px 10px 10px">
                                       <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                            OnClick="ibtnExcelExport_Click" />
                             &nbsp;<asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="images/word.jpg"
                                OnClick="ibtnWordExport_Click" style="width: 24px" />
                        &nbsp;<asp:ImageButton ID="ibtnPDFExport" runat="server" 
                                 ImageUrl="images/pdf.gif" onclick="ibtnPDFExport_Click" />

                                 </td>
       


        </tr>
        
        <tr>
            <td  class="top_table" colspan="6" style="text-align: center">
                <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="#CC3300"></asp:Label>
            </td>
        </tr>
        <tr>


         <td colspan="6">
     <cc1:PagingGridView AllowPaging="true" EmptyDataText="No Pins Alloted !"  CssClass="mygrd" 
        AutoGenerateColumns="false"   PageSize="50"  ID="gv" runat="server" 
        CellPadding="4" Width="100%"
              
               BorderStyle="Solid" BorderWidth="1px" Font-Size="8pt"
               BorderColor="#336699" GridLines="Horizontal" 
        onpageindexchanging="gv_PageIndexChanging">
           <Columns> <asp:TemplateField HeaderText="SrNo.">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                     <asp:BoundField HeaderText="Current User ID" DataField="allotedto" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />

                <asp:BoundField HeaderText="User ID" DataField="allottonew" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
     
                                   <asp:BoundField HeaderText="PIN SRNO." DataField="Pinsrno" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"/>


<asp:BoundField HeaderText="Pin No" DataField="Pinno" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"/>
           <asp:BoundField HeaderText="ALLOTMENT_DATE" DataField="allotmentdate" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"/>
           
           
               <asp:BoundField HeaderText="Amount" DataField="amount" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"/>
            
         
         </Columns>
           
           
          </cc1:PagingGridView>

          </td>

          </tr>


          </table>

</asp:Content>

