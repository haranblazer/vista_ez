<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="NewsList.aspx.cs" Inherits="admin_NewsList" %>

<%@ Register Assembly="GridViewPaging.Controls" Namespace="GridViewPaging.Controls"
    TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function CheckBoxValidation() {
            var valid = false;
            //Varibale to hold the checked checkbox count
            var chkselectcount = 0;
            //Get the gridview object
            var gridview = document.getElementById('<%= GridView1.ClientID %>');
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
            else {
                return confirm('Are you sure you want to delete this?');
            }

        }

        
    </script>
    <script language="javascript" type="text/javascript">
<!--
        function check_uncheck(Val) {
            var ValChecked = Val.checked;
            var ValId = Val.id;
            var frm = document.forms[0];
            // Loop through all elements
            for (i = 0; i < frm.length; i++) {
                // Look for Header Template's Checkbox
                //As we have not other control other than checkbox we just check following statement
                if (this != null) {
                    if (ValId.indexOf('CheckAll') != -1) {
                        // Check if main checkbox is checked,
                        // then select or deselect datagrid checkboxes
                        if (ValChecked)
                            frm.elements[i].checked = true;
                        else
                            frm.elements[i].checked = false;
                    }
                    else if (ValId.indexOf('deleteRec') != -1) {
                        // Check if any of the checkboxes are not checked, and then uncheck top select all checkbox
                        if (frm.elements[i].checked == false)
                            frm.elements[1].checked = false;
                    }
                } // if
            } // for
        } // function

        function confirmMsg(frm) {
            // loop through all elements
            for (i = 0; i < frm.length; i++) {
                // Look for our checkboxes only
                if (frm.elements[i].name.indexOf("deleteRec") != -1) {
                    // If any are checked then confirm alert, otherwise nothing happens
                    if (frm.elements[i].checked)
                        return confirm('Are you sure you want to delete your selection(s)?')
                }
            }
        }
-->
    </script>
  
     <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Modify News</h4>					
				</div>

       
   
    <div class="row">
        <div class="col-sm-2 control-label">
            Select News Type
        </div>
        <div class="col-sm-3 ">
            <asp:DropDownList ID="ddlNewsType" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="OnSelectedIndexChanged">
               <asp:ListItem Value="N">Associate NEWS</asp:ListItem>
                    <asp:ListItem Value="FN">Franchise NEWS</asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>
    <div class="clearfix">
    </div>
   
    <hr />
   
    <div class="table-responsive" runat="server" id="grdHideShow">
        <cc1:PagingGridView ID="GridView1" OnPageIndexChanging="GridView1_PageIndexChanging"
            runat="server" DataKeyNames="NewsMstId" AutoGenerateColumns="False" AllowPaging="True"
            Style="position: static" CssClass="table table-striped table-hover">
            <Columns>
                <asp:TemplateField HeaderText="SR.NO">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                    <ItemStyle Font-Bold="True" Height="20px" />
                </asp:TemplateField>
                <asp:BoundField DataField="NewsMstId" HeaderText="ID" InsertVisible="False" Visible="false"></asp:BoundField>
                <asp:BoundField DataField="newsmstvalidupto" HeaderText="VALID DATE" Visible="false"></asp:BoundField>
                <asp:BoundField DataField="NewsMstTitle" HeaderText="TITLE"></asp:BoundField>
                <asp:TemplateField HeaderText="NEWS">
                    <ItemTemplate>
                        <%#Eval("NewsMstDiscription") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <%--  <asp:BoundField DataField="NewsMstDiscription" HeaderText="NEWS"></asp:BoundField>--%>
                <asp:HyperLinkField HeaderText="MODIFY" Text="Edit" DataNavigateUrlFields="NewsMstId"
                    NavigateUrl="modifynews.aspx" DataNavigateUrlFormatString="modifynews.aspx?n={0}">
                </asp:HyperLinkField>
                <asp:TemplateField HeaderText="Check">
                    <ItemTemplate>
                        <asp:Label ID="EmpID" Visible="false" Text='<%# DataBinder.Eval (Container.DataItem, "NewsMstId") %>'
                            runat="server" />
                        <asp:CheckBox ID="deleteRec" OnClick="return check_uncheck(this);" CssClass="radios"
                            runat="server" />
                    </ItemTemplate>
                    <HeaderTemplate>
                        <asp:CheckBox ID="CheckAll" runat="server" CssClass="radios" OnClick="return check_uncheck(this);" />
                    </HeaderTemplate>
                </asp:TemplateField>
            </Columns>
        </cc1:PagingGridView>
        
        </div>
        <div class="form-group">
            <div class="col-md-12">
                <asp:Button ID="Button1" runat="server" OnClientClick="return CheckBoxValidation();"
                    Text="DELETE" OnClick="Button1_Click" CssClass="btn btn-primary"  />
            </div>
        </div>
       

    <script type="text/javascript">
        $(document).ready(

     function () {

         $('.8').show();
     }
    );
    </script>
</asp:Content>
