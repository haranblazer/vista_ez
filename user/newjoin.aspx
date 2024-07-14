<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master" EnableEventValidation="true" ValidateRequest="true" CodeFile="newjoin.aspx.cs" Inherits="newjoin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        @media (min-width: 320px) {
            .col-xs-4 {
                width: 20% !important;
            }

            .col-xs-8 {
                width: 80% !important;
            }

            .col-md-3 {
                width: 100% !important;
            }
        }

        @media only screen and (min-width: 1240px) {
            .col-md-3 {
                width: 100% !important;
            }

            .col-md-4 {
                width: 16.66667% !important;
            }

            .col-md-5 {
                width: 41.66667% !important;
            }

            .cvt_rs {
                height: auto;
                width: 1170px !important;
            }

            .panel-default > .panel-heading {
                background: #f27632;
                border: none;
                color: #fff; /* font-weight: bold; */
                padding: 10px;
                font-size: 18px;
            }
        }

        .button {
            background: #0F4076 !important;
            border: none;
            padding: 10px 25px 10px 25px !important;
            color: #FFF;
            box-shadow: 1px 1px 5px #B6B6B6;
            border-radius: 3px;
            text-shadow: 1px 1px 1px #9E3F3F;
            cursor: pointer !important;
            font-size: 18px;
        }
    </style>
    <section class="parallax parallax__md" data-mobile="true" data-speed="1">
            <ul class="rslides">
                <li><img src="images/021.jpg" alt="Toptime Slide 3"></li>
            </ul>
        </section>
    <section class="parallax parallax__md">
            <div class="row no-margin-top bg-toptime-blue">
                <div class="col-lg-12 no-margin-top">
                    <div class="" style="padding:15px;">
                        <h4 class="white center"><span>Agent Registration</span></h4>
                    </div>
                </div>
            </div>
        </section>
    <br />
    <div class="container-fluid cvt_rs">
        <div class="col-lg-12 col-md-12">
            <div class="row">
                <div class="panel panel-default" style="background: #fff;">
                    <div class="col-md-6">
                        <div class="form-group" style="padding-top: 15px;">
                            <div class="col-md-3">
                                <label>Sponsor Id <span style="color: Red">*</span></label> <span id="lbl_sponsorname" runat="server"></span>
                            </div>
                                <div class="col-md-7">
                                <asp:TextBox ID="txt_SponsorId" runat="server" CssClass="form-control" onchange="GetSponsorName();"
                                    placeholder="Enter Your Sponsor Id" MaxLength="30"></asp:TextBox>
                                
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group" style="padding-top: 15px;">
                            <div class="col-md-3">
                                <label>Position <span style="color: Red">*</span></label>
                            </div>
                            <div class="col-md-7">
                                <asp:DropDownList ID="ddlposition" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="0">Left</asp:ListItem>
                                    <asp:ListItem Value="1">Right</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="col-md-6">
                        <div class="form-group row" style="padding-top: 15px;">
                            <div class="col-md-3">
                                <label>
                                    User Name <span style="color: Red">*</span></label>
                            </div>
                           
                            <div class="col-md-2 col-xs-4" style="padding-right: 0px;">
                                <asp:DropDownList ID="ddlTitle" runat="server" CausesValidation="True" CssClass="form-control"
                                    maxlength="30" ValidationGroup="NJ" Style="padding: 0px 0px 0px 10px !important;">
                                    <asp:ListItem>Mr.</asp:ListItem>
                                    <asp:ListItem>Ms.</asp:ListItem>
                                    <asp:ListItem>Mrs.</asp:ListItem>
                                    <asp:ListItem>M/S.</asp:ListItem>
                                    <asp:ListItem>Dr.</asp:ListItem>
                                    <asp:ListItem>Md.</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-5 col-xs-8">
                                <asp:TextBox ID="TxtName" runat="server" CssClass="form-control" MaxLength="50" placeholder="Enter Your Name "></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <div class="form-group row" style="padding-top: 15px;">
                            <div class="col-md-3">
                                <label>Father Name <span style="color: Red">*</span></label>
                            </div>
                           
                            <div class="col-md-2 col-xs-4" style="padding-right: 0px;">
                                <asp:DropDownList ID="ddlGtitle" runat="server" CssClass="form-control" Style="padding: 0px 0px 0px 10px !important;">
                                    <asp:ListItem Value="0">S/O</asp:ListItem>
                                    <asp:ListItem Value="1">D/O</asp:ListItem>
                                    <asp:ListItem Value="2">W/O</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-5 col-xs-8">
                                <asp:TextBox ID="txtGName" runat="server" MaxLength="50" CssClass="form-control"
                                    placeholder="Enter Your Father Name "></asp:TextBox>
                            </div>
                        </div>
                    </div>
                     <div class="clearfix"></div>
                    <div class="col-md-6">
                        <div class="form-group" style="padding-top: 15px;">
                            <div class="col-md-3">
                                <label>
                                    State <span style="color: Red">*</span></label>
                            </div>
                            <div class="col-md-7">
                                <asp:DropDownList ID="DdlState" runat="server" CssClass="form-control">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                   
                    <div class="col-md-6">
                        <div class="form-group" style="padding-top: 15px;">
                            <div class="col-md-3">
                                <label>Mobile<span style="color: Red">*</span></label>
                            </div>
                            <div class="col-md-7">
                                <asp:TextBox ID="Txt_Mobile" runat="server" CssClass="form-control" placeholder="Enter Your Mobile Number"
                                    MaxLength="10"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                     <div class="clearfix"></div>

                    <div class="col-md-6">
                        <div class="form-group" style="padding-top: 15px;">
                            <div class="col-md-3">
                                <label>
                                    Email&nbsp;Id <span style="color: Red">*</span></label>
                            </div>
                            <div class="col-md-7">
                                <asp:TextBox ID="txt_Email" runat="server" CssClass="form-control" MaxLength="50"
                                    placeholder="Enter Your Email"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                   
                    <div class="col-md-6">
                        <div class="form-group" style="padding-top: 15px;">
                            <div class="col-md-3">
                                <label>Password <span style="color: Red">*</span></label>
                            </div>
                            <div class="col-md-7">
                                <asp:TextBox ID="TxtPassword" runat="server" CssClass="form-control" MaxLength="15"
                                    TextMode="Password" placeholder="Enter Your Password"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                     <div class="clearfix"></div>

                    <div class="col-md-6">
                        <div class="form-group" style="padding-top: 15px;">
                            <div class="col-md-3">
                            </div>
                            <div class="col-md-7">
                                <asp:CheckBox ID="CheckBox1" runat="server" />
                                <span class="txt">Please accept <a class="txt" href="#" target="_blank"
                                    style="color: #551e00; text-align: justify;">Terms &amp; Conditions </a></span>
                                <div class="clearfix">
                                </div>
                                <br />
                                <input type="button" value="Submit" onclick="Validation();" class="button" />
                                <asp:Label ID="LblMsg" runat="server" ForeColor="Red"></asp:Label>
                            </div>
                        </div>
                    </div>
                     <div class="clearfix"></div>
                    <div class="form-group">
                        <br />
                        <div class="col-md-12" style="height: 150px; overflow-x: auto;">
                            <h5>Terms & Conditions
                            </h5>
                            <p>
                                These Terms and Conditions are to be read together with the IBD Application (Form- the "Application").They become binding if and when Toptime, in its sole discretion, accepts the Application pursuant to Clause 2 here in and Section 3 of the Rules of Conduct for Toptime Distributors (the "Rules of Conduct" or the "Rules").
                            </p>
                            <h5>1.Definitions:</h5>

                            <p>
                                (a) Cooling Off Period: shall, subject to Clause 9, mean a period of 90 days from the date of acceptance of this IBD application by Toptime within which period any new IBD/Distributor shall be entitled to terminate this Contract without penalty and be entitled to refund of price of products or materials purchased from Toptime franchisee as per section 4.2 of rules of Conduct, upon return of such products or materials in saleable condition.
                            </p>
                            <p>
                                (b) IBD: shall mean a person appointed by Toptime on a principal-to-principal basis through this IBD Contract to undertake sale, distribution and marketing of Toptime products and services and to register Preferred Customers within the Territory. A Toptime IBD may introduce or sponsor further levels of IBDs and support them to build their direct selling business of Toptime goods & services.
                            </p>
                            <p>
                                (c) IBD Contract: in accordance with Rule 2.1 of the Toptime Rules of Conduct shall mean and include the following: i. The IBD Application Form; ii. These Terms and Conditions forming part of the IBD Application; iii. The Toptime Business Plan; iv. The Rules of Conduct for Toptime Distributors; v. The Toptime Refund Policy; and vi. The Quality Assurance Standards; as amended from time to time. Toptime may notify any such amendments on its website, www.toptimenet.com.
                            </p>
                            <p>
                                (d) Saleable: shall mean marketable, unused, not expired, not seasonal, discontinued or special promotional products and/services.
                            </p>
                            <p>
                                (e) Territory: shall mean the Republic of India.
                            </p>
                            <p>
                                (f) Effective Date: shall mean the date of submission of the duly filled IBD Application, subject to Approval by Toptime Network Pvt. Ltd.
                            </p>
                            <p>
                                2.Distributorship / Direct Selling. Toptime appoints, as of the Effective Date, the individual(s) identified in the above IBD Application, or if applicable, the legal entity listed therein (the "Entity"), as a IBD of Toptime Products and services, and the Applicant(s) (here in after individually or collectively referred to as the "IBD or Distributor") agree(s) to such appointment. As of the Effective Date and upon receipt of ordering information and completion of any required formalities, the Distributor may, on a non-exclusive basis, within the Territory as may be communicated by Toptime, and otherwise in accordance with the IBD Contract, purchase Toptime Products from Toptime in order to sell, distribute and market the same, and also register Preferred Customers.
                            </p>
                            <p>
                                3.Duration: This IBD Contract, shall remain valid and continue to remain in full force unless terminated earlier by either Party with or without cause as given herein below in Clause 9.
                            </p>
                            <p>
                                4.No Employment Relationship: The Distributor hereby confirms that he/she/they has or have entered into this IBD Contract as an independent contractor. Nothing in the IBD Contract shall establish either an employment relationship or any other labour relationship between the Parties or a right for the Distributor to act as a procurer, broker, commercial agent, contracting representative or other representative of Toptime. When purchasing and selling Toptime Products, the Distributor shall operate as an independent vendor, acting in his/her/their own name, at his/her/their own responsibility and for his/her/their own account.
                            </p>
                            <p>
                                5.No Assignment: This IBD Contract is intuitu personae entered into on a personal basis, and neither this IBD Contract nor any of the rights or obligations of the IBD/Distributor arising here under may be assigned or transferred without the prior written consent of Toptime.
                            </p>
                            <p>
                                6.Representative(s): The Co-Applicant/Authorized Representative(s) acknowledge(s) that Toptime will deal exclusively with the Primary Applicant/First Authorized Representative in respect of all Toptime Business matters, and also pay commissions and/or any other incentives to and in the name of the Primary Applicant/Entity only.
                            </p>
                            <p>
                                7.Payments and Bank Accounts: Toptime will make all payments on account of commissions, discounts, returns or refunds etc. through bank transfer in favour of the Primary Applicant/Entity only as per the details provided in the IBD Application or as may be updated by the Primary Applicant/Entity in writing from time to time. The bank account must be opened and operated in full compliance with Indian law.
                            </p>
                            <p>
                                8.Obligations of IBDs: (a.)The Distributor shall not sell any Toptime Product for a price exceeding the Maximum Retail Price mentioned on the labels of the Toptime products. (b.)The Distributor shall, throughout the validity of this IBD Contract, strictly adhere to all applicable laws, regulations and other legal obligations that affect the operation of his/her/their business. The Distributor shall be responsible for obtaining any applicable registration, license, approval or authorization, a copy of which shall be provided to Toptime upon request. (c.)IBDs for Toptime shall: i. always carry their identity card and not visit the consumer’s premises without prior appointment / approval; ii. truthfully and clearly identify themselves and state the purpose of solicitation to the prospective consumer and state the identity of Toptime, provide complete explanation and demonstration as well as description of the nature of products and services being offered for sale, provide details of prices, terms of payment, return policies, after-sales service, complaint redressal mechanism etc.; iii. provide a bill and receipt to the consumer for orders placed; iv. subject to applicable legal requirements, maintain proper books of accounts in prescribed forms; (d.)IBDs for Toptime shall not: i. use misleading, deceptive or unfair trade practices for sale or recruitment of prospective IBDs; ii. require or encourage other Toptime IBDs to purchase Toptime products or services in unreasonably large quantities; iii. provide any literature and/or training material, not restricted to collateral issued by Toptime, to a prospective and/or existing IBD which have not been approved by Toptime; iv. require prospective or existing IBDs to purchase any literature or training material or sales demonstration equipment. v. strictly adhere to, inter alia, the Toptime Rules of Conduct for Toptime IBDs.
                            </p>
                            <p>
                                9.Termination of the IBD Contract. The IBD may without assigning any reason, after giving written notice to Toptime terminate this Contract with immediate effect and this contract would be terminated automatically. An IBD shall not be entitled to purchase Toptime products or services upon serving the notice. In addition to the above: (a.) Toptime may terminate this IBD Contract forthwith in case: i. the IBD violates the provisions of the Rules of Conduct; ii. for reasons of non-performance of sales of Toptime products and services as per the targets defined from time to time, if any,; iii. for the breach of any provision hereof including but not limited to non-compliance to Rule 4 of the Toptime Rules of Conduct; iv. for the breach of Direct Selling guidelines published by the Government of India or any State Government; v. due to misrepresentation by the IBD to any consumer or prospective IBD; or vi. due to legal, regulatory or other developments that require material operational changes within the Territory, in which case Toptime may, if regulatory conditions allow, endeavour to restructure the contractual relationship with the IBD on such terms and conditions as are then practical and legally permissible. (b.) Toptime shall also have the right to terminate this contract by giving 30 days’ notice in writing if the IBD fails to make any purchase or sale of Toptime products or services for a consecutive period exceeding 12 months. Toptime may from time to time amend any of the documents comprising the IBD Contract through notice on its website, www.toptimenet.com. If the Distributor does not agree to be bound by such amendment(s), he/she/they may terminate the IBD Contract with immediate effect by giving a written notice to Toptime. Otherwise, the Distributor's continued relationship with Toptime constitutes an affirmative acknowledgment by the Distributor of the amendment(s), and his/her/their agreement to be bound by the same.
                            </p>
                            <p>
                                10.Severability. If any provision of these Terms and Conditions is declared invalid or unenforceable, the remaining provisions shall remain in full force and effect.
                            </p>
                            <p>
                                11.Governing Law. The IBD Contract and all questions of its interpretation shall be governed by and construed in accordance with the laws of the Republic of India, without regard to its principles of conflicts of laws. The Agreement is civil in nature and hence, it is to be governed and construed in accordance with the Indian Contract Act, 1872, the Code of Civil Procedure and other applicable laws of India.
                            </p>
                            12.Dispute Settlement. The parties shall endeavour to settle any dispute or difference arising out of or in connection with the IBD Contract through mutual discussions within 30 days of such dispute arising. The IBD agrees that in the event it is not satisfied by any decision of Toptime , or in the event that any issue raised by the IBD has remained unresolved for a period of more than two months, and / or during the subsistence of this agreement or upon or after its termination, any issue or dispute that the IBD may have regarding the interpretation or operation of the clauses of this arrangement or any issues arising there from shall be referred to Grievance Redressal Committee set up by the company. Any dispute, difference or claim remaining unresolved post reference to the Grievance Redressal committee discussions shall be submitted to binding arbitration under the provisions of the Indian Arbitration and Conciliation Act, 1996. The venue of such arbitration shall be at Mumbai and the award of the Arbitrator shall be final and binding on all Parties. Subject to the above, courts at Mumbai shall alone have jurisdiction in relation to the IBD Contract and matters connected here to.
</p><p>
    13.Limitation on Liability. Toptime's liability, whether in contractor otherwise, arising out of or in connection with this IBD Contract shall not exceed the less of:(a)actual damages or loss assessed by the arbitrator or any other dispute resolution mechanism adopted by the Parties, or;(b) the total commission earned by the Distributor during the six-month period preceding the date of the dispute.
                            </p>
                        </div>
                    </div>

                    <div class="clearfix">
                    </div>
                    <br />
                </div>
            </div>
        </div>
    </div>
    <br />
    <%-- <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>--%>
    <script type="text/javascript">
        var URL = "newjoin.aspx";
        $(function () {

            $('#<%=txt_SponsorId.ClientID %>').keypress(function (e) {
                if (e.which != 8 && e.which != 0 && (e.which < 65 || e.which > 90) && (e.which < 90 || e.which > 122) && (e.which < 48 || e.which > 57)) { return false; }
                if (e.which == 91 || e.which == 93 || e.which == 94 || e.which == 95 || e.which == 96) { return false; }
            });

            $('#<%=TxtName.ClientID %>').keypress(function (e) {
                if ((e.which >= 65 && e.which <= 90) || (e.which >= 97 && e.which <= 122) || (e.which == 32)) { return true; } else { return false; }
                if (e.which == 91 || e.which == 93 || e.which == 94 || e.which == 95 || e.which == 96) { return false; }
            });
            $('#<%=txtGName.ClientID %>').keypress(function (e) {
                if ((e.which >= 65 && e.which <= 90) || (e.which >= 97 && e.which <= 122) || (e.which == 32)) { return true; } else { return false; }
                if (e.which == 91 || e.which == 93 || e.which == 94 || e.which == 95 || e.which == 96) { return false; }
            });

            $('#<%=txt_Email.ClientID %>').keypress(function (e) {
                if ((e.which >= 65 && e.which <= 90) || (e.which >= 97 && e.which <= 122) || (e.which >= 48 && e.which <= 57) || (e.which == 46) || (e.which == 64) || (e.which == 95)) { return true; } else { return false; }
            });

            $('#<%=Txt_Mobile.ClientID%>').keypress(function (e) {
                if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) { return false; }
            });

            if ($('#<%=txt_SponsorId.ClientID%>').val() != '') {
                GetSponsorName();
            }

        });


        function Validation() {
            debugger;
            var SponsorId = $('#<%=txt_SponsorId.ClientID%>').val(), 
                Position = $('#<%=ddlposition.ClientID%>').val(),
                Title = $('#<%=ddlTitle.ClientID%>').val(),
                Name = $('#<%=TxtName.ClientID%>').val(),
                state = $('#<%=DdlState.ClientID%> option:selected').text(),
                Gtitle = $('#<%=ddlGtitle.ClientID%>').val(),
                GName = $('#<%=txtGName.ClientID%>').val(),
                Mobile = $('#<%=Txt_Mobile.ClientID%>').val(),
                Email = $('#<%=txt_Email.ClientID%>').val(),
                Password = $('#<%=TxtPassword.ClientID%>').val();

            var MSG = "";
            if (SponsorId == "") {
                MSG += "\n Please Enter Sponsor Id.!!";
            }

            if (Name == "") {
                MSG += "\n Please Enter User Name.!!";
            }

            if (GName == "") {
                MSG += "\n Please Enter Father Name.!!";
            }

            if (state == "") {
                MSG += "\n Please Select User State.!!";
            }

            if (Email == "") {
                MSG += "\n Please Enter Email Id.!!";
            }
            else if (!isValidEmailAddress(Email)) {
                MSG += "\n Please Enter Valid Email Id!!";
            }

            if (Password == "") {
                MSG += "\n Please Enter Password.!!";
            }
            else if (Password != "") {
                if (Password.length < 5)
                    MSG += "\n Password Length Can Be Minimum Of 5 Character.!!";
            }

            if ($('#<%=CheckBox1.ClientID%>').is(':checked') == false) {
                MSG += "\n Please select Terms & Conditions.!!";
            }

            if (MSG != "") {
                alert(MSG);
                return false;
            }
            if (!confirm('Are you sure you want to save your details？')) {
                return false;
            }

            $('#<%=LblMsg.ClientID%>').text("Please wait ..... While your request is being processed.");
            $('#<%=LblMsg.ClientID%>').css('color', 'blue');
            $.ajax({
                type: "POST",
                url: URL + '/UserRegistration',
                data: '{SponsorId: "' + SponsorId + '", Position: "' + Position + '",  Title: "' + Title + '", Name: "' + Name + '", state: "' + state + '", Gtitle: "' + Gtitle
                + '", GName: "' + GName + '", Mobile: "' + Mobile + '", Email: "' + Email + '", Password: "' + Password + '", epassword: "' + Password + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (data.d.Error == "") {
                        $('#<%=LblMsg.ClientID%>').text("");
                        $('#<%=txt_SponsorId.ClientID%>').val('');
                        $('#<%=TxtName.ClientID%>').val('');
                        $('#<%=DdlState.ClientID%>').val(0);
                        $('#<%=txtGName.ClientID%>').val('');
                        $('#<%=Txt_Mobile.ClientID%>').val('');
                        $('#<%=txt_Email.ClientID%>').val('');
                        $('#<%=TxtPassword.ClientID%>').val('');
                        $('#<%=CheckBox1.ClientID%>').attr('checked', false);
                        window.location = "Thanks.aspx?i=" + data.d.Regno + "&n=" + data.d.Name + "&sid=" + data.d.Sponsorid
                            + "&mob=" + data.d.Mobile + "&em=" + data.d.Email + "&pass=" + data.d.Password;
                        return true;
                    }
                    else {
                        $('#<%=LblMsg.ClientID%>').text(data.d.Error);
                        $('#<%=LblMsg.ClientID%>').css('color', 'red');
                        return false;
                    }
                },
                error: function (response) {
                    $('#<%=LblMsg.ClientID%>').text("Server error. Time out.!!");
                    $('#<%=LblMsg.ClientID%>').css('color', 'red');
                }
            });


        }

        function isValidEmailAddress(emailAddress) {
            var pattern = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i);
            return pattern.test(emailAddress);
        };


        function GetSponsorName() {
            var SponsorId = $('#<%=txt_SponsorId.ClientID%>').val();
            if (SponsorId != "") {
                $.ajax({
                    type: "POST",
                    url: URL + '/GetSponsorName',
                    data: '{SponsorId: "' + SponsorId + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            $('#<%=lbl_sponsorname.ClientID%>').text(data.d);
                            $('#<%=lbl_sponsorname.ClientID%>').css("color", "blue");
                        }
                        else {
                            $('#<%=txt_SponsorId.ClientID%>').val('');
                            $('#<%=lbl_sponsorname.ClientID%>').text(SponsorId + " Sponsor not exists.");
                            $('#<%=lbl_sponsorname.ClientID%>').css("color", "red");
                        }

                    },
                    error: function (response) {
                        $('#<%=lbl_sponsorname.ClientID%>').text("");
                    }
                });
            }
        }
    </script>
</asp:Content>
