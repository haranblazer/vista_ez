<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPage.master"
    CodeFile="UpgradePin.aspx.cs" Inherits="admin_UpgradePin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script language="javascript" type="text/javascript">

        function CallVal() {
            var str = document.getElementById("<%=txtid.ClientID%>").value;
            ServerSendValue(str, "ctx");
        }
        function ServerResult(arg) {
            if (arg == "You cannot leave blank field here !") {
                document.getElementById("<%=lblUser.ClientID%>").style.color = "Red";
                document.getElementById("<%=lblUser.ClientID%>").innerHTML = arg;
            }
            else {
                document.getElementById("<%=lblUser.ClientID%>").style.color = "Maroon";
                document.getElementById("<%=lblUser.ClientID%>").innerHTML = arg;
            }
        }
        function ClientErrorCallback() {

        }

    
    </script>

    <script type="text/javascript">

        $(document).ready(function() {
            var dataUserID = document.getElementById("<%=divUserID.ClientID%>").innerHTML.split(",");
            $('#<%=txtid.ClientID %>').autocomplete(dataUserID);
        });
         
    </script>

    <div id="title" class="b2">
        <h2>
            Upgrade Pins</h2>
        <!-- TitleActions -->
        <!-- /TitleActions -->
    </div>
   
        <table style="width: 100%;">
            <tr>
                <td class="top_table" style="text-align: right">
                    Pin No:
                </td>
                <td class="top_table">
                    <asp:TextBox ID="pinno" runat="server" ValidationGroup="p" ReadOnly="True" BackColor="#E0E0E0"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="bottom_table" style="text-align: right">
                    User ID:
                </td>
                <td class="bottom_table">
                    <asp:TextBox ID="txtid" runat="server" onblur="return CallVal();" onfocus="hide();"
                        ValidationGroup="p"></asp:TextBox><asp:Label ID="lblUser" runat="server" Font-Names="Arial"
                            Font-Size="Small" ForeColor="Black"></asp:Label>
                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtid"
                        Display="Dynamic" ErrorMessage="Please Enter Id!" Font-Names="Arial" Font-Size="10pt"
                        ForeColor="#C00000" ValidationGroup="prv" Width="255px"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr id="trProduct" runat="server">
                <td style="text-align: right">
                    Select Product
                </td>
                <td>
                    <asp:DropDownList ID="ddlProduct" runat="server" OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged"
                        AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                        ControlToValidate="ddlProduct" Display="Dynamic" ErrorMessage="Select product." 
                        Font-Names="Arial" Font-Size="10pt" ForeColor="#C00000" InitialValue="0" 
                        ValidationGroup="prv" Width="255px"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr id="trAmount" runat="server">
                <td class="top_table" style="text-align: right">
                    Amount:
                </td>
                <td class="top_table">
                    <asp:TextBox ID="txtAmount" runat="server" Enabled="false"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtAmount"
                        Display="Dynamic" ErrorMessage="Please Enter Amount!" ForeColor="#C00000" ValidationGroup="prv"
                        Width="125px"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtAmount"
                        ErrorMessage="Only Numeric Value Is Allowed ! " ForeColor="#C00000" ValidationExpression="^[0-9]*"
                        ValidationGroup="prv" Width="237px" Display="Dynamic"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="bottom_table" style="text-align: right">
                    Number Of Pins :
                </td>
                <td class="bottom_table">
                    <asp:TextBox ID="txtNOP" runat="server" onfocus="hide();"></asp:TextBox>&nbsp;&nbsp;
                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtNOP"
                        Display="Dynamic" ErrorMessage="Please No Of Pins!" Font-Names="Arial" Font-Size="10pt"
                        ForeColor="#C00000" ValidationGroup="prv" Width="122px"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                            ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtNOP" ErrorMessage="Only Numeric Value Is Allowed ! "
                            Font-Names="Arial" Font-Size="Small" ForeColor="#C00000" ValidationExpression="^[0-9]*"
                            ValidationGroup="prv" Width="195px" Display="Dynamic"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="bottom_table" style="text-align: right; height: 26px;">
                    <span>Pin Type:</span>
                </td>
                <td class="bottom_table" style="height: 26px">
                    <asp:DropDownList ID="ddlPinType" runat="server">
                        <asp:ListItem Value="1">Joining</asp:ListItem>
                        <%-- <asp:ListItem Value="2">Top Up</asp:ListItem>--%>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="bottom_table" style="text-align: right">
                    Paid&nbsp; Status
                </td>
                <td class="bottom_table">
                    <asp:DropDownList ID="ddlPaidStatus" runat="server">
                        <asp:ListItem Value="1">Paid</asp:ListItem>
                        <asp:ListItem Value="2">Un Paid</asp:ListItem>
                        <asp:ListItem Value="3">Zero Pin</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr id="Tr1" runat="server" visible="false">
                <td class="top_table" style="text-align: right">
                    Plan Type:
                </td>
                <td class="top_table">
                    <asp:DropDownList ID="DDlplan1Type" runat="server">
                        <asp:ListItem Value="1">Plan A</asp:ListItem>
                        <asp:ListItem Value="2">Plan B</asp:ListItem>
                        <asp:ListItem Value="3">Plan C</asp:ListItem>
                        <asp:ListItem Value="4">Plan D</asp:ListItem>
                        <asp:ListItem Value="5">Plan E</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="bottom_table" style="text-align: right">
                    Mode:
                </td>
                <td class="bottom_table">
                    <asp:DropDownList ID="ddlMode" runat="server" Width="153px" OnSelectedIndexChanged="ddlMode_SelectedIndexChanged"
                        AutoPostBack="True">
                        <asp:ListItem Value="0">--Select Mode--</asp:ListItem>
                        <asp:ListItem Value="Cash">Cash</asp:ListItem>
                        <asp:ListItem Value="Cheque">Cheque</asp:ListItem>
                        <asp:ListItem Value="DD">DD</asp:ListItem>
                        <asp:ListItem Value="Transfer">Transfer</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="bottom_table" style="text-align: right">
                    Cheque Number / DD No / Transfer Id.:
                </td>
                <td class="bottom_table">
                    <asp:TextBox ID="txtTransactionNumber" runat="server" ValidationGroup="p"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtTransactionNumber"
                        Display="Dynamic" ErrorMessage="Only Numeric Value Is Allowed ! " ForeColor="#C00000"
                        ValidationExpression="^[0-9]*" ValidationGroup="prv" Width="199px"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="top_table" style="text-align: right">
                    Bank:
                </td>
                <td class="top_table">
                    <asp:DropDownList ID="ddlBankName" runat="server" Width="182px">
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
                </td>
            </tr>
            <tr>
                <td class="bottom_table" style="text-align: right">
                    Branch:
                </td>
                <td class="bottom_table">
                    <asp:TextBox ID="txtBranch" runat="server" ValidationGroup="p"></asp:TextBox><br />
                </td>
            </tr>
            <tr>
                <td class="top_table" style="text-align: right">
                    Deposited Amount:
                </td>
                <td class="top_table">
                    <asp:TextBox ID="txtDepositedAmount" runat="server" ValidationGroup="p"></asp:TextBox>&nbsp;
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtDepositedAmount"
                        Display="Dynamic" ErrorMessage="Only  Numeric Value Is Allowed ! " ForeColor="#C00000"
                        ValidationExpression="^[0-9]*" ValidationGroup="prv" Width="202px">Only  Numeric Value Is Allowed ! </asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="bottom_table" style="text-align: right">
                    Remark :
                </td>
                <td class="bottom_table">
                    <asp:TextBox ID="txtRemark" runat="server" ValidationGroup="p" Height="55px" TextMode="MultiLine"></asp:TextBox>
                    <br />
                </td>
            </tr>
            <tr>
                <td class="alignr" style="width: 220px">
                    &nbsp;
                </td>
                <td style="text-align: left;">
                    <asp:Button ID="Button2" runat="server" OnClick="Button1_Click" Text="Submit" ValidationGroup="prv"
                        CssClass="btn" />
                </td>
            </tr>
        </table>
 
    <div id="divUserID" style="display: none;" runat="server">
    </div>

  

</asp:Content>
