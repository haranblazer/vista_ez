<%@ Page Title="Wallet Request" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="WalletRequest.aspx.cs" Inherits="user_WalletRequest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        input[type="radio"]
        {
            background-color: #FFFF99;
            color: Navy;
        }
    </style>
    <style type="text/css">
        table tr td
        {
                padding: 3px 5px;
    color: #333333;
    white-space: nowrap;
        }
        label
        {
            color: #333;
        }
        tr:nth-child(odd) {
    background-color: #ffffff;
    box-shadow: none;
    border: none;
}
    </style>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
    <script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="datepick/jquery.datepick.js" type="text/javascript"></script>
    <script type="text/javascript">
        $.noConflict();
        jQuery(document).ready(function ($) {
            $('#<%=txtDate.ClientID%>').datepick({ dateFormat: 'dd/mm/yyyy' });
        });
    </script>
    <script type="text/javascript">
        function Transaction() {
            debugger;
            var rb = document.getElementById("<%=rbtnlstMode.ClientID%>");
            var radio = rb.getElementsByTagName("input");
            var label = rb.getElementsByTagName("label");
            for (var i = 0; i < radio.length; i++) {
                if (radio[i].checked) {
                    if (radio[i].value == "CashOffice") {
                        debugger;

                        document.getElementById('<%=txtAmount.ClientID %>').readOnly = false;
                        document.getElementById('<%=txtAmount.ClientID %>').style.backgroundColor = 'white';
                        document.getElementById('<%=txtDate.ClientID %>').readOnly = false;
                        document.getElementById('<%=txtDate.ClientID %>').style.backgroundColor = 'white';
                        $("#vali").hide();

                        document.getElementById('<%=ddlCompanybank.ClientID %>').selectedIndex = 0;
                        document.getElementById('<%=ddlCompanybank.ClientID %>').disabled = true;
                        document.getElementById('<%=ddlCompanybank.ClientID %>').style.backgroundColor = "#c8c9ca";

                        document.getElementById('<%=txtUserAccNo.ClientID %>').readOnly = true;
                        document.getElementById('<%=txtUserAccNo.ClientID %>').style.backgroundColor = "#c8c9ca";
                        document.getElementById('<%=ddlUserbank.ClientID %>').selectedIndex = 0;
                        document.getElementById('<%=ddlUserbank.ClientID %>').disabled = true;
                        document.getElementById('<%=ddlUserbank.ClientID %>').style.backgroundColor = "#c8c9ca";
                        document.getElementById('<%=txtTransactionNumber.ClientID %>').style.backgroundColor = "#c8c9ca";
                        document.getElementById('<%=txtTransactionNumber.ClientID %>').readOnly = true;
                    }
                    if (radio[i].value == "CashBank") {
                        document.getElementById('<%=txtAmount.ClientID %>').readOnly = false;
                        document.getElementById('<%=txtAmount.ClientID %>').style.backgroundColor = 'white';
                        document.getElementById('<%=txtDate.ClientID %>').readOnly = false;
                        document.getElementById('<%=txtDate.ClientID %>').style.backgroundColor = 'white';


                        document.getElementById('<%=ddlCompanybank.ClientID %>').selectedIndex = 0;
                        document.getElementById('<%=ddlCompanybank.ClientID %>').disabled = false;
                        document.getElementById('<%=ddlCompanybank.ClientID %>').style.backgroundColor = 'white';

                        document.getElementById('<%=txtUserAccNo.ClientID %>').readOnly = true;
                        document.getElementById('<%=txtUserAccNo.ClientID %>').style.backgroundColor = "#c8c9ca";
                        document.getElementById('<%=ddlUserbank.ClientID %>').selectedIndex = 0;
                        document.getElementById('<%=ddlUserbank.ClientID %>').disabled = true;
                        document.getElementById('<%=ddlUserbank.ClientID %>').style.backgroundColor = "#c8c9ca";
                        document.getElementById('<%=txtTransactionNumber.ClientID %>').style.backgroundColor = "#c8c9ca";
                        document.getElementById('<%=txtTransactionNumber.ClientID %>').readOnly = true;
                    }
                    if (radio[i] == "Cheque" || radio[i] == "NEFT") {
                        document.getElementById('<%=txtAmount.ClientID %>').readOnly = false;
                        document.getElementById('<%=txtAmount.ClientID %>').style.backgroundColor = 'white';
                        document.getElementById('<%=txtDate.ClientID %>').readOnly = false;
                        document.getElementById('<%=txtDate.ClientID %>').style.backgroundColor = 'white';


                        document.getElementById('<%=ddlCompanybank.ClientID %>').selectedIndex = 0;
                        document.getElementById('<%=ddlCompanybank.ClientID %>').disabled = false;
                        document.getElementById('<%=ddlCompanybank.ClientID %>').style.backgroundColor = 'white';

                        document.getElementById('<%=txtUserAccNo.ClientID %>').readOnly = true;
                        document.getElementById('<%=txtUserAccNo.ClientID %>').style.backgroundColor = 'white';
                        document.getElementById('<%=ddlUserbank.ClientID %>').selectedIndex = 0;
                        document.getElementById('<%=ddlUserbank.ClientID %>').disabled = false;
                        document.getElementById('<%=ddlUserbank.ClientID %>').style.backgroundColor = 'white';
                        document.getElementById('<%=txtTransactionNumber.ClientID %>').style.backgroundColor = 'white';
                        document.getElementById('<%=txtTransactionNumber.ClientID %>').readOnly = false;
                    }
                    else {
                        document.getElementById('<%=txtAmount.ClientID %>').readOnly = false;
                        document.getElementById('<%=txtAmount.ClientID %>').style.backgroundColor = 'white';
                        document.getElementById('<%=txtDate.ClientID %>').readOnly = false;
                        document.getElementById('<%=txtDate.ClientID %>').style.backgroundColor = 'white';

                        document.getElementById('<%=ddlCompanybank.ClientID %>').selectedIndex = 0;
                        document.getElementById('<%=ddlCompanybank.ClientID %>').disabled = false;
                        document.getElementById('<%=ddlCompanybank.ClientID %>').style.backgroundColor = 'white';

                        document.getElementById('<%=txtUserAccNo.ClientID %>').readOnly = true;
                        document.getElementById('<%=txtUserAccNo.ClientID %>').style.backgroundColor = 'white';
                        document.getElementById('<%=ddlUserbank.ClientID %>').selectedIndex = 0;
                        document.getElementById('<%=ddlUserbank.ClientID %>').disabled = false;
                        document.getElementById('<%=ddlUserbank.ClientID %>').style.backgroundColor = 'white';
                        document.getElementById('<%=txtTransactionNumber.ClientID %>').style.backgroundColor = 'white';
                        document.getElementById('<%=txtTransactionNumber.ClientID %>').readOnly = false;
                    }
                }
            }

            return false;
        }
    </script>
      <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">Wallet Request</h4>					
				</div>     


            <div id="MainContent_UpdatePanel1">
                <div class="row">
                    <div class="col-md-12">
                        <asp:UpdateProgress ID="updatePro" DynamicLayout="true" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                            <ProgressTemplate>
                                <asp:Image ImageUrl="~/images/loader.gif" runat="server" ID="waitsymbol" Width="30px"
                                    Height="30px" />
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <div id="tblMode" runat="server">
                                    <div class="form-group">
                                        <div class="table-responsive">
                                        <asp:RadioButtonList ID="rbtnlstMode" runat="server" CellPadding="10" Style="font-size: 14px;
                                            color: #000;" RepeatDirection="Horizontal" onchange="Transaction()" OnSelectedIndexChanged="rbtnlstMode_SelectedIndexChanged"
                                            AutoPostBack="True">
                                            <asp:ListItem Value="CashOffice"><font color="black">Cash deposit at office </font></asp:ListItem>
                                            <asp:ListItem Value="CashBank"><font color="black">Cash deposit at bank</font> </asp:ListItem>
                                            <asp:ListItem Value="Cheque"><font color="black">Cheque/Draft</font> </asp:ListItem>
                                            <asp:ListItem Value="NEFT"><font color="black">NEFT/RTGS/UPI </font></asp:ListItem>
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rbtnlstMode"
                                            Display="None" ErrorMessage="please select payment type" ValidationGroup="aa"></asp:RequiredFieldValidator>
                                            </div>
                                    </div>
                                    <div class="form-group card-group-row row">
                                        <div class="col-md-3">
                                            Request Type <span style="color: Red; font-weight: bold;">*</span>
                                        </div>
                                        <div class="col-md-3">
                                            <asp:RadioButtonList ID="rdbtn1" runat="server" RepeatDirection="Horizontal">
                                                <asp:ListItem Value="0" Selected="True"> Wallet Request</asp:ListItem>
                                                <%-- <asp:ListItem Value="1"> Service Load Request</asp:ListItem>--%>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                   
                                    <div class="clearfix">
                                    </div>
                                    <div class="form-group card-group-row row">
                                        <div class="col-md-3">
                                            Wallet<span style="color: Red; font-weight: bold;">*</span>
                                        </div>
                                        <div class="col-md-4">
                                            <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" MaxLength="8"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtAmount"
                                                Display="None" ErrorMessage="Please enter amount" ValidationGroup="aa"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Display="None"
                                                ErrorMessage="Please enter numeric amount" ValidationExpression="^[0-9]*" ValidationGroup="aa"
                                                ControlToValidate="txtAmount"></asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                 
                                    <div class="clearfix">
                                    </div>
                                 
                                    <div class="form-group card-group-row row">
                                        <div class="col-md-3">
                                            Date<span style="color: Red; font-weight: bold;">*</span>
                                        </div>
                                        <div class="col-md-4">
                                            <asp:TextBox ID="txtDate" runat="server" CssClass="form-control"> </asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDate"
                                                Display="None" ErrorMessage="Please enter date " ValidationGroup="aa"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                   
                                    <div class="form-group card-group-row row">
                                        <div class="col-md-3">
                                            Company&#39;s Bank Name
                                        </div>
                                        <div class="col-md-4">
                                            <asp:DropDownList ID="ddlCompanybank" runat="server" CssClass="form-control" TabIndex="10"
                                                AutoPostBack="True" OnSelectedIndexChanged="ddlCompanybank_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                 
                                    <div class="form-group card-group-row row">
                                        <div class="col-md-3">
                                            Company&#39;s Bank A/C No.
                                        </div>
                                        <div class="col-md-4">
                                            <asp:TextBox ID="txt_CompanyAccNo" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                   
                                    <div class="form-group card-group-row row">
                                        <div class="col-md-3">
                                            User&#39;s Bank A/C No.
                                        </div>
                                        <div class="col-md-4">
                                            <asp:TextBox ID="txtUserAccNo" runat="server" CssClass="form-control" MaxLength="20"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                   
                                    <div class="form-group card-group-row row">
                                        <div class="col-md-3">
                                            User&#39;s Bank Name
                                        </div>
                                        <div class="col-md-4">
                                            <asp:DropDownList ID="ddlUserbank" runat="server" CssClass="form-control" TabIndex="10">
                                                <asp:ListItem Value="0">Select Bank</asp:ListItem>
                                                <asp:ListItem Value="ABHYUDAYA CO-OP BANK LTD">ABHYUDAYA CO-OP BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="ABN AMRO BANK">ABN AMRO BANK</asp:ListItem>
                                                <asp:ListItem Value="ABU DHABI COMMERCIAL BANK">ABU DHABI COMMERCIAL BANK</asp:ListItem>
                                                <asp:ListItem Value="AHMEDABAD MERCANTILE CO-OPERATIVE BANK LTD.">AHMEDABAD MERCANTILE CO-OPERATIVE BANK LTD.</asp:ListItem>
                                                <asp:ListItem Value="ALLAHABAD BANK">ALLAHABAD BANK</asp:ListItem>
                                                <asp:ListItem Value="ANDHRA BANK">ANDHRA BANK</asp:ListItem>
                                                <asp:ListItem Value="AXIS BANK">AXIS BANK</asp:ListItem>
                                                <asp:ListItem Value="AXIS BANK LTD">AXIS BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="BANK OF AMERICA">BANK OF AMERICA</asp:ListItem>
                                                <asp:ListItem Value="BANK OF BAHARAIN &amp; KUWAIT BSC">BANK OF BAHARAIN &amp; KUWAIT BSC</asp:ListItem>
                                                <asp:ListItem Value="BANK OF BARODA">BANK OF BARODA</asp:ListItem>
                                                <asp:ListItem Value="BANK OF CEYLON">BANK OF CEYLON</asp:ListItem>
                                                <asp:ListItem Value="BANK OF INDIA">BANK OF INDIA</asp:ListItem>
                                                <asp:ListItem Value="BANK OF MAHARASHTRA">BANK OF MAHARASHTRA</asp:ListItem>
                                                <asp:ListItem Value="BARCLAYS BANK PLC">BARCLAYS BANK PLC</asp:ListItem>
                                                <asp:ListItem Value="BNP PARIBAS">BNP PARIBAS</asp:ListItem>
                                                <asp:ListItem Value="CALYON BANK">CALYON BANK</asp:ListItem>
                                                <asp:ListItem Value="CANARA BANK">CANARA BANK</asp:ListItem>
                                                <asp:ListItem Value="CATHOLIC SYRIAN BANK LTD">CATHOLIC SYRIAN BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="CENTRAL BANK OF INDIA">CENTRAL BANK OF INDIA</asp:ListItem>
                                                <asp:ListItem Value="CHINATRUST COMMERCIAL BANK LTD">CHINATRUST COMMERCIAL BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="CHO HUNG BANK">CHO HUNG BANK</asp:ListItem>
                                                <asp:ListItem Value="CITI BANK N.A">CITI BANK N.A</asp:ListItem>
                                                <asp:ListItem Value="CITIZEN CREDIT CO-OPERATIVE BANK LTD">CITIZEN CREDIT CO-OPERATIVE BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="CITY UNION BANK LTD">CITY UNION BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="CORPORATION BANK">CORPORATION BANK</asp:ListItem>
                                                <asp:ListItem Value="DBS BANK LTD">DBS BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="DENA BANK">DENA BANK</asp:ListItem>
                                                <asp:ListItem Value="DEPOSIT INS AND CR GUAR CORPN">DEPOSIT INS AND CR GUAR CORPN</asp:ListItem>
                                                <asp:ListItem Value="DEUTSCHE BANK">DEUTSCHE BANK</asp:ListItem>
                                                <asp:ListItem Value="DEVELOPMENT CREDIT BANK LIMITED">DEVELOPMENT CREDIT BANK LIMITED</asp:ListItem>
                                                <asp:ListItem Value="DOMBIVLI NAGARI SAHAKARI BANK LIMITED">DOMBIVLI NAGARI SAHAKARI BANK LIMITED</asp:ListItem>
                                                <asp:ListItem Value="HDFC BANK">HDFC BANK</asp:ListItem>
                                                <asp:ListItem Value="HSBC">HSBC</asp:ListItem>
                                                <asp:ListItem Value="ICICI BANK">ICICI BANK</asp:ListItem>
                                                <asp:ListItem Value="INDIAN BANK">INDIAN BANK</asp:ListItem>
                                                <asp:ListItem Value="INDIAN OVERSEAS BANK">INDIAN OVERSEAS BANK</asp:ListItem>
                                                <asp:ListItem Value="INDUSIND BANK LTD">INDUSIND BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="INDUSTRIAL DEVELOPMENT BANK OF INDIA LTD">INDUSTRIAL DEVELOPMENT BANK OF INDIA LTD</asp:ListItem>
                                                <asp:ListItem Value="ING VYSYA BANK LTD">ING VYSYA BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="JANAKALYAN SAHAKARI BANK LTD">JANAKALYAN SAHAKARI BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="JP MORGAN CHASE BANK, N.A.">JP MORGAN CHASE BANK, N.A.</asp:ListItem>
                                                <asp:ListItem Value="KALYAN JANATA SAH BANK LTD">KALYAN JANATA SAH BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="KAPOL CO-OP BANK LTD">KAPOL CO-OP BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="KARNATAKA BANK LTD&lt;">KARNATAKA BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="KARUR VYSYA BANK">KARUR VYSYA BANK</asp:ListItem>
                                                <asp:ListItem Value="KOTAK MAHINDRA BANK">KOTAK MAHINDRA BANK</asp:ListItem>
                                                <asp:ListItem Value="KRUNG THAI BANK PCL">KRUNG THAI BANK PCL</asp:ListItem>
                                                <asp:ListItem Value="LAKSHMI VILAS BANK">LAKSHMI VILAS BANK</asp:ListItem>
                                                <asp:ListItem Value="LORD KRISHNA BANK">LORD KRISHNA BANK</asp:ListItem>
                                                <asp:ListItem Value="MAHARASHTRA STATE CO-OP BANK LTD">MAHARASHTRA STATE CO-OP BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="MANDVI CO-OP BANK LTD">MANDVI CO-OP BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="MASHREQBANK PSC">MASHREQBANK PSC</asp:ListItem>
                                                <asp:ListItem Value="MIZUHO CORPORATE BANK LTD">MIZUHO CORPORATE BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="NEW INDIA CO-OP BANK LTD">NEW INDIA CO-OP BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="NUTAN NAGARIK SAHAKARI BANK LTD">NUTAN NAGARIK SAHAKARI BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="OMAN INTERNATIONAL BANK">OMAN INTERNATIONAL BANK</asp:ListItem>
                                                <asp:ListItem Value="ORIENTAL BANK OF COMMERCE">ORIENTAL BANK OF COMMERCE</asp:ListItem>
                                                <asp:ListItem Value="PARSIK JANATA SAHAKARI BANK LTD">PARSIK JANATA SAHAKARI BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="PUNJAB AND MAHARASHTRA CO-OP BANK LTD">PUNJAB AND MAHARASHTRA CO-OP BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="PUNJAB AND SIND BANK">PUNJAB AND SIND BANK</asp:ListItem>
                                                <asp:ListItem Value="PUNJAB NATIONAL BANK">PUNJAB NATIONAL BANK</asp:ListItem>
                                                <asp:ListItem Value="RAJKOT NAGRIK SAHAKARI BANK LTD">RAJKOT NAGRIK SAHAKARI BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="RESERVE BANK OF INDIA">RESERVE BANK OF INDIA</asp:ListItem>
                                                <asp:ListItem Value="SHINHAN BANK">SHINHAN BANK</asp:ListItem>
                                                <asp:ListItem Value="SOCIETE GENERALE">SOCIETE GENERALE</asp:ListItem>
                                                <asp:ListItem Value="SOUTH INDIAN BANK LTD">SOUTH INDIAN BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="STANDARD CHARTERED BANK">STANDARD CHARTERED BANK</asp:ListItem>
                                                <asp:ListItem Value="STATE BANK OF BIKANER AND JAIPUR">STATE BANK OF BIKANER AND JAIPUR</asp:ListItem>
                                                <asp:ListItem Value="STATE BANK OF HYDERABAD">STATE BANK OF HYDERABAD</asp:ListItem>
                                                <asp:ListItem Value="STATE BANK OF INDIA">STATE BANK OF INDIA</asp:ListItem>
                                                <asp:ListItem Value="STATE BANK OF INDORE">STATE BANK OF INDORE</asp:ListItem>
                                                <asp:ListItem Value="STATE BANK OF MAURITUS">STATE BANK OF MAURITUS</asp:ListItem>
                                                <asp:ListItem Value="STATE BANK OF MYSORE">STATE BANK OF MYSORE</asp:ListItem>
                                                <asp:ListItem Value="STATE BANK OF PATIALA">STATE BANK OF PATIALA</asp:ListItem>
                                                <asp:ListItem Value="STATE BANK OF TRAVANCORE">STATE BANK OF TRAVANCORE</asp:ListItem>
                                                <asp:ListItem Value="SYNDICATE BANK">SYNDICATE BANK</asp:ListItem>
                                                <asp:ListItem Value="TAMILNAD MERCANTILE BANK LTD">TAMILNAD MERCANTILE BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="THANE JANATA SAHKARI BANK LTD">THANE JANATA SAHKARI BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="THE BANK OF NOVA SCOTIA">THE BANK OF NOVA SCOTIA</asp:ListItem>
                                                <asp:ListItem Value="THE BANK OF RAJASTHAN LTD">THE BANK OF RAJASTHAN LTD</asp:ListItem>
                                                <asp:ListItem Value="THE BANK OF TOKYO MITSUBISHI LTD">THE BANK OF TOKYO MITSUBISHI LTD</asp:ListItem>
                                                <asp:ListItem Value="THE BHARAT CO-OPERATIVE BANK LTD">THE BHARAT CO-OPERATIVE BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="THE COSMOS CO-OPERATIVE BANK LTD">THE COSMOS CO-OPERATIVE BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="THE DHANALAKSHMI BANK LTD">THE DHANALAKSHMI BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="THE FEDERAL BANK LTD">THE FEDERAL BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="THE GREATER BOMBAY CO-OP BANK LTD">THE GREATER BOMBAY CO-OP BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="THE JAMMU AND KASHMIR BANK LTD&lt;">THE JAMMU AND KASHMIR BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="THE KALUPUR COMM COOP.BANK LTD">THE KALUPUR COMM COOP.BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="THE NORTH KANARA G.S.B. CO-OP. BANK LTD">THE NORTH KANARA G.S.B. CO-OP. BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="THE RATNAKAR BANK LTD">THE RATNAKAR BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="THE SANGLI BANK LTD">THE SANGLI BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="THE SARASWAT CO-OPERATIVE BANK LTD">THE SARASWAT CO-OPERATIVE BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="THE SHAMRAO VITHAL CO -OPERATIVE BANK LTD">THE SHAMRAO VITHAL CO -OPERATIVE BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="THE TAMIL NADU STATE APEX CO-OPERATIVE BANK LTD">THE TAMIL NADU STATE APEX CO-OPERATIVE BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="UCO BANK">UCO BANK</asp:ListItem>
                                                <asp:ListItem Value="UNION BANK OF INDIA">UNION BANK OF INDIA</asp:ListItem>
                                                <asp:ListItem Value="UNITED BANK OF INDIA">UNITED BANK OF INDIA</asp:ListItem>
                                                <asp:ListItem Value="VIJAYA BANK">VIJAYA BANK</asp:ListItem>
                                                <asp:ListItem Value="WEST BENGAL STATE CO-OP BANK LTD">WEST BENGAL STATE CO-OP BANK LTD</asp:ListItem>
                                                <asp:ListItem Value="YES BANK LTD">YES BANK LTD</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                   
                                    <div class="form-group card-group-row row">
                                        <div class="col-md-3">
                                            Cheque&nbsp;No/&nbsp;DD&nbsp;No/&nbsp;Transaction&nbsp;UTR&nbsp;No&nbsp; <span id="vali" runat="server" style="color: Red; font-weight: bold;">*</span>
                                        </div>
                                         
                                        <div class="col-md-4">
                                            <asp:TextBox ID="txtTransactionNumber" runat="server" CssClass="form-control" TabIndex="9"
                                                ValidationGroup="p" MaxLength="20"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtTransactionNumber"
                                                Display="None" ErrorMessage="Please Enter Transaction number" ValidationGroup="aa"></asp:RequiredFieldValidator>
                                             <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" Display="None"
                                                ErrorMessage="Please enter numeric cheque/DD/UTR no" ValidationExpression="^[0-9A-Za-z]*"
                                                ValidationGroup="aa" ControlToValidate="txtTransactionNumber"></asp:RegularExpressionValidator>
                                        </div>
                                        <div class="col-md-3">
                                           <asp:image id="impPrev" runat="server" height="200px" />
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                   
                                    <div class="form-group card-group-row row">
                                        <div class="col-md-3">
                                            Remarks
                                        </div>
                                        <div class="col-md-4">
                                            <asp:TextBox ID="txt_Remark" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>

                                    <div class="form-group card-group-row row">
                                        <div class="col-md-3">
                                            Upload Slip <span style="color: Red; font-weight: bold;">*</span>
                                        </div>
                                        <div class="col-md-4">
                                             <asp:fileupload id="UploadWalletSlip" runat="server" cssclass="form-control" onchange='ShowPreview(this)' width="250px"></asp:fileupload>
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="UploadWalletSlip"
                                                Display="None" ErrorMessage="Please Upload Image" ValidationGroup="aa"></asp:RequiredFieldValidator>

                                        <asp:regularexpressionvalidator id="revPaymentSlip" runat="server" validationexpression="^.*\.((j|J)(p|P)(e|E)?(g|G)|(g|G)(i|I)(f|F)|(p|P)(n|N)(g|G))$"
                                            setfocusonerror="true" controltovalidate="UploadWalletSlip" errormessage="Only .jpg/.jpeg/.gif/.png file types are allowed."
                                            forecolor="Red" display="Dynamic" validationgroup="aa"></asp:regularexpressionvalidator>
                                            <br />
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                    </div>
                                   
                                    <div class="form-group card-group-row row">
                                        <div class="col-md-3"></div>
                                        <div class="col-md-4">
                                            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" OnClick="btnSubmit_Click"
                                                Text="Submit" ValidationGroup="aa" />
                                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                                                ShowSummary="False" ValidationGroup="aa" />
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                               <Triggers>
                                <asp:PostBackTrigger ControlID = "btnSubmit" />
                                </Triggers>
                        </asp:UpdatePanel>
                        <div class="clearfix">
                        </div>
                        <br />
                   
                        <div class="mws-panel grid_2  " style="-webkit-box-shadow: 10px 10px 5px #888; box-shadow: 10px 10px 5px #888;
                            -webkit-border-radius: 6px; -moz-border-radius: 6px; border-radius: 6px; background-color: #d3d4d6;">
                            <div class="mws-stat-title" style="font-size: 18px; text-align: left; text-overflow: ellipsis;
                                line-height: 24px; padding: 5px 5px; color: #315787; border-bottom: solid 1px #fff;">
                                Wallet Deposit</div>
                            <div class="mws-panel-body no-padding" style="color: #fff;">
                                <div style=" color: #315787">
                                    &nbsp;Send a request for Wallet Amount to admin. The admin will verify your request
                                    and approve, then you can use your online purchase with that Wallet amount.</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
       
 
   <script type="text/javascript">
       function ShowPreview(input) {
           debugger;
           const fi = document.getElementById('<%=UploadWalletSlip.ClientID%>');
           if (fi.files.length > 0) {
                   const fsize = fi.files.item.size;
                   const file = Math.round((fsize / 1024));

                   if (file >= 5096) {
                       alert("File too big,Please select  a file less than 4mb");
                       return;
                   }
                   
           }
           
               if (input.files && input.files[0]) {
                   var ImageDir = new FileReader();
                   ImageDir.onload = function (e) {
                       $('#<%=impPrev.ClientID%>').attr('src', e.target.result);
                   }
                   ImageDir.readAsDataURL(input.files[0]);
               }
           
       }
   </script>

</asp:Content>
