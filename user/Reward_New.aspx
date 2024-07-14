<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true" CodeFile="Reward_New.aspx.cs" Inherits="user_Reward_New" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
          <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
      <h4 class="fs-20 font-w600  me-auto">Reward List</h4>
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
         
          $.ajax({

              type: "POST",
              url: pageUrl + '/BindTable',
              data: '{}',
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              success: function (data) {
                  $('#LoaderImg').hide();
                  var json = [];

                  for (var i = 0; i < data.d.length; i++) {

                     
                      json.push([i + 1,
                     
                      
                      data.d[i].Reward,
                          data.d[i].Doe,
                          data.d[i].TStatus == "0" ? '<span style="color: red;">Achieved</span>' :'<span style="color: green;">Given</span>' ,
                          data.d[i].Remarks,
                         

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
                          { title: "Reward" },
                          { title: "Doe" },
                          { title: "Status" },
                          { title: "Remarks" },


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

