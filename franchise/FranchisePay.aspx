<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true" CodeFile="FranchisePay.aspx.cs" Inherits="franchise_FranchisePay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<script language="javascript" type="text/javascript">
    function CallVal(txt) {
        ServerSendValue(txt.value, "ctx");
    }
    function ServerResult(arg) {

        if (arg == "You cannot leave blank field here !") {
            document.getElementById("lblUser.ClientID").style.color = "Red";
            document.getElementById("lblUser.ClientID").innerHTML = arg;
        }
        else {
            document.getElementById("<%=lblUser.ClientID%>").style.color = "darkblue";
            document.getElementById("<%=lblUser.ClientID%>").innerHTML = arg;
        }
    }
    function ClientErrorCallback() {
    }
    </script>


      <asp:TextBox ID="txtid" runat="server" onchange="return CallVal(this);" onfocus="hide();"
                        ValidationGroup="p" Text="Enter ID"></asp:TextBox><asp:Label ID="lblUser" runat="server" Font-Names="Arial"
                            Font-Size="Small" ForeColor="Black"></asp:Label>
                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtid"
                        Display="Dynamic" ErrorMessage="Please Enter Id!" Font-Names="Arial" Font-Size="10pt"
                        ForeColor="#C00000" ValidationGroup="prv" Width="255px"></asp:RequiredFieldValidator>
            

        <div class="form-group">
             <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
               Mode:
                   </label>
                   <div class="col-sm-3">
                    <asp:DropDownList ID="ddlMode" runat="server" CssClass="form-control"  OnSelectedIndexChanged="ddlMode_SelectedIndexChanged"
                        AutoPostBack="True">
                        <asp:ListItem Value="0">--Select Mode--</asp:ListItem>
                        <asp:ListItem Value="Cash">Cash</asp:ListItem>
                        <asp:ListItem Value="Cheque">Cheque</asp:ListItem>
                        <asp:ListItem Value="DD">DD</asp:ListItem>
                        <asp:ListItem Value="Transfer">Transfer</asp:ListItem>
                    </asp:DropDownList>
                   </div>
                   </div>
                   <div class="clearfix"></div><br />
                   <div class="form-group">
             <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
              Cheque Number / DD No / Transfer Id.:
                   </label>
                   <div class="col-sm-3">
                    <asp:TextBox ID="txtTransactionNumber" CssClass="form-control" runat="server" ValidationGroup="p"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtTransactionNumber"
                        Display="Dynamic" ErrorMessage="Only Numeric Value Is Allowed ! " ForeColor="#C00000"
                        ValidationExpression="^[0-9]*" ValidationGroup="prv" Width="199px"></asp:RegularExpressionValidator>
                   </div>
                   </div>
                   <div class="clearfix" ></div><br />
                   <div class="form-group">
             <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
             Bank:
                   </label>
                   <div class="col-sm-3">
                   <asp:DropDownList ID="ddlBankName" runat="server" CssClass="form-control" >
                        <asp:ListItem Value="0">--Select Bank--</asp:ListItem>
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
                        <asp:ListItem Value="KARNATAKA BANK LTD<">KARNATAKA BANK LTD</asp:ListItem>
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
                        <asp:ListItem Value="THE JAMMU AND KASHMIR BANK LTD<">THE JAMMU AND KASHMIR BANK LTD</asp:ListItem>
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
                   <div class="clearfix"></div><br />
                    <div class="form-group">
             <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
           Branch:
                   </label>
                   <div class="col-sm-3">
                    <asp:TextBox ID="txtBranch" CssClass="form-control" runat="server" ValidationGroup="p"></asp:TextBox>
                   </div>
                   </div>
                   <div class="clearfix"></div><br />
                    <div class="form-group">
             <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
             Deposited Amount:
                   </label>
                   <div class="col-sm-3">
                    <asp:TextBox ID="txtDepositedAmount" CssClass="form-control" runat="server" ValidationGroup="p"></asp:TextBox>&nbsp;
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtDepositedAmount"
                        Display="Dynamic" ErrorMessage="Only  Numeric Value Is Allowed ! " ForeColor="#C00000"
                        ValidationExpression="^[0-9]*" ValidationGroup="prv" Width="202px">Only  Numeric Value Is Allowed ! </asp:RegularExpressionValidator>
                   </div>
                   </div>
               <div class="clearfix"></div>
                   <div class="form-group">
             <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
             Remark:
                   </label>
                   <div class="col-sm-3">
                   <asp:TextBox ID="txtRemark" runat="server" ValidationGroup="p" CssClass="form-control" Height="55px" TextMode="MultiLine"></asp:TextBox>
                   </div>
                   </div>
                   <div class="clearfix"></div><br />
                    <div class="form-group">             
                   <div class="col-sm-8 pull-right">
                     <asp:Button ID="Button2" runat="server" OnClick="Button1_Click" Text="Submit" ValidationGroup="prv"
                        CssClass="btn btn-success ladda-button" />
                   </div>
                   </div>   

         <div id="divUserID" style="display: none;" runat="server">
    </div>
</asp:Content>

