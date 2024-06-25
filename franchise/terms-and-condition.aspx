<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="terms-and-condition.aspx.cs" Inherits="terms_and_condition" %>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%-- <button type="button" class="btn btn-primary mb-2" data-bs-toggle="modal" data-bs-target=".bd-example-modal-lg">Large modal</button>--%>

    <%--  <div class="modal fade bd-example-modal-lg" tabindex="-1" style="display: none;" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">--%>
    <div class="modal fade TC_Mode show" tabindex="-1" style="padding-right: 17px; overflow: auto; background: #000000ab;" aria-modal="true" role="dialog">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Terms and Condition</h5>
                    <button type="button" class="btn-close closeBtn" data-bs-dismiss="modal" onclick="closePopup()"></button> 
                </div>
                <div class="modal-body p-0">
                    <%------toppoint------%>
                    <div id="div_toppoint" runat="server" visible="false">
                        <img src="images/toppoint.jpg" alt="" width="100%" />
                        <img src="images/toppoint_1.jpg" alt="" width="100%" />
                    </div>
                    <%------end------%>
                    <%------topcircel------%>
                    <div id="div_topcircel" runat="server" visible="false">
                        <img src="images/topcircel.jpg" alt="" width="100%" />
                        <img src="images/topcircel_1.jpg" alt="" width="100%" />
                    </div>
                    <%------end------%>
                </div>
                <div class="modal-footer">
                    <div class="col-md-8 float-left">
                        <asp:CheckBox ID="chk_tc" runat="server" Text="Please accept Terms &amp; Conditions" />
                        <%--   <span class="txt">Please accept Terms &amp; Conditions  </span>--%>

                         <div class="clearfix"></div>
                        <asp:Label ID="lbl_TcDate" runat="server" style="color:blue;" Font-Bold="true"></asp:Label>

                    </div>
                    <asp:Button ID="btn_Submit" runat="server" Text="Accept" class="btn btn-primary" OnClick="btn_Submit_Click" OnClientClick="return confirm('Are you sure you want to accept？')" />
                     <button type="button" class="btn btn-danger light closeBtn" data-bs-dismiss="modal" onclick="closePopup()">Close</button> 

                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hnd_TCType" runat="server" Value="" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $('.TC_Mode').show();
             
            if ($('#<%=hnd_TCType.ClientID%>').val() == "1") {
                $('.closeBtn').show();
                $('#<%=btn_Submit.ClientID%>').addClass("btn btn-primary");
  
            } else {
                $('.closeBtn').hide();
            } 
        });

        function closePopup() {
            $('.TC_Mode').hide();
        }

    </script>
</asp:Content>
