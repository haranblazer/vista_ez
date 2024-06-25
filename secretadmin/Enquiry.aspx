<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master"
    AutoEventWireup="true" CodeFile="Enquiry.aspx.cs" Inherits="admin_Enquiry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

 <script type="text/javascript">
     function CheckBoxValidation() {
         var valid = false;
         //Varibale to hold the checked checkbox count
         var chkselectcount = 0;
         //Get the gridview object
         var gridview = document.getElementById('<%= GridView1.ClientID %>');

         var txtreply = document.getElementById('<%= txtRpy.ClientID %>').value;
         //Loop thorugh items
         for (var i = 0; i < gridview.getElementsByTagName("input").length; i++) {
             //Get the object of input type
             var node = gridview.getElementsByTagName("input")[i];
             //check if object is of type checkbox and checked or not
             if (node != null && node.type == "checkbox" && node.checked) {
                 valid = true;
                 //Increase the count of check box
                 chkselectcount = chkselectcount + 1;
             }
         }

         //Checking the count is zero , this means no checkbox is selected
         if (chkselectcount == 0) {
             alert("Please select atleast one checkbox.");
             return false;
         }
         if (txtreply == '') {
             alert("Please enter some text to reply.");
             document.getElementById('<%= txtRpy.ClientID %>').focus();
             return false;
         }
     }

        
    </script>
    <script type="text/javascript">
        var TotalChkBx;
        var Counter;

        window.onload = function () {

            TotalChkBx = parseInt('<%= this.GridView1.Rows.Count %>');


            Counter = 0;
        }

        function HeaderClick(CheckBox) {

            var TargetBaseControl =
       document.getElementById('<%= this.GridView1.ClientID %>');
            var TargetChildControl = "chkSelect";


            var Inputs = TargetBaseControl.getElementsByTagName("input");


            for (var n = 0; n < Inputs.length; ++n)
                if (Inputs[n].type == 'checkbox' &&
                Inputs[n].id.indexOf(TargetChildControl, 0) >= 0)
                    Inputs[n].checked = CheckBox.checked;


            Counter = CheckBox.checked ? TotalChkBx : 0;
        }

        function ChildClick(CheckBox, HCheckBox) {

            var HeaderCheckBox = document.getElementById(HCheckBox);


            if (CheckBox.checked && Counter < TotalChkBx)
                Counter++;
            else if (Counter > 0)
                Counter--;


            if (Counter < TotalChkBx)
                HeaderCheckBox.checked = false;
            else if (Counter == TotalChkBx)
                HeaderCheckBox.checked = true;
        }
    </script>
     <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script> 
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" /> 
    <script> var $JD = $.noConflict(true); </script>
    <script type="text/javascript"> 
        $JD(function () {
            $JD('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $JD('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
       }); 
    </script>
     <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Enquiry</h4>					
				</div>

    <div class="row">
        <div class="col-sm-2">
            
                <asp:TextBox ID="txtFromDate" runat="server"  CssClass="form-control" placeholder="From"
                    ToolTip="dd/mm/yyyy"></asp:TextBox>
         
        
        </div>
        <div class="col-sm-2">
            
                <asp:TextBox ID="txtToDate" runat="server"  CssClass="form-control" placeholder="To"
                    ToolTip="dd/mm/yyyy"></asp:TextBox>
          
          
        </div>

        <div class="col-sm-2">
           
                <asp:TextBox ID="txtName" runat="server"  CssClass="form-control" placeholder="Name"
                    ToolTip="Name"></asp:TextBox>           
         
           
        </div>

         <div class="col-sm-1">
            <button id="Button2" runat="server" class="btn btn-primary" title="Show" onserverclick="Button1_Click">
               Show
            </button>
        </div>
    
        <div class="col-md-3">
            <asp:TextBox ID="txtRpy" runat="server" TextMode="MultiLine" placeholder="Type Your Message Here"
                CssClass="form-control"></asp:TextBox>
          
            
        </div>
        <div class="col-md-1">
            <asp:Button ID="btnRpy" runat="server" Text="Reply All" CssClass="btn btn-primary"
            OnClientClick="return CheckBoxValidation();" OnClick="btnRpy_Click" /></div>
    </div>
     <%--<div class="clearfix">
    </div>
    <br />--%>
    <div class="table table-responsive">
        <asp:GridView ID="GridView1" runat="server" Width="100%" AutoGenerateColumns="false"
            EmptyDataText="No Data Found." CssClass="table table-striped table-hover mygrd"
            OnRowCreated="GridView1_RowCreated" OnPageIndexChanging="GridView1_PageIndexChanging"
            AllowPaging="true" PageSize="20">
            <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:CheckBox ID="chkAll" runat="server" onclick="javascript:HeaderClick(this);" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkSelect" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Sr.No">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:BoundField DataField="PhoneNo" HeaderText="Mobile No" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="Msg" HeaderText="Message" />
                <asp:BoundField DataField="EnquiryId" HeaderText="EnqId" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:TextBox ID="txtReply" runat="server" TextMode="MultiLine" Style="max-width: 320px;
                            min-width: 220px;" placeholder="Type Your Message" Text='<%# Eval("reply") %>'
                            CssClass="form-control textarea"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:Button ID="btnReply" runat="server" Text="Reply" CssClass="btn btn-success"
                            OnClick="btnReply_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
   
    <br />
    </div>
     <div class="clearfix">
    </div>
    </div>
</asp:Content>
