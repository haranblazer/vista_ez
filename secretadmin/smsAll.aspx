<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="smsAll.aspx.cs" Inherits="secretadmin_smsAll" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
					<h4 class="fs-20 font-w600  me-auto">SMS List</h4>					
				</div>
 <div class="row">
    
                <div class="col-sm-3">
                    <asp:TextBox ID="TxtMobile" runat="server" MaxLength="30" CssClass="form-control"
                        ToolTip="InvNo/UserID/Name" placeholder="Search By mobile no"></asp:TextBox>
                </div>
                  
                
                <div class="col-sm-2">

                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"
                        placeholder="From"></asp:TextBox>
                </div>
                
                <div class="col-sm-2">

                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" ToolTip="dd/mm/yyyy"
                        placeholder="To"></asp:TextBox>
                </div>
                 <div class="col-sm-1">
                    <button title="Search" id="Button1" runat="server" class="btn btn-primary" onserverclick="btnSearch_Click"
                        validationgroup="Show">
                        Search
                    </button>
                    </div>
                <div class="col-sm-2 col-xs-6" >
                    <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click"
                        Width="25px" />
                </div>
                </div>
               
                <div class="table-responsive">
        <asp:GridView ID="Grid" runat="server" AutoGenerateColumns="False" AllowPaging="true" PageSize="50"
            EmptyDataText="No Data Found." OnPageIndexChanging="GridView1_PageIndexChanging" CssClass="table table-striped table-hover">
            
             <Columns>
                        <asp:TemplateField HeaderText="SrNo.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:BoundField HeaderText="Mobile" DataField="Mobile" />
                         <asp:BoundField HeaderText="Message" DataField="TextMsg" />
                        <asp:BoundField HeaderText="Response" DataField="Response" />
                        <asp:BoundField HeaderText="date" DataField="date" />
            </Columns>
        </asp:GridView>
        <div id="popupdiv" title="Basic modal dialog" style="display: none">
            <asp:HiddenField  ID="hid_hitext" runat="server" />
            User Id: <label id="lblId"></label><br />
            D.O.B: <label id="lblDob"></label><br />
            Pan No: <label id="lblPan"></label><br />
             <label id="lblPanImg" style="width:100%;"></label><br />
         </div>
    </div>
     


</asp:Content>

