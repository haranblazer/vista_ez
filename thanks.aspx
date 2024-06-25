<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="thanks.aspx.cs" Inherits="user_newjoins" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 <%--<div style="height: 140px; background: #002e9e;">
        <div class="container">
            <div class=" section-header p-4 ">
                <h4 class="text-white m-0 text-left pt-4 mt-2">Thanks</h4>
            </div>
        </div>
    </div>--%>
    <div class="breadcrumb-area">
        <div class="container-fluid">
            <ol class="breadcrumb breadcrumb-list">
                <li class="breadcrumb-item"><a href="default">Home</a></li>
                <li class="breadcrumb-item"><a href="javascript:void(0)">Thanks</a></li>
            </ol>
        </div>
    </div>
   <div class="container">
         <div class="row justify-content-center mtb-10">
        <div class="col-md-6">
             <div class="form-bg box-wrap">
            <table width="100%">
                <tbody>
                   <%-- <tr>
                        <td width="50%" height="100px">
                            <img src="images/logo.png" width="200px" style="margin-top: -15px">
                        </td>
                    </tr>--%>
                    <tr>
                        <td colspan="2">
                            <p style="font-weight: bold; font-size: 25px;">
                               A Big Thank You
                                
                                <br>
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <p><br />
                                <span>Dear</span>
                                <span id="lbl_UsernameHeader" runat="server" style="font-weight:bold;"></span>
                                <br>
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <p>
                                Congratulations and a big thank you for joining us as a founding associate! We're absolutely delighted to have you on our team as we embark on this exciting business venture.

                            </p>

                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <p>
                                <span >Here are your login details:</span>
                                <br>
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span style="font-weight:600;">User ID: </span>
                        </td>
                        <td>
                            <span id="lbl_UserId" runat="server" style="font-weight:600;"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span style="font-weight:600;">Password: </span>
                        </td>
                        <td>
                            <span style="font-weight:600;"">XXXXXXXX </span>
                            <span id="lbl_PWD" runat="server" style="font-weight:600; display:none;"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span style="font-weight:600;">Name: </span>
                        </td>
                        <td>
                            <span id="lbl_UserName" runat="server" style="font-weight:600;"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span style="font-weight:600;">Mobile No: </span>
                        </td>
                        <td>
                            <span id="lbl_Mobile" runat="server" style="font-weight:600;"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span style="font-weight:600;">Email ID: </span>
                        </td>
                        <td>
                            <span id="lbl_Emailid" runat="server" style="font-weight:600;"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span style="font-weight:600;">Sign-Up Date: </span>
                        </td>
                        <td>
                            <span id="lbl_Date" runat="server" style="font-weight:600;"></span>
                        </td>
                    </tr>
                    <%-- <tr>
                        <td colspan="2">
                            <p>
                                If you have any suggestions to improve our services, Please write to us at support@google.com
                            </p>
                        </td>
                    </tr>--%>
                    <tr>
                        <td colspan="2">
                            <span style="font-size: 15px; font-weight: normal;">Thank you once again for choosing to be a part of our journey!
</span>
                        </td>
                    </tr>
                    <tr>
                       <td colspan="2">Best Regards,
<br />
                            For (<span id="lbl_CompanyName" runat="server"></span>)<br />
                        </td>
                    </tr>
                   
                    <tr>
                        <td colspan="2">
                            <p>

                                <span id="lbl_CompanyAddress" runat="server" style="font-size: 15px; font-weight: normal;"></span>
                            </p>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
            </div>
    </div>
         </div>
    <style>
        table td span{
            color: #323232;
    font-size: 16px;
    font-weight: 400;
    line-height: 24px;
    margin-bottom: 0;
        }
        p {
    color: #323232;
    font-size: 16px;
    font-weight: 400;
    line-height: 24px;
    margin-bottom: 0;
}
    </style>

</asp:Content>
