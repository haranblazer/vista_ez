<%@ Page Language="C#" MasterPageFile="~/User/user.master" AutoEventWireup="true" CodeFile="Ticket.aspx.cs"
    Inherits="user_Messages" Title="ezcarestore.com | Ticket" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager runat="server" />
    <script language="javascript" type="text/javascript">       
  

<script type = "text/javascript">

        
    function CheckValidation(){
        alert('Validation');
    }

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
                        if (ValChecked) {
                            if (frm.elements[i].type == "checkbox") {
                                frm.elements[i].checked = true;

                                //frm.elements[i+1].parentNode.parentNode.style.backgroundColor = "#FAF8CC";

                            }

                        }
                        else {
                            if (frm.elements[i].type == "checkbox") {
                                frm.elements[i].checked = false;
                                // frm.elements[i].parentNode.parentNode.style.backgroundColor = "white";         
                            }
                        }
                    }
                    else if (ValId.indexOf('deleteRec') != -1) {
                        // Check if any of the checkboxes are not checked, and then uncheck top select all checkbox
                        if (frm.elements[i].checked == false) {
                            if (frm.elements[i].type == "checkbox") {
                                frm.elements[1].checked = false;
                                //frm.elements[i].parentNode.parentNode.style.backgroundColor = "white"; 
                            }
                        }
                        else if (frm.elements[i].checked == true) {
                            if (frm.elements[i].type == "checkbox") {
                                frm.elements[1].checked = true;
                                // frm.elements[i].parentNode.parentNode.style.backgroundColor = "#FAF8CC"; 
                            }
                        }
                    }
                } // if
            } // for
        } // function


 
    </script>

      <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Raise Tickets Box
</h4>					
				</div>
  
  
            <div runat="server">
                                <asp:HiddenField ID="hidid" runat="server" />
                                <%--<div>
                                    <div class="row ">
                                        <div class="col-md-3 control-label">
                                            Search by Ticket Number
                                        </div>
                                        <div class="col-md-3 " style="padding-bottom: 15px;">
                                            <asp:TextBox ID="txtSearch" runat="server" pattern="^[a-zA-Z0-9\s]+$" title="Search Creteria contain letters and numbers with space or without space."
                                                required="required" CssClass="form-control"></asp:TextBox>
                                        </div>
                                   
                                        <div class="col-md-3 btn1">
                                            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"
                                                ValidationGroup="Search" CssClass="btn btn-primary" />
                                        </div>
                                    </div>
                                </div>--%>
                                <div class="clearfix">
                                </div>
                                <div class="col-md-12" runat="server" id="search">
                               
                             
                                
                                &nbsp;<asp:LinkButton ID="lnkbtnReadMessages" Font-Bold="true" runat="server" OnClick="lnkbtnReadMessages_Click"
                                    CssClass="btn btn-primary">Open Tickets<span class="btn-icon-end"><i class="fa fa-envelope-open"></i></span> </asp:LinkButton><%--<asp:ImageButton ID="ImageButton6"
                                        runat="server" ImageUrl="~/user/images/new_msgs.gif" OnClick="ImageButton6_Click" />--%>
                                <asp:LinkButton ID="lnkbtnUnReadMessages" Font-Bold="true" runat="server" OnClick="lnkbtnUnReadMessages_Click"
                                    CssClass="btn btn-primary">Closed Tickets<span class="btn-icon-end"><i class="fa fa-envelope"></i></span></asp:LinkButton>
                                <%--<asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="images/inbox.gif" OnClick="ImageButton5_Click" />--%>
                               
                                <asp:LinkButton ID="lnkbtnDeletedMessages" Font-Bold="true" runat="server" OnClick="lnkbtnDeletedMessages_Click"
                                    CssClass="btn btn-danger">Cancelled Tickets<span class="btn-icon-end"><i class="fa fa-trash"></i></span> </asp:LinkButton>&nbsp;
                                <%--<asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="~/user/images/trash.gif"
                                    OnClick="ImageButton4_Click" />--%>
                               
                            </div>

                

                           <asp:UpdatePanel runat="server" ID="updPanel">
                               <ContentTemplate>
                                      <div class="table-responsive">
                                <div class="col-md-12 ">
                            <table width="100%">
                                  <tr><td colspan="2"><h3>Create Ticket</h3></td></tr>
                                  <tr><td>Ticket Type <span class="color-red">*</span></td>
                                      <td><asp:DropDownList runat="server" ID="ddl_ticketType" required="required" DataTextField="DepartmentName" DataValueField="ID">
                                          </asp:DropDownList></td>
                                   </tr>
                                    <tr><td colspan="2"><br /></td></tr>
                                    <tr>
                                      <td>Attach Image</td>
                                      <td><asp:FileUpload runat="server" id="fileUpload"/></td>
                                  </tr>
                                 <tr><td colspan="2"><br /></td></tr>
                                  <tr><td>Query <span class="color-red">*</span></td>
                                       <td><asp:TextBox runat="server" ID="txtProblemDesc" Rows="5" TextMode="MultiLine" required="required" Width="100%"></asp:TextBox></td>
                                  </tr>       
                                  <tr><td colspan="2">
                                      <asp:Button runat="server" ID="btnCreate" CssClass="btn btn-primary"  Text ="Create Ticket" OnClientClick="CheckValidation()" OnClick="btnCreate_Click"/>
                                      </td>
                                  </tr>
                            </table>
                                    </div>
                    </div>
                            <div class="col-md-12" id="Tr1" runat="server">
                                <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="#C00000" Font-Size="10pt"></asp:Label>
                            </div>
                            <div class="table-responsive">
                                <div class="col-md-12 ">
                                    <asp:GridView ID="GridView1" DataKeyNames="MessageId" EmptyDataText="Message not found."
                                        runat="server" AutoGenerateColumns="False" AllowPaging="True" CssClass="table table-striped table-hover display dataTable nowrap cell-border"
                                        PageSize="25" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand"
                                        GridLines="Horizontal" OnRowDataBound="GridView1_RowDataBound">
                                        <Columns>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" >
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="deleteRec" OnClick="return check_uncheck(this);" runat="server" />
                                                </ItemTemplate>
                                                <HeaderTemplate>
                                                    <asp:CheckBox ID="CheckAll" TextAlign="Left" runat="server" OnClick="return check_uncheck(this); " />
                                                </HeaderTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="hdnfldMessageId" runat="server" Value='<%# Eval("MessageId") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Image ID="imgStatus" runat="server" /></ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkbtnSenderName" Font-Underline="false" Text='<%# Eval("SenderId") %>'
                                                        CommandName="SenderName" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                                        runat="server" /></ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkbtnSubject" Font-Underline="false" Text='<%# Eval("MsgSubject") %>'
                                                        CommandName="Subject" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                                        runat="server" /></ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkbtnDOE" Font-Underline="false" Text='<%# Eval("doe") %>' CommandName="doe"
                                                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" runat="server" /></ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                 
                                     <asp:LinkButton ID="lnkFake" runat="server"></asp:LinkButton>
                                    <cc1:ModalPopupExtender ID="popup" runat="server" DropShadow="false"
                                            PopupControlID="panelCreate" TargetControlID = "lnkFake"
                                        BackgroundCssClass="modalBackground">
                                    </cc1:ModalPopupExtender>
                                </div>
                            </div>
                               </ContentTemplate>
                               <Triggers>
<asp:AsyncPostBackTrigger ControlID = "GridView1" />

</Triggers>
                           </asp:UpdatePanel>
                              
                               
                            </div>

                         
   <style>
   th {
    text-align: left;
}
  </style>
   

</asp:Content>
