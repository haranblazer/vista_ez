<%@ Page Title="" Language="C#" MasterPageFile="~/secretadmin/MasterPage.master" AutoEventWireup="true" CodeFile="Reward_New.aspx.cs" Inherits="secretadmin_Reward_New" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
      <h4 class="fs-20 font-w600  me-auto">Reward List</h4>
  </div>
                <div class="row">
                <div class="col-sm-1 control-label">
                    From
                </div>
                <div class="col-sm-2">

                    <asp:TextBox ID="txtFromDate" runat="server" placeholder="DD/MM/YYYY" pattern="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                        MaxLength="10" CssClass="form-control" title="From date should be as dd/mm/yyyy"
                        required="required"></asp:TextBox>
                </div>
                <div class="col-sm-1 control-label">
                    To
                </div>

                <div class="col-sm-2">
                    <asp:TextBox ID="txtToDate" runat="server" placeholder="DD/MM/YYYY" pattern="^(((0[1-9]|[12]\d|3[01])/(0[13578]|1[02])/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)/(0[13456789]|1[012])/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])/02/((19|[2-9]\d)\d{2}))|(29/02/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$"
                        MaxLength="10" CssClass="form-control" title="To date should be as dd/mm/yyyy"
                        required="required"></asp:TextBox>
                </div>

                 <div class="col-sm-3">
                    <asp:DropDownList ID="ddlRewardList" runat="server" CssClass="form-control">
                       <%-- <asp:ListItem Value="0">--Select Reward--</asp:ListItem>--%>
                    </asp:DropDownList>
                </div>

                <div class="col-sm-1"> 
<input type="button" value="Search" class="btn btn-success" onclick="BindTable()" />
                </div>
               
            </div>
      <link href="../Grid_js_css/jquery.dataTables.min.css" rel="stylesheet" />
  <link href="../Grid_js_css/buttons.dataTables.css" rel="stylesheet" />

  <script src="../Grid_js_css/jquery-3.5.1.js" type="text/javascript"></script>
  <script src="../Grid_js_css/jquery.dataTables.js" type="text/javascript"></script>
  <script src="../Grid_js_css/dataTables.buttons.min.js" type="text/javascript"></script>
  <script src="../Grid_js_css/jszip.min.js" type="text/javascript"></script>
  <script src="../Grid_js_css/pdfmake.min.js" type="text/javascript"></script>
  <script src="../Grid_js_css/vfs_fonts.js" type="text/javascript"></script>
  <script src="../Grid_js_css/buttons.html5.min.js" type="text/javascript"></script>
  <script src="../Grid_js_css/buttons.print.min.js" type="text/javascript"></script>
  <script> var $JDT = $.noConflict(true); </script>

  <script type="text/javascript">
      var pageUrl = '<%=ResolveUrl("Reward_New.aspx")%>';
      $JDT(function () {
          BindTable();
      });
      function BindTable() {
          $('#LoaderImg').show();
          var fromDate = dateFormate($('#<%=txtFromDate.ClientID%>').val());
          var toDate = dateFormate($('#<%=txtToDate.ClientID%>').val());
        var RewardList = $('#<%=ddlRewardList.ClientID%>').val();

          $.ajax({

              type: "POST",
              url: pageUrl + '/BindTable',
              data: '{fromDate:"' + fromDate + '",toDate:"' + toDate + '",RewardList:"' + RewardList + '"}',
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              success: function (data) {
                  $('#LoaderImg').hide();
                  var json = [];

                  for (var i = 0; i < data.d.length; i++) {

                      let SubmitButton = '', srno = '', RemarksTextbox = '', TranNo_Textbox = '';
                      srno = data.d[i].srno;
                      if (data.d[i].TStatus == "1") {
                          SubmitButton = '<input type="button" disabled value="Submitted" class="btn btn-success"/ >';
                          RemarksTextbox = data.d[i].Remarks;
                          //TranNo_Textbox = data.d[i].Tran_No;

                      }
                      else {
                          RemarksTextbox = '<input type="text" id="txt_remark' + srno + '" class="form-control" />';
                         // TranNo_Textbox = '<input type="text" id="txt_tran_no' + srno + '" class="form-control" />';
                          SubmitButton = '<input type="button" value="Submit" class="btn btn-success" onclick="Submit(' + srno + ')">';
                      }
                      json.push([i + 1,
                      //'<a target="_blank" href="purchaseorderbill.aspx?id=' + data.d[i].srno + '" >' + data.d[i].Order_No + '</a>',

                      //  LoginStatus


                      // data.d[i].Login,

                      data.d[i].User_ID,
                      data.d[i].User_Name,
                      data.d[i].Reward,
                      data.d[i].Doe,
                   
                          //data.d[i].Tran_No,
                          // data.d[i].Remarks
                          RemarksTextbox,
                          SubmitButton

                      ]);
                  }
                  $JDT('#tblList').DataTable({
                      dom: 'Blfrtip',
                      scrollY: "500px",
                      scrollX: true,
                      scrollCollapse: true,
                      buttons: ['csv', 'excel', 'pdf', 'print'],
                      data: json,
                      columns: [
                          { title: "#" },


                          { title: "User ID" },
                          { title: "User Name" },
                          { title: "Reward" },
                          { title: "Doe" },
                          { title: "Remarks" },
                          { title: "Delivered" }

                      ],
                      "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                      "pageLength": 15,
                      "bDestroy": true
                  });
              },
              error: function (result) {
                  $('#LoaderImg').hide();
                  (result);
              }
          });
      }
      function Submit(srno) {
          var Remarks = $('#txt_remark' + srno).val();
         // var Tran_No = $('#txt_tran_no' + srno).val();
          $.ajax({
              type: "POST",
              url: pageUrl + '/Submit',
              data: '{srno:"' + srno + '",Remarks:"' + Remarks + '"}',
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              success: function (data) {
                  if (data.d == "1") {
                      alert("Reward Given Successfully.!!!");
                      BindTable();
                  }

              },
              error: function (result) {
                  (result);
              }
          });
      }

      function dateFormate(datevalue) {
          var date_arr = "";
          var newformat = "";
          date_arr = datevalue.split('/');
          if (date_arr.length > 0) {
              newformat = date_arr[1] + '/' + date_arr[0] + '/' + date_arr[2];
          }
          if (datevalue == "") {
              newformat = '';
          }
          return newformat;
      }
  </script>
      <div class="table table-responsive">
      <table id="tblList" class="table table-striped table-hover display dataTable nowrap cell-border cell-border" style="width: 100%">
      </table></div>
</asp:Content>

