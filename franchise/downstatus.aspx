<%@ Page Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="downstatus.aspx.cs" Inherits="user_downstatus" Title="Down Status" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>
    <h1>
        Downline Status
    </h1>
    <br />



    <div class="form-group">
                                    <label for="MainContent_txtPassword" class="col-md-2 control-label">
From  :</label>
                                    <div class="col-md-3"> 
                                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    </div>
                                    <br />
                                    <br />

                                      <div class="form-group">
                                    <label for="MainContent_txtPassword" class="col-md-2 control-label">
 To  :</label>
                                    <div class="col-md-3"> 
                                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox><br />
                                        <asp:Button ID="Button1" runat="server" CssClass="btn btn-success ladda-button" OnClick="Button1_Click" Text="Show" />
                                    </div>
                                    </div>
                                       <br />
                                    <br /> <br />
                                    <br /> <br />
                                      <div class="form-group">
                                    <label for="MainContent_txtPassword" class="col-md-2 control-label">

Member Type :</label>
                                    <div class="col-md-3"> 
                                    <asp:DropDownList
                                            ID="ddlMemberType" runat="server" AutoPostBack="True" CssClass="form-control" OnSelectedIndexChanged="ddlMemberType_SelectedIndexChanged">
                                            <asp:ListItem Value="-1">All</asp:ListItem>
                                            <asp:ListItem Value="1">Paid</asp:ListItem>
                                            <asp:ListItem Value="0">UnPaid</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    </div>
                                       <div class="form-group">

                                           
                                           
                                    <div class="col-md-12" style="text-align: right;"> 
                                        <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="~/user_images/excel.gif"
                                            OnClick="imgbtnExcel_Click" Width="25px" />
                                        <asp:ImageButton ID="imgbtnWord" runat="server" ImageUrl="~/user_images/word.jpg"
                                            OnClick="imgbtnWord_Click" Style="margin-left: 0px" Width="26px" />
                                        <asp:ImageButton ID="imgbtnpdf" runat="server" ImageUrl="~/user_images/pdf.gif" OnClick="imgbtnpdf_Click" />
                                   
                                    </div>
                                    </div>
                                    <div id="MainContent_alertPanel" class="col-sm-12">
                            <div class="alert alert-danger" role="alert">
                                <asp:Button ID="Button3" runat="server" Text="Go Up" CssClass="btn btn-success btn-sm ladda-butto" onclick="Button3_Click" />
                                <span id="MainContent_lblalert"><asp:Label ID="lbluserid" runat="server" ></asp:Label></span>
                            </div>
                        </div>

    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td class="top_accountd" style="padding-right: 12px; padding-left: 14px; width: 100%;
                height: 43px;">
                <table class="fsttable" border="0" cellpadding="0" cellspacing="0" style="width: 100%">                  
                    <tr>
                        <td class="fsttable_a" style="padding-left: 10px; padding-bottom: 5px; width: 100%;
                            padding-top: 5px; height: 4px; text-align: left">
                            <asp:Label ID="Label2" runat="server" Font-Bold="True"></asp:Label>
                        </td>
                    </tr>
                     </table>
                   
                                <asp:GridView ID="GridView1" EmptyDataText="No record found" CssClass="table table-striped table-hover" runat="server"
                                    AllowPaging="true" AutoGenerateColumns="false" OnPageIndexChanging="GridView1_PageIndexChanging"
                                    CellPadding="4" CellSpacing="1" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle"
                                    PageSize="50" Width="100%" Style="text-align: center" 
                                    onrowcreated="GridView1_RowCreated" 
                                    onrowdatabound="GridView1_RowDataBound" 
                                    onrowcommand="GridView1_RowCommand"  >
                                    <PagerSettings PageButtonCount="25" />
                                    <Columns>
                                        <asp:TemplateField >
                                            <ItemStyle Height="20px" HorizontalAlign="Center" Font-Bold="True"></ItemStyle>
                                            <ItemTemplate>
                                                <%#Container.DataItemIndex+1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="appMstRegno" >
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Name">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>

                                         <asp:TemplateField >
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" Text='<%# Eval("status")%>'></asp:Label>
                                             <asp:Button ID="Button2" runat="server" Text="Status" CommandArgument='<%# Eval("AppMstregno") %>' CommandName="PAID" CssClass="btn btn-default btn-sm ladda-button glyphicon glyphicon-arrow-down  " >
                                           
                                           
                                             </asp:Button>
                                      
                                         </ItemTemplate>
                                         </asp:TemplateField>


                                         <asp:BoundField DataField="appmstrank" >
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>

                                       <asp:BoundField DataField="pbvamt" HeaderText="PBV">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>

                                         <asp:BoundField DataField="pbvamt" HeaderText="GBV" >
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>

                                         <asp:BoundField DataField="tbvamt" HeaderText="TBV" >
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>

                                       

                                           <asp:BoundField DataField="oldpbv" HeaderText="PBV" >
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                   

                                               <asp:BoundField DataField="oldgbv" HeaderText="GBV" >
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>

                                             <asp:BoundField DataField="oldtbv" HeaderText="TBV" >
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                   
                
                                      
                                        <%--<asp:BoundField DataField="AppmstDOJ" HeaderText="DateOfJoining">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" />
                                        </asp:BoundField>--%>
                                    </Columns>
                                </asp:GridView>
                            
               
                </td>
                </tr>
                </table>
</asp:Content>
