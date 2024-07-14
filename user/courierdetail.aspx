<%@ Page Title="Courier Detail" Language="C#" MasterPageFile="user.master" AutoEventWireup="true"
    CodeFile="courierdetail.aspx.cs" Inherits="user_downstatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $.noConflict();
        jQuery(document).ready(function ($) {
            $('#<%=txtFromDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
            $('#<%=txtToDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        }); 
    </script>

    <div class="accordion accordion-rounded-stylish accordion-bordered" id="accordion-eleven">
								  <div class="accordion-item mb-0 row">
                                      <div class="col-md-6">
										<div class="accordion-header rounded-lg collapsed" id="accord-11One" data-bs-toggle="collapse" data-bs-target="#collapse11One" aria-controls="collapse11One" aria-expanded="false" role="button">
										<span class="accordion-header-icon"></span>
								<h4 class="fs-20 font-w600  me-auto float-left mb-0">Courier Detail</h4>
									  <span class="fa fa-sort-desc plus float-left"></span>                                                     
									</div>
                                          </div>
                                      <div class="col-md-6">
                                       <div class="pull-right ">					
					 <div>
					    <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-file-word-o me-2"></i>Word</a>
                        <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-file-excel-o me-2"></i>Excel</a>
                        <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-file-pdf-o me-2"></i>PDF</a>
                        <a href="#" class="btn btn-primary btn-sm"><i class="fa fa-print me-2"></i>Print</a>
					</div>
				</div>
                                          </div>
                          <div class="clearfix"></div>
								<div id="collapse11One" class="accordion__body collapse" aria-labelledby="accord-11One" data-bs-parent="#accordion-eleven" style="">
									 
									  <div class="accordion-body-text">
										    <asp:Panel ID="pnlDate" runat="server" DefaultButton="Button1">
                        
                       
                        <div class="form-group card-group-row row">
                            <div class="col-md-1 control-label">
                                From:</div>
                            <div class="col-md-2 col-xs-12 ">
                                <asp:TextBox ID="txtFromDate" runat="server" ToolTip="dd/mm/yyyy" CssClass="form-control"></asp:TextBox></div>
                            <div class="col-md-1 col-xs-12 control-label">
                                To:</div>
                            <div class="col-md-2 col-xs-12 ">
                                <asp:TextBox ID="txtToDate" runat="server" ToolTip="dd/mm/yyyy" CssClass="form-control"></asp:TextBox></div>
                            <div class="col-md-2 col-xs-6">
                                <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" OnClick="Button1_Click"
                                    Text="SHOW LIST" /></div>
                            <div class="col-md-2 col-xs-6 text-right">
                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/user/images/excel.gif"
                                    OnClick="ImageButton1_Click" />
                            </div>
                        </div>
                     
                </asp:Panel>
									  </div>
									</div>
								  </div>
								  
								  
								</div>
    
  
                
         
          
            <div class="form-group">
                <div class="col-sm-3">
                    <asp:Label ID="Label2" Visible="true" runat="server" Font-Bold="True"></asp:Label>
                    <asp:Label ID="Label1" runat="server"></asp:Label>
                </div>
            </div>
            <div class="col-sm-3 pull-right" style="background-color: ; border-radius: 20px;
                height: 30px; padding-top: 5px; width: auto;">
                <asp:Repeater ID="rptPager" runat="server">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkPage" runat="server" Text='<%#Eval("Text") %>' CommandArgument='<%# Eval("Value") %>'
                            CssClass='<%# Convert.ToBoolean(Eval("Enabled")) ? "page_enabled" : "page_disabled" %>'
                            OnClick="Page_Changed" OnClientClick='<%# !Convert.ToBoolean(Eval("Enabled")) ? "return false;" : "" %>'
                            Style="color: #fff; font-weight: bold;"></asp:LinkButton>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div style="clear: both">
            </div>
         
            <div class="table-responsive">
            <asp:GridView CssClass="table table-striped table-hover" HeaderStyle-BackColor="#fe6a00" HeaderStyle-ForeColor="#ffffff" ID="GridView1" runat="server"
                                AutoGenerateColumns="false" Width="100%">
                                <%-- <PagerSettings PageButtonCount="25" />--%>
                                <Columns>
                                    <asp:BoundField DataField="RowNumber" HeaderText="Sr.No" />
                                    <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                        DataField="USERID" HeaderText="USER ID" />
                                    <%--   <asp:BoundField DataField="Name" HeaderText="NAME">
                                                <HeaderStyle HorizontalAlign="Left" />
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:BoundField>--%>
                                    <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                        DataField="dispatcheddate" HeaderText="DISPATCH DATE" DataFormatString="{0:dd/MM/yyyy hh:mm:ss tt}" />
                                    <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                        DataField="DOCKETNO" HeaderText="DOCKETNO" />
                                    <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                        DataField="COURIERCOMPANY" HeaderText="COURIER COMPANY" />
                                    <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                        DataField="REMARKS" HeaderText="REMARKS" />
                                    <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                        DataField="receivedstatus" HeaderText="RECEIVED STATUS" />
                                    <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"
                                        DataField="receiveddate" HeaderText="RECEIVE DATE" DataFormatString="{0:dd/MM/yyyy hh:mm:ss tt}" />
                                </Columns>
                            </asp:GridView>
            </div>
     
</asp:Content>
