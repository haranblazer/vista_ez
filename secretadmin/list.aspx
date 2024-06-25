<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    EnableEventValidation="false" Debug="true" CodeFile="list.aspx.cs" Inherits="admin_list"
    ValidateRequest="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
     <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>    
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(function () {
            jQuery.noConflict(true);
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        }); 
    </script>
    <script type="text/javascript">
        function showHide() {
            // var ele = document.getElementById("panlID1");

            //            var control = document.getElementById("panlID1");
            document.getElementById("<%=panlID1.ClientID %>").selectedIndex = 0;
            document.getElementById("<%=panlID1.ClientID %>").style.visibility = "hidden";
            //            control.style.visibility = "hidden";
            //            alert("dfjdskjf");

        }

    </script>
    <script type="text/javascript">
        function trimTextBox(sender) {

            if ((sender.value.length == 0 || sender.selectionStart == 0) && (window.event.keyCode == 32)) {
                return false;
            }
            else if (sender.value.charCodeAt(0) == 32) {
                sender.value = sender.value.substring(1);
            }
            return true;
        }
    </script>
    <script type="text/javascript">

        function CheckAll() {

            for (i = 0; i < document.forms[0].length; i++) {
                if (document.forms[0].elements[i].type == "checkbox") {
                    document.forms[0].elements[i].checked = true;
                }
            }

            document.getElementById('<%=ChkDeSelectAll.ClientID%>').checked = false;
        }
        function UnCheckAll() {

            for (i = 0; i < document.forms[0].length; i++) {
                if (document.forms[0].elements[i].type == "checkbox") {
                    document.forms[0].elements[i].checked = false;
                }
            }

            document.getElementById('<%=ChkSelectAll.ClientID%>').checked = false;
            document.getElementById('<%=ChkDeSelectAll.ClientID%>').checked = true;
        }
    </script>

    
     <h2 class="head">
        <i class="fa fa-list" aria-hidden="true"></i>&nbsp;Unpaid List</h2>
   <div class="panel panel-default">
 <div class="col-md-12">
 <br />
    <div class="clearfix"></div>
   
    <div runat="server" id="d">
        <div class="containers">
           
                <div class="form-group">
                    <div class="col-sm-2">                      
                            <asp:TextBox ID="txtFromDate" runat="server" placeholder="From" ToolTip="dd/mm/yyyy"
                                CssClass="form-control" TabIndex="1">
                            </asp:TextBox>                       
                        <div class="clearfix">
                        </div>
                        
                    </div>
                    <div class="col-sm-2">                      
                            <asp:TextBox ID="txtToDate" placeholder="To" ToolTip="dd/mm/yyyy" runat="server"
                                CssClass="form-control" TabIndex="2">
                            </asp:TextBox>
                      
                        <div class="clearfix">
                        </div>
                       
                    </div>
                    <div class="col-sm-1">
                        <button class="btn btn-success" id="Button1" runat="server" validationgroup="Show"
                            onserverclick="Button1_Click" tabindex="3" ><%--onclick="return Button1_onclick()"--%>
                            <i class="fa fa-eye"></i>&nbsp;Show
                        </button>
                        <div class="clearfix">
                        </div>
                        <br />
                    </div>
                    <div class="col-sm-2  col-xs-6">                      
                            <asp:TextBox ID="txtSearch" runat="server" placeholder="Search By User Id" CssClass="form-control"
                                TabIndex="4" onkeypress="return trimTextBox(this)">
                            </asp:TextBox>                     
                        <div class="clearfix">
                        </div>
                       
                    </div>
                    <div class="col-md-1 col-xs-3">
                        <button class="btn btn-success" id="btnSearch" title="Search" runat="server" validationgroup="s"
                            onserverclick="btnSearch_Click" tabindex="5">
                            <i class="fa fa-search"></i>&nbsp;Search
                        </button>
                    </div>
                       <div class="pull-right col-md-1 col-xs-3 text-right">
                    <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                        OnClick="ibtnExcelExport_Click" />
                    <asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="images/word.jpg" OnClick="ibtnWordExport_Click" />
                </div>
                </div>
              
         
            <div class="form-group" style="display: none">
                <label for="MainContent_myForm_txtCcode" class="col-sm-2 col-xs-3 control-label lb6">
                    <asp:Label ID="lblAvailableOptions" CssClass="btn body" Visible="false" runat="server"
                        Text="Available Options">
                    </asp:Label>
                </label>
                <div style="display: none">
                    <div class="col-sm-1">
                        Paging
                    </div>
                    <div class="col-sm-2">
                        <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" CssClass="form-control"
                            OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
                            <%--<asp:ListItem Value="25">25</asp:ListItem>
                                <asp:ListItem Value="50">50</asp:ListItem>
                                <asp:ListItem Value="100">100</asp:ListItem>
                                <asp:ListItem>All</asp:ListItem>--%>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
            <table style="width: 100%;">
                <tbody>
                    <tr id="pr" class="printable" style="text-align: left;">
                        <td style="text-align: left;" class="top_table">
                            <table>
                                <tr>
                                    <td style="width: 220px" runat="server">
                                    </td>
                                    <td style="width: 420px">
                                    </td>
                                    <td width="3000px">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <cc1:HoverMenuExtender ID="HoverMenuExtender1" runat="server" TargetControlID="lblAvailableOptions"
                                PopupControlID="pnlChkList" PopupPosition="bottom">
                            </cc1:HoverMenuExtender>
                            <asp:Panel ID="pnlChkList" runat="server" BackColor="#fefec6" BorderColor="#b52821"
                                BorderStyle="Solid" BorderWidth="3px" Width="455px" Visible="false">
                                <table id="Table1" class="bleft">
                                    <tr>
                                        <td>
                                            <asp:CheckBox ID="ChkAddress" runat="server" Text="Address"></asp:CheckBox>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="Chkpassword" runat="server" Text="Password"></asp:CheckBox>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="ChkNomName" runat="server" Text="Nominee Name"></asp:CheckBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:CheckBox ID="ChkPanNo" runat="server" Text="Pan Number"></asp:CheckBox>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="ChkPaidDate" runat="server" Text="Paid Date"></asp:CheckBox>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="ChkPinCode" runat="server" Text="Pin Code"></asp:CheckBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:CheckBox ID="ChkDisst" runat="server" Width="100px" Text="District"></asp:CheckBox>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="ChkGName" runat="server" Text="Guardian Name"></asp:CheckBox>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="ChkNomRelation" runat="server" Text="Nominee Relation"></asp:CheckBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:CheckBox ID="ChKPhone" runat="server" Text="Primary Phnoe"></asp:CheckBox>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="ChkBranch" runat="server" Text="Branch"></asp:CheckBox>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="ChkIFC" runat="server" Text="IFC"></asp:CheckBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:CheckBox ID="ChkEMail" runat="server" Width="100px" Text="E-Mail"></asp:CheckBox>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="ChkBank" runat="server" Text="Bank"></asp:CheckBox>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="ChkDOB" runat="server" Text="D.O.B"></asp:CheckBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:CheckBox ID="ChkAccNo" runat="server" Text="Account Number"></asp:CheckBox>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="ChkMICR" runat="server" Text="MICR"></asp:CheckBox>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <asp:Button ID="Button4" OnClick="Button4_Click" runat="server" CssClass="btn" Text="Add Field (s)">
                                </asp:Button>&nbsp;&nbsp;
                                <asp:Button ID="Button5" OnClick="Button5_Click" runat="server" CssClass="btn" Text="Remove Field (s)">
                                </asp:Button>
                                &nbsp;
                                <asp:CheckBox ID="ChkSelectAll" onclick="CheckAll();" runat="server" Text="Select All" />
                                &nbsp;
                                <asp:CheckBox ID="ChkDeSelectAll" onclick="UnCheckAll();" runat="server" Text=" DeSelectAll" />
                            </asp:Panel>
                        </td>
                    </tr>
                </tbody>
            </table>
            <table style="width: 100%">
                <tr>
                    <td>
                        <asp:Label ID="lblcount" runat="server" Font-Bold="True" ForeColor="#000000"></asp:Label>
                        <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="#C00000"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
            </table>
            <div class="col-md-12">
            <div class="table-responsive">
               
                <asp:GridView ID="dglst" runat="server" AutoGenerateColumns="False" EmptyDataText="Record not found."
                    DataKeyNames="appmstregno" OnRowDeleting="dglst_RowDeleting" CssClass="table table-striped table-hover"
                    Width="100%" ShowFooter="false">
                    <Columns>
                        <%-- <asp:TemplateField HeaderText="SrNo.">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>--%>
                        <asp:BoundField DataField="Sno" HeaderText="Sr.No."></asp:BoundField>
                        <asp:TemplateField HeaderText="User Id" Visible="false">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnId" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    Text='<%# Eval("AppMstregno") %>' CommandName="EditProfile" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="AppMstregno" HeaderText="User Id"></asp:BoundField>
                        <asp:TemplateField HeaderText="Name">
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server" Text='<%#Eval("name").ToString()%>'>
                                </asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="appmstmobile" HeaderText="Mobile No"></asp:BoundField>
                        <asp:BoundField DataField="appmstpassword" HeaderText="Pwd"></asp:BoundField>
                        <%--    <asp:BoundField DataField="gname" HeaderText="Father Name" />--%>
                        <asp:BoundField DataField="SponsorID" HeaderText="Sponsor ID"></asp:BoundField>
                        <asp:BoundField DataField="sponsor" HeaderText="Sponsor Name"></asp:BoundField>
                        <%-- <asp:BoundField DataField="appmstaddress1" HeaderText="Address" />
              
                <asp:BoundField DataField="AppMstCity" HeaderText="City"></asp:BoundField>--%>
                        <%--  <asp:BoundField DataField="AppMstState" HeaderText="State"></asp:BoundField>--%>
                        <asp:TemplateField HeaderText="Address">
                            <ItemTemplate>
                                <asp:Label ID="lblpincode" runat="server" Text='<%#Eval("address1").ToString()%>'>
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:BoundField DataField="appmstpincode" HeaderText="Pincode" />  --%>
                        <%--  <asp:BoundField DataField="AppMstmobile" HeaderText="Mobile"></asp:BoundField>--%>
                        <asp:BoundField DataField="doj" HeaderText="DOE"></asp:BoundField>
                        <%-- <asp:BoundField DataField="ifscode" HeaderText="IFScode"></asp:BoundField>--%>
                        <%--                <asp:BoundField DataField="appmstpaid" HeaderText="Status"></asp:BoundField>--%>
                        <%--  <asp:TemplateField HeaderText="Caapping">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtcapping" runat="server" ></asp:TextBox>
                               </ItemTemplate>
                               </asp:TemplateField>
               
                <asp:TemplateField HeaderText="Submit" >
                    <ItemTemplate>
                     <asp:Button ID="Button2" runat="server" Text="Submit" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"  />
                    
                    </ItemTemplate>
                </asp:TemplateField>--%>
                        <%--  <asp:commandfield showdeletebutton="True" controlstyle-cssclass="displannone" deletetext="Tree">
                                <controlstyle cssclass="displannone"></controlstyle>
                            </asp:commandfield>--%>
                    </Columns>
                </asp:GridView>
               
                <div class="clearfix">
                </div>
                <br />
            </div>
</div>
             <div class="col-sm-3">
                    <asp:Button ID="Button2" runat="server" Text="<<Previous" CssClass="btn btn-success"
                        OnClick="btnpre_Click" />
                    <asp:Button ID="Button3" runat="server" Text="Next>>" CssClass="btn btn-success"
                        OnClick="btnnext_Click" />
                    <div class="clearfix">
                    </div>
                  
                </div>
                <div class="col-sm-2 col-xs-8">
                    <asp:TextBox ID="txtsearch1" runat="server" ValidationGroup="r" placeholder="Search By Page No"
                        CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" SetFocusOnError="true" ValidationGroup="r"
                        ControlToValidate="txtsearch1" Display="None" runat="server" ErrorMessage="Enter Page No!"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" SetFocusOnError="true"
                        runat="server" Display="None" ControlToValidate="txtsearch1" ErrorMessage="Only numeric values!"
                        ValidationExpression="\d+" ValidationGroup="r"> </asp:RegularExpressionValidator>
                    <div class="clearfix">
                    </div>
                   
                </div>
                <div class="col-sm-1 col-xs-4">
                    <button class="btn btn-success" id="btnsearch2" title="Search" runat="server" validationgroup="r"
                        onserverclick="btnsearch2_Click" tabindex="5">
                        <i class="fa fa-search"></i>&nbsp;Search
                    </button>
                </div>
                <div class="col-sm-4">
                    <asp:Label runat="server" ID="lbltotalrecord"></asp:Label>
                    <asp:Label ID="Label2" Visible="false" runat="server"></asp:Label>
                    <asp:Label ID="Label1" runat="server"></asp:Label>
                    <asp:Label ID="lblControl" runat="server"></asp:Label>
                    <asp:ValidationSummary ID="ValidationSummary3" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="r" />
                </div>
        </div>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please enter date in dd/mm/yy format!"
            ControlToValidate="txtFromDate" Font-Bold="False" ForeColor="#C00000" ValidationGroup="Show"
            Display="None">
        </asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator23" runat="server"
            ControlToValidate="txtFromDate" ErrorMessage="Please enter date in dd/mm/yy format!"
            Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9/]*" Display="none"
            ValidationGroup="Show">
        </asp:RegularExpressionValidator>
        <br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtToDate"
            ErrorMessage="Please enter date in dd/mm/yy format!" Font-Bold="False" ForeColor="#C00000"
            ValidationGroup="Show" Display="None">
        </asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtToDate"
            ErrorMessage="Please enter date in dd/mm/yy format!" Font-Bold="False" ForeColor="#C00000"
            ValidationExpression="^[0-9/]*" Display="none" ValidationGroup="Show">
        </asp:RegularExpressionValidator>
        <br />
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
            ShowSummary="False" ValidationGroup="Show" Width="220px" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ControlToValidate="txtSearch"
            Display="None" ErrorMessage="Please enter user id!" ForeColor="#C00000" ValidationGroup="s">
        </asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtSearch"
            Display="None" ErrorMessage="Only alpha numeric value without space is allowed!"
            ForeColor="#C00000" ValidationGroup="s" ValidationExpression="^[a-zA-Z0-9]*">
        </asp:RegularExpressionValidator>
        <asp:ValidationSummary ID="ValidationSummary2" runat="server" ValidationGroup="s"
            ShowMessageBox="true" ShowSummary="false" />
        <div id="panlID1" runat="server" visible="false" style="margin-left: 20%; overflow: auto;
            background-color: #fff; border-radius: 5px; -moz-border-radius: 5px; position: absolute;
            width: 300px; padding: 12px; z-index: 5px; top: 0px; border: solid 5px #013a77;">
            <table class="table table-striped table-hover">
                <tr>
                    <td colspan="2" align="left" style="font-size: 12px; font-weight: bold;">
                        TOP-UP DETAILE
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td>
                        User Id :
                    </td>
                    <td>
                        <asp:Label ID="lbl_Userid" runat="server" Width="150px" Font-Bold="true"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        User Name :
                    </td>
                    <td style="color: #3333CC;">
                        <asp:Label ID="lbl_UName" runat="server" Width="150px" Font-Bold="true"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        Sponsor Id :
                    </td>
                    <td>
                        <asp:Label ID="lbl_SpoId" runat="server" Width="150px" Font-Bold="true"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        Select Type :
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlPaidType" runat="server" Width="220px">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 10px">
                    </td>
                </tr>
                <%-- <tr>
                <td>Total Ampount:
                </td>
                <td>
                    <asp:Label ID="lbl_TAmt" runat="server" Width="150px" Text="11000" Font-Bold="true"></asp:Label>
                </td>
            </tr>
           <tr>
                <td>
                    Transaction Password :
                </td>
                <td>
                    <asp:textbox id="txt_epwd" runat="server" width="150px" textmode="Password">
                    </asp:textbox>
                </td>
            </tr>--%>
                <tr>
                    <td>
                    </td>
                    <td>
                        <asp:Button ID="RaiseDisputetxt" runat="server" Text="SUBMIT" CssClass="btn" ValidationGroup="NJ"
                            OnClick="RaiseDisputetxt_Click" OnClientClick="if (!confirm('Are you sure ?')) return false;" />
                        <input type='button' id='hideshow' onclick="return showHide();" value='Skip' />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </div>
    <div class="clearfix"></div>
    </div>
</asp:Content>
