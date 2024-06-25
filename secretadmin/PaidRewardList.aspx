<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="PaidRewardList.aspx.cs" Inherits="secretadmin_PaidRewardList" %>

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
  <h4 class="fs-20 font-w600  me-auto float-left mb-0">Reward List</h4>
    <div class="row">
                    <div class="col-sm-2">
            
                <asp:TextBox ID="txtFromDate" runat="server" placeholder="DD/MM/YYYY" pattern="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                    MaxLength="10" CssClass="form-control" title="From date should be as dd/mm/yyyy"
                    required="required"></asp:TextBox>
                
            
        </div>
      
        <div class="col-sm-2">
           
                <asp:TextBox ID="txtToDate" runat="server" placeholder="DD/MM/YYYY" pattern="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                    MaxLength="10" CssClass="form-control" title="To date should be as dd/mm/yyyy"
                    required="required"></asp:TextBox>
              
          
           
        </div>
                     <div class="col-sm-1">
            <asp:Button ID="btnSearchByDate" runat="server" Text="Search" CssClass="btn btn-primary"
                OnClick="btnSearchByDate_Click" />
        </div>
        <div class="col-sm-2 ">
            <asp:DropDownList ID="ddlRewardList" runat="server" AutoPostBack="true" CssClass="form-control"
                OnSelectedIndexChanged="ddlRewardList_SelectedIndexChanged">
            </asp:DropDownList>
        </div>
        <div class="col-md-2 text-right pull-right">
            <asp:ImageButton ID="ibtnExcelExport" runat="server" ImageUrl="images/excel.gif"
                OnClick="ibtnExcelExport_Click" />
            <asp:ImageButton ID="ibtnWordExport" runat="server" ImageUrl="images/word.jpg" OnClick="ibtnWordExport_Click" />
        </div>
                </div>

      <hr />
    <div class="col-sm-12">

        <asp:Label ID="lblMessage" runat="server" CssClass="control-label" Font-Bold="true"></asp:Label></div>
        <div class="table table-responsive">
            <asp:GridView ID="gridlist" runat="server" CssClass="table table-striped table-hover mygrd" DataKeyNames="srno,TransactionID,remarks"
                PageSize="50" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Record Found."
                OnPageIndexChanging="gridlist_PageIndexChanging" AllowPaging="true" 
                onrowdatabound="gridlist_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderText="Sr No.">
                        <ItemTemplate>
                            <asp:Label ID="lblsrno" runat="server" Text='<%# Container.DataItemIndex +1%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:BoundField DataField="TransactionID" HeaderText="TranID" />
                       <asp:BoundField DataField="remarks" HeaderText="Remark" />
                    <asp:BoundField DataField="name" HeaderText="User Name" />

                    <asp:BoundField DataField="userid" HeaderText="User ID" />
                    <asp:BoundField DataField="name" HeaderText="User Name" />
                    <asp:BoundField DataField="reward" HeaderText="Reward" />
                    <asp:BoundField DataField="doe" HeaderText="Doe" />
                    <asp:BoundField DataField="leftpoint" HeaderText="left point" />
                    <asp:BoundField DataField="rightpoint" HeaderText="Right point" />

                  
                </Columns>
            </asp:GridView>
        </div>

    
 
</asp:Content>

