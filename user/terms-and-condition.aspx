<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true" CodeFile="terms-and-condition.aspx.cs" Inherits="user_terms_and_condition" %>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <button type="button" class="btn btn-primary mb-2" data-bs-toggle="modal" data-bs-target=".bd-example-modal-lg">Large modal</button>
    <div class="modal fade bd-example-modal-lg" tabindex="-1" style="display: none;" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Terms and Condition</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-0">
                    <%------toppoint------%>
                    <div>
                    <img src="images/toppoint.jpg" alt="" width="100%" />
                     <img src="images/toppoint_1.jpg" alt="" width="100%" />
                    </div>
                     <%------end------%>
                    <%------topcircel------%>
                    <div class="d-none">
                    <img src="images/topcircel.jpg" alt="" width="100%" />
                     <img src="images/topcircel_1.jpg" alt="" width="100%" />
                    </div>
                     <%------end------%>

                </div>
                <div class="modal-footer">
                    <div class="col-md-8 float-left">
                        <input type="checkbox" />
                        <span class="txt">Please accept Terms &amp; Conditions  </span>
                    </div>
                    <%--<button type="button" class="btn btn-danger light" data-bs-dismiss="modal">Close</button>--%>
                    <button type="button" class="btn btn-primary">Accept</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>