<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="UploadTDS.aspx.cs"
    EnableEventValidation="false" Inherits="secretadmin_UploadTDS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">TDS CSV file upload</h4>					
				</div>

   
                <div class="form-group">
                    <label class="col-sm-12 control-label">
                        <span style="color: Red">Note : <span style="color: Red">Only CSV file allowed</span></span>
                    </label>
              
                    <div class="col-md-4">
                        <a href="images/TDSCSVFormat.csv" class="btn btn-primary">CSV File Format &nbsp; <i class="fa fa-download" style="font-size:16px; color:white"></i></a>
                    </div>
                </div>
                <div class="clearfix">
                </div><br />
                <div class="form-group">
                    <label class="col-sm-2 control-label">
                        Upload CSV File 
                    </label>
                    <div class="col-md-4">
                        <asp:FileUpload ID="FileUpload1" runat="server" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="FileUpload1"
                            SetFocusOnError="true" Display="None" ErrorMessage="Only  csv files are allowed !!!"
                            Font-Size="10pt" ForeColor="#C00000" ValidationExpression="(.*\.([cC][sS][vV])$)"
                            ValidationGroup="C"></asp:RegularExpressionValidator>
                        <asp:ValidationSummary ID="ValidationSummary3" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="C" HeaderText="Please Check the following..." />
                    </div>

                </div>
                <div class="clearfix">
                </div><br />

                <div class="form-group">
                    <label class="col-sm-2 control-label">
                    </label>
                    <div class="col-md-4">
                     

                        <asp:Button ID="btnbulkcopy" runat="server" Text="Upload" ValidationGroup="C" CssClass="btn btn-primary" 
                            OnClick="btnbulkcopy_Click" OnClientClick="javascript:return Validation();"/>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="UploadTDS.aspx" class="btn btn-danger">Reset</a>
                           <br />
                        <asp:Label ID="lbl_Msg" runat="server" ForeColor="Green"></asp:Label>
                    </div>

                </div>
                <div class="clearfix">
                </div>
                <br />
        
            <div class="form-group">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="true" CssClass="table table-hover mygrd"
                    Width="100%" EmptyDataText="No Data Found">
                </asp:GridView>
            </div>

            <div class="clearfix">
            </div>
     
        <script type="text/javascript">

            function Validation() {
                var file = $('input[type=file]').val();

                var MSG = "";
                
                if (!file) {
                    MSG += "\n Please Select CSV File !!!";
                }
                if (MSG != "") {
                    alert(MSG);
                    return false;
                }
                if (!confirm('Are you sure you want to upload this file.？')) {
                    return false;
                }
            }
           </script>
</asp:Content>

