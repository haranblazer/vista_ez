<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="BankReport.aspx.cs" Inherits="BankReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="upWall" runat="server" ChildrenAsTriggers="true" UpdateMode="conditional">
        <ContentTemplate>
             <h4 class="fs-20 font-w600  me-auto float-left mb-0">User Bank/PanNo Report</h4>
       <div class="row">
                   
                <div class="col-sm-2 ">
                    
                        <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"
                            placeholder="From"></asp:TextBox>
                </div>
            
                <div class="col-sm-2">
                   
                        <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"
                            placeholder="To"></asp:TextBox>
                </div>
               
                <div class="col-sm-2 ">
                    <asp:DropDownList ID="ddlPinType" runat="server" CssClass="form-control" AutoPostBack="True"
                        OnSelectedIndexChanged="ddlPinType_SelectedIndexChanged">
                        <asp:ListItem Value="1">Bank</asp:ListItem>
                        <asp:ListItem Value="2">Pan</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2 pull-right">
                    <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="~/secretadmin/images/excel.gif"
                        OnClick="ibtnExcelExport_Click" />
                    <asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="~/secretadmin/images/word.jpg"
                        OnClick="ibtnWordExport_Click" />
                </div>
                    <div class="col-md-12">  <asp:Label ID="lblMsg" runat="server" ForeColor="#C00000" Font-Bold="True"></asp:Label></div>
                </div>
            </div>


                           
           
         
           
          
       <hr />
            <div class="table-responsive">
                <asp:GridView AllowPaging="true" AutoGenerateColumns="false" CssClass="table table-striped table-hover"
                    PageSize="50" OnPageIndexChanging="gvActivePinList_PageIndexChanging" ID="gvActivePinList"
                    runat="server" CellPadding="4" Width="100%" BorderStyle="Solid" BorderWidth="1px"
                    Font-Size="14px">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.No">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="User Id" DataField="AppMstregno" ItemStyle-HorizontalAlign="Left"
                            HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField HeaderText="Name" DataField="AppMstFName" ItemStyle-HorizontalAlign="Left"
                            HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField HeaderText="Mobile No" DataField="appmstmobile" ItemStyle-HorizontalAlign="Left"
                            HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField HeaderText="Bank Name" DataField="BankName" ItemStyle-HorizontalAlign="Left"
                            HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField HeaderText="Branch" DataField="Branch" ItemStyle-HorizontalAlign="Left"
                            HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField HeaderText="Account No" DataField="AcountNo" ItemStyle-HorizontalAlign="Left"
                            HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="ifscode" HeaderText="IFS Code" ItemStyle-HorizontalAlign="Left"
                            HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="bankdate" HeaderText="DOE" ItemStyle-HorizontalAlign="Left"
                            HeaderStyle-HorizontalAlign="Left" />
                    </Columns>
                </asp:GridView>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <div class="table-responsive">
                <asp:GridView AllowPaging="true" AutoGenerateColumns="false" CssClass="table table-striped table-hover"
                    PageSize="50" ID="GridView1" runat="server" OnPageIndexChanging="GridView1_PageIndexChanging">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.No">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="User Id" DataField="AppMstregno" ItemStyle-HorizontalAlign="Left"
                            HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField HeaderText="Name" DataField="AppMstFName" ItemStyle-HorizontalAlign="Left"
                            HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField HeaderText="Mobile No" DataField="appmstmobile" ItemStyle-HorizontalAlign="Left"
                            HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="panno" HeaderText="Pan No" ItemStyle-HorizontalAlign="Left"
                            HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="pandate" HeaderText="DOE" ItemStyle-HorizontalAlign="Left"
                            HeaderStyle-HorizontalAlign="Left" />
                    </Columns>
                </asp:GridView>
            </div>
            <div class="clearfix">
            </div>
            <br />
            <table style="width: 100%; text-align: left;">
                <tr>
                    <td class="style2">
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator23" runat="server"
                            ControlToValidate="txtFromDate" ErrorMessage="Please enter date dd/mm/yy format!"
                            Font-Bold="False" ForeColor="#C00000" ValidationExpression="^[0-9/]*" Display="none"
                            ValidationGroup="Show"></asp:RegularExpressionValidator><asp:RegularExpressionValidator
                                ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtToDate"
                                ErrorMessage="Please enter date dd/mm/yy format!" Font-Bold="False" ForeColor="#C00000"
                                ValidationExpression="^[0-9/]*" Display="none" ValidationGroup="Show"></asp:RegularExpressionValidator>
                        <asp:ValidationSummary ID="ValidationSummary2" runat="server" ValidationGroup="Show"
                            ShowMessageBox="true" ShowSummary="false" />
                    </td>
                </tr>
            </table>
            <div class="clearfix">
            </div>
           
        </ContentTemplate>
    </asp:UpdatePanel>
    <script type="text/javascript">
        $(document).ready(

     function () {

         $('.7').show();
     }
    );
    </script>
</asp:Content>
