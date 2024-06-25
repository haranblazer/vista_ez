<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="TransporterList.aspx.cs" 
    Inherits="franchise_TransporterList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
       <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Transporter List</h4>					
				</div>
    
   
            <div class="col-sm-1">
               <%-- <asp:ImageButton ID="imgbtnExcel" runat="server" ImageUrl="images/excel.gif" OnClick="imgbtnExcel_Click" Width="25px" />--%>
            </div>
     
        
        <div class="table-responsive">

             <table id="tblList" class="table table-striped table-hover display" style="width: 100%"></table>

          <%--  <asp:GridView ID="dglst" runat="server" AllowPaging="True" CellPadding="1" CssClass="table table-striped table-hover" AutoGenerateColumns="false"
                Font-Names="Arial" Font-Size="Small" PageSize="500" EmptyDataText="No Record Found." ShowFooter="true"
                OnPageIndexChanging="dglst_PageIndexChanging">
                <Columns>
                    <asp:TemplateField HeaderText="SNo">
                        <ItemTemplate><%#Container.DataItemIndex+1%> </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="TransporterName" HeaderText="Transporter Name" />
                    <asp:BoundField DataField="ContactPerson" HeaderText="Contact Person" />
                    <asp:BoundField DataField="MobileNo" HeaderText="Mobile No" />
                    <asp:BoundField DataField="Emailid" HeaderText="Email Id" />

                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate><%# Eval("Isactive").ToString() == "1" ? "<span class='dotGreen'></span>" : "<span class='dotGrey'></span>"%></ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Transport Mode">
                        <ItemTemplate><%#Eval("RoleMode") %> </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="State" HeaderText="State" />
                    <asp:BoundField DataField="District" HeaderText="District" />
                    <asp:BoundField DataField="Pincode" HeaderText="Pincode" />
                    <asp:BoundField DataField="Address" HeaderText="Address" />


                    <asp:BoundField DataField="GSTNO" HeaderText="GST" />

                    <asp:BoundField DataField="Freight" HeaderText="Freight" />
                    <asp:BoundField DataField="FuelCharges" HeaderText="Fuel Charges" />
                    <asp:BoundField DataField="FOVChages" HeaderText="FOV Charges" />
                    <asp:BoundField DataField="DocketCharges" HeaderText="Docket Charges" />
                    <asp:BoundField DataField="HandlingCharges" HeaderText="Handling Charges" />
                    <asp:BoundField DataField="ODA" HeaderText="ODA" />
                    <asp:BoundField DataField="OtherChages" HeaderText="Other Charges" />
                     <asp:HyperLinkField DataNavigateUrlFields="Tid" HeaderText="Action" ControlStyle-CssClass="fa fa-edit"
                      ItemStyle-HorizontalAlign="Center" DataNavigateUrlFormatString="Add_Transporter.aspx?id={0}" />
                </Columns>
            </asp:GridView>--%>
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
        var pageUrl = '<%=ResolveUrl("TransporterList.aspx")%>';
        $JDT(function () {
            BindTable();
        });


        function BindTable() { 
            $.ajax({
                type: "POST",
                url: pageUrl + '/BindTable',
                //data: '{ min: "' + min + '", max: "' + max + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var json = [];

                    for (var i = 0; i < data.d.length; i++) {
                        var Action = '<a style="color:blue;" href="Add_Transporter.aspx?id=' + data.d[i].Tid + '">Edit</a>';

                        json.push([i + 1,
                            data.d[i].TransporterName,
                            data.d[i].ContactPerson,
                            data.d[i].MobileNo,
                            data.d[i].Emailid,
                            data.d[i].Isactive == "1" ? "<span class='dotGreen'></span>" : "<span class='dotGrey'></span>",
                            data.d[i].RoleMode,
                            data.d[i].State,
                            data.d[i].District, 
                            data.d[i].Pincode,
                            data.d[i].Address,
                            data.d[i].GSTNO,
                            data.d[i].Freight,
                            data.d[i].FuelCharges,
                            data.d[i].FOVChages,
                            data.d[i].DocketCharges,
                            data.d[i].HandlingCharges,
                            data.d[i].ODA,
                            data.d[i].OtherChages,
                            Action,
                        ]);
                    }

                    $JDT('#tblList').DataTable({
                        dom: 'Blfrtip',
                        scrollY: "500px",
                        scrollX: true,
                        scrollCollapse: true,
                        buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
                        data: json,
                        columns: [
                            { title: "SNo" },
                            
                            { title: "Transporter Name" },
                            { title: "Contact Person" },
                            { title: "Mobile No" },
                            { title: "Email Id" },
                            { title: "Status" },
                            { title: "Transport Mode" },
                            { title: "State" },
                            { title: "District" },
                            { title: "Pincode" },
                            { title: "Address" },
                            { title: "GST" },

                            { title: "Freight" },
                            { title: "Fuel Charges" },
                            { title: "FOV Charges" },
                            { title: "Docket Charges" },
                            { title: "Handling Charges" },
                            { title: "ODA" },
                            { title: "Other Charges" },
                             { title: "Action" },
                            
                        ],
                        "lengthMenu": [[5, 10, 15, 25, 50, 100, -1], [5, 10, 15, 25, 50, 100, "All"]],
                        "pageLength": 15,
                        "bDestroy": true, 
                    });
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
 
    </script>


    <style>
        .dotGreen {
            height: 20px;
            width: 20px;
            background-color: #569c49;
            display: inline-block;
            border-radius: 50%;
        }

        .dotGrey {
            height: 20px;
            width: 20px;
            background-color: #ec8380;
            display: inline-block;
            border-radius: 50%;
        }
    </style>

</asp:Content>

