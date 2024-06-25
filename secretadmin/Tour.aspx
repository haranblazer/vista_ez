<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master"
    AutoEventWireup="true" CodeFile="Tour.aspx.cs" Inherits="secretadmin_Tour" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


   <script type="text/javascript">
       function CheckRow(objRef) {
           //Get the Row based on checkbox
           var row = objRef.parentNode.parentNode;
           if (objRef.checked) {
               //Change the gridview row color when checkbox checked change
               row.style.backgroundColor = "#5CADFF";
           }
           else {
               //If checkbox not checked change default row color
               if (row.rowIndex % 2 == 0) {
                   //Alternating Row Color
                   row.style.backgroundColor = "#AED6FF";
               }
               else {
                   row.style.backgroundColor = "white";
               }
           }
           //Get the reference of GridView
           var GridView = row.parentNode;
           //Get all input elements in Gridview
           var inputList = GridView.getElementsByTagName("input");
           for (var i = 0; i < inputList.length; i++) {
               //The First element is the Header Checkbox
               var headerCheckBox = inputList[0];
               //Based on all or none checkboxes
               //are checked check/uncheck Header Checkbox
               var checked = true;
               if (inputList[i].type == "checkbox" && inputList[i]
                                               != headerCheckBox) {
                   if (!inputList[i].checked) {
                       checked = false;
                       break;
                   }
               }
           }
           headerCheckBox.checked = checked;
       }
       function checkAllRow(objRef) {
           var GridView = objRef.parentNode.parentNode.parentNode;
           var inputList = GridView.getElementsByTagName("input");
           for (var i = 0; i < inputList.length; i++) {
               //Get the Cell To find out ColumnIndex
               var row = inputList[i].parentNode.parentNode;
               if (inputList[i].type == "checkbox" && objRef
                                                != inputList[i]) {
                   if (objRef.checked) {
                       //If the header checkbox is checked
                       //check all checkboxes
                       //and highlight all rows
                       row.style.backgroundColor = "#5CADFF";
                       inputList[i].checked = true;
                   }
                   else {
                       //If the header checkbox is checked
                       //uncheck all checkboxes
                       //and change rowcolor back to original
                       if (row.rowIndex % 2 == 0) {
                           //Alternating Row Color
                           row.style.backgroundColor = "#AED6FF";
                       }
                       else {
                           row.style.backgroundColor = "white";
                       }
                       inputList[i].checked = false;
                   }
               }
           }
       }
    </script>




    <style type="text/css">
        td, th
        {
            padding: 10px;
            border: 1px solid #333;
        }
    </style>
    <h3>
        <asp:Label ID="lbltext" runat="server" Text="Label"></asp:Label>
    </h3>
      <div class="clearfix"> </div>  <br />
    <div class="col-md-2">  
    <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" CssClass="form-control"
        AutoPostBack="true">
        <%--  <asp:ListItem Selected="True" Value="0">Select</asp:ListItem>--%>
        <asp:ListItem Value="1" Selected="True">Domestic</asp:ListItem>
        <asp:ListItem Value="2">International</asp:ListItem>
    </asp:DropDownList>
    </div>
    
   <div class="clearfix"> </div> 

   <div class="table-responsive">
        <asp:GridView ID="Rpdomestic" runat="server" AutoGenerateColumns="false">
            <Columns>

             <asp:TemplateField>
        <HeaderTemplate>
            <asp:CheckBox ID="chkSelectAll" runat="server"  onclick="checkAllRow(this);" />
        </HeaderTemplate>
        <ItemTemplate>
            <asp:CheckBox ID="chkSelectRow" runat="server"  onclick="CheckRow(this);" />
        </ItemTemplate>
    </asp:TemplateField>

                <asp:TemplateField HeaderText="SNo. ">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>

   <asp:TemplateField HeaderText="Userid"> 
     <ItemTemplate>
         <asp:Label ID="lbluserid" runat="server" Text='<%#Eval("appmstregno")%>'></asp:Label>         
        </ItemTemplate>
    </asp:TemplateField>

         <asp:TemplateField HeaderText="Name"> 
     <ItemTemplate>
         <asp:Label ID="lblname" runat="server" Text='<%#Eval("fname")%>'></asp:Label>         
        </ItemTemplate>
    </asp:TemplateField>


                <asp:TemplateField HeaderText="Mobile"> 
     <ItemTemplate>
         <asp:Label ID="lblmobile" runat="server" Text='<%#Eval("appmstmobile")%>'></asp:Label>         
        </ItemTemplate>
    </asp:TemplateField>




  
               <%-- <asp:BoundField DataField="appmstregno" HeaderText=" User ID" />
                <asp:BoundField DataField="fname" HeaderText=" Name" />
                <asp:BoundField DataField="appmstmobile" HeaderText="Mobile" />--%>
                <asp:BoundField DataField="fromdate" HeaderText="From date" />
                <asp:BoundField DataField="todate" HeaderText="To date" />
                <asp:BoundField DataField="pbv1" HeaderText=" PPV First Month" />
                <asp:BoundField DataField="pbv2" HeaderText=" PPV Second Month" />
                <asp:BoundField DataField="pbv3" HeaderText=" PPV Third Month" />
                <asp:BoundField DataField="pbv4" HeaderText=" PPV Four Month" />
                <asp:BoundField DataField="gbv" HeaderText="GPV" />
                <asp:BoundField DataField="doe" HeaderText="Date" />
                  <asp:BoundField DataField="status" HeaderText="Qualify/Not Qualifiy" />
            </Columns>
        </asp:GridView>
        </div>
<div class="clearfix"> </div> 
        <asp:GridView ID="Rpinternational" runat="server" AutoGenerateColumns="false">
            <Columns>
            </Columns>
        </asp:GridView>

       <div class="clearfix"> </div> <br />
       <div class="col-md-2"> <asp:Button ID="Button1" runat="server" CssClass="btn btn-success" Text="Submit" onclick="Button1_Click" /> </div>
    

        <%--    <asp:Repeater ID="Rpdomestic" runat="server">
            <HeaderTemplate>
                <tr>
                    <td>
                        SNo.
                    </td>
                    <td>
                        User ID
                    </td>
                    <td>
                        Name
                    </td>
                    <td>
                        Mobile
                    </td>
                    <td>
                        From date
                    </td>
                    <td>
                        To date
                    </td>
                    <td>
                        PPV First Month
                    </td>
                    <td>
                        PPV Second Month
                    </td>
                    <td>
                        PPV Third Month
                    </td>
                    <td>
                        PPV Four Month
                    </td>
                    <td>
                        GPV
                    </td>
                    <td>
                        Qualify/Not Qualifiy
                    </td>
                    <td>
                        Doe
                    </td>
                </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <itemtemplate>
     <%#Container.ItemIndex+1 %>
</itemtemplate>
                    </td>
                    <td>
                        <%#Eval("appmstregno").ToString()%>
                    </td>
                    <td>
                        <%#Eval("fname").ToString()%>
                    </td>
                    <td>
                        <%#Eval("appmstmobile").ToString()%>
                    </td>
                    <td>
                        <%#Eval("fromdate").ToString()%>
                    </td>
                    <td>
                        <%#Eval("todate").ToString()%>
                    </td>
                    <td>
                        <%#Eval("pbv1").ToString()%>
                    </td>
                    <td>
                        <%#Eval("pbv2").ToString()%>
                    </td>
                    <td>
                        <%#Eval("pbv3").ToString()%>
                    </td>
                    <td>
                        <%#Eval("pbv4").ToString()%>
                    </td>
                    <td>
                        <%#Eval("gbv").ToString()%>
                    </td>
                    <td>
                        <%#Eval("doe").ToString()%>
                    </td>
                    <td>
                        <%#Eval("status").ToString()%>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
        <asp:Repeater ID="Rpinternational" runat="server">
            <HeaderTemplate>
                <tr>
                    <td>
                        SNo.
                    </td>
                    <td>
                        User ID
                    </td>
                    <td>
                        Name
                    </td>
                    <td>
                        Mobile
                    </td>
                    <td>
                        From date
                    </td>
                    <td>
                        To date
                    </td>
                    <td>
                        PPV First Month
                    </td>
                    <td>
                        PPV Second Month
                    </td>
                    <td>
                        PPV Third Month
                    </td>
                    <td>
                        PPV Four Month
                    </td>
                    <td>
                        PPV Fifth Month
                    </td>
                    <td>
                        PPV Six Month
                    </td>
                    <td>
                        PPV Seven Month
                    </td>
                    <td>
                        PPV Eight Month
                    </td>
                    <td>
                        PPV Ninth Month
                    </td>
                    <td>
                        PPV Tenth Month
                    </td>
                    <td>
                        PPV Eleven Month
                    </td>
                    <td>
                        PPV Tweleve Month
                    </td>
                    <td>
                        GPV
                    </td>
                    <td>
                        Qualify/Not Qualifiy
                    </td>
                    <td>
                        Doe
                    </td>
                </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <itemtemplate>
     <%#Container.ItemIndex+1 %>
</itemtemplate>
                    </td>
                    <td>
                        <%#Eval("appmstregno").ToString()%>
                    </td>
                    <td>
                        <%#Eval("fname").ToString()%>
                    </td>
                    <td>
                        <%#Eval("appmstmobile").ToString()%>
                    </td>
                    <td>
                        <%#Eval("fromdate").ToString()%>
                    </td>
                    <td>
                        <%#Eval("todate").ToString()%>
                    </td>
                    <td>
                        <%#Eval("pbv1").ToString()%>
                    </td>
                    <td>
                        <%#Eval("pbv2").ToString()%>
                    </td>
                    <td>
                        <%#Eval("pbv3").ToString()%>
                    </td>
                    <td>
                        <%#Eval("pbv4").ToString()%>
                    </td>
                    <td>
                        <%#Eval("pbv5").ToString()%>
                    </td>
                    <td>
                        <%#Eval("pbv6").ToString()%>
                    </td>
                    <td>
                        <%#Eval("pbv7").ToString()%>
                    </td>
                    <td>
                        <%#Eval("pbv8").ToString()%>
                    </td>
                    <td>
                        <%#Eval("pbv9").ToString()%>
                    </td>
                    <td>
                        <%#Eval("pbv10").ToString()%>
                    </td>
                    <td>
                        <%#Eval("pbv11").ToString()%>
                    </td>
                    <td>
                        <%#Eval("pbv12").ToString()%>
                    </td>
                    <td>
                        <%#Eval("gbv").ToString()%>
                    </td>
                    <td>
                        <%#Eval("doe").ToString()%>
                    </td>
                    <td>
                        <%#Eval("status").ToString()%>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>--%>
 
</asp:Content>
