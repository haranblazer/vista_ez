<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="AdminReward.aspx.cs" Inherits="Admin_AdminReward" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


    <style type="text/css">
        .circle
        {
            font-size: 15px;
            color: darkred;
            line-height: 50px;
            font-weight: bold;
        }
        .style1
        {
            height: 15px;
        }
        .style2
        {
            width: 16%;
            height: 17px;
        }
        .style3
        {
            width: 24%;
            height: 17px;
        }
    </style>
    <br />
    <div id="title" class="b2">
        <h2>Rewards</h2>
        </div>

     <div class="form-group">
            <label for="MainContent_myForm_txtCcode" class="col-sm-2 control-label">
            please Enter user  ID :
             </label>
            <div class="col-sm-3">
             <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            </div><div class="clearfix"></div><br />
             <div class="form-group">
            
            <div class="col-sm-8 pull-right">
            <asp:Button ID="Button1" runat="server" Text="Submit" CssClass="btn btn-success" onclick="Button1_Click" />
            </div>
            </div>


            <div class="clearfix"></div><br />
    <div style="overflow:auto;">
    <asp:GridView ID="GridView2" runat="server"  CssClass="table table-striped table-hover"  Width="100%" AutoGenerateColumns="False"
        CellPadding="4" CellSpacing="1" EmptyDataRowStyle-ForeColor="Red" >

          <Columns>
        <asp:TemplateField HeaderText="Sr.No">
                <ItemTemplate>
                    <%#Container.DataItemIndex+1 %></ItemTemplate>
                <ItemStyle Height="20px" />
            </asp:TemplateField>
            <asp:BoundField DataField="totalearning" HeaderText="Total Amounto" />
            <asp:BoundField DataField="tds" HeaderText=" TDS Amount" />
            <asp:BoundField DataField="handlingcharges" HeaderText="Handling Amount" />
            <asp:BoundField DataField="dispachedamt" HeaderText="Dispatched Amount" />
            
           
       </Columns>

    </asp:GridView>

    </div>

  <%--<table border="0" cellpadding="0" width="100%" cellspacing="0" class="mygrd" style="margin-top: 10px;" id="t1" runat="server">
      <tr>
            <th class="tatoal_ba">
                Total Amount
            </th>
            <th id="Th1" runat="server" class="tatoal_ba">
                TDS Amount
            </th>
            <th class="tatoal_ba">
                Handling Amount
            </th>
            
            <th class="tatoal_ba">
                Dispatched Amount
            </th>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblTotalTotalEarned" runat="server" Text="0" Font-Bold="True"></asp:Label>
            </td>
            <td id="Td1" runat="server">
                <asp:Label ID="lblTotalTdsAmount" runat="server" Text="0" Font-Bold="True"></asp:Label>
            </td>
            <td>
                <asp:Label ID="lblTotalhandlibgCharges" runat="server" Text="0" Font-Bold="True"></asp:Label>
            </td>
           
            <td>
                <asp:Label ID="lblTotalDispatchedAmount" runat="server" Text="0" Font-Bold="True"></asp:Label>
            </td>
        </tr>



    </table>--%>


    <asp:Label ID="Label14" runat="server"></asp:Label>
    
    
    <br />


    <div style="overflow:auto;">

    <asp:GridView CssClass="table table-striped table-hover" ID="GridView1" c runat="server" Width="100%" AutoGenerateColumns="False"
        CellPadding="4" CellSpacing="1" OnRowCommand="GridView1_RowCommand1" EmptyDataRowStyle-ForeColor="Red">
        <Columns>
            <asp:TemplateField HeaderText="Sr.No">
                <ItemTemplate>
                    <%#Container.DataItemIndex+1 %>
                    
               <asp:Label  ID="lbl1" runat="server" Text='<%# Eval("appmstid")%>'></asp:Label>
                    </ItemTemplate>
                <ItemStyle Height="20px" />

              
              
         

            </asp:TemplateField>
          
            <asp:BoundField DataField="payoutno" HeaderText="PayOutNo" />
            <asp:BoundField DataField="Paymenttodate" HeaderText="Payout Date" />
            <asp:BoundField DataField="TotalEarning" HeaderText="Total Earned Amt" />
            <asp:BoundField DataField="tds" HeaderText="TDS" />
            <asp:BoundField DataField="handlingcharges" HeaderText="Handling Charges" />
            
            <asp:BoundField DataField="Dispachedamt" HeaderText="Dispatched Amt" />
            
            <asp:BoundField DataField="paymenttrandraftno" HeaderText="Cheque/Draft No" />
              <asp:TemplateField ItemStyle-Width="30px" HeaderText="Report">
                            <ItemTemplate>

                                <asp:LinkButton ID="LinkButton1"  runat="server" CommandName="PRINT" CommandArgument='<%# Eval("payoutno") %>' CausesValidation="false">Print</asp:LinkButton>

                            </ItemTemplate>
                        </asp:TemplateField>

        </Columns>
    </asp:GridView>
    </div>


     <div style="overflow:auto;">

    <table border="0" cellpadding="0" cellspacing="0" class="table table-striped table-hover" style="width:100%" id="t2" runat="server">
        <tr>
            <th class="style2">ID
            </th>
            <th class="style3">Date of Joining
            </th>
            <th class="style3">Reward Point Left
            </th>
            <th class="style3">Reward Point Right
            </th>
        </tr>
        <tr>
            <td style="width: 16%; text-align: left; height: 18px;">
                <asp:Label ID="lblid" runat="server" Width="28px"></asp:Label>
            </td>
            <td style="width: 24%; text-align: left; height: 18px;">&nbsp;<asp:Label ID="lblDateOfJoining" runat="server"></asp:Label>
            </td>
            <td style="width: 24%; height: 18px; text-align: left">
                <asp:Label ID="lblLeft" runat="server"></asp:Label>
            </td>
            <td style="width: 24%; height: 18px; text-align: left">
                <asp:Label ID="lblRight" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    </div>
    <br />
    <asp:Label ID="lblmsg" runat="server" Font-Bold="True" ForeColor="Red"
        Width="544px"></asp:Label>
    <br />
    <div style="text-align: left;">
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </asp:ToolkitScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
               <%-- <asp:Timer ID="Timer1" runat="server"  OnTick="Timer1_Tick">
                </asp:Timer>--%>
                <asp:Label ID="Label13" runat="server" ForeColor="#6600CC" Font-Bold="true"></asp:Label>
                <%-- <table id="id1" runat="server" style="vertical-align: top; width: 60%;">
                    <tr align="center">
                        <td class="circle" style="width: 250px; text-align:left;">
                            <asp:Label ID="lblTMsg" runat="server"></asp:Label>
                        </td>
                        <td class="circle" style="width: 100px; text-align:left;">Days :
                                    <asp:Label ID="lblDays" runat="server"></asp:Label>
                        </td>
                        <td class="circle" style="width: 100px; text-align:left;">Hours :
                                    <asp:Label ID="lblH" runat="server"></asp:Label>

                        </td>
                        <td class="circle" style="width: 100px; text-align:left;">Min :
                                    <asp:Label ID="lblM" runat="server"></asp:Label>

                        </td>
                        <td class="circle" style="width: 100px; text-align:left;">Sec :
                                    <asp:Label ID="lbls" runat="server"></asp:Label>

                        </td>
                    </tr>
                </table>--%>
                
          
    </div>
                <center>
                    <table border="0" cellpadding="0" cellspacing="0" style="width:100%" id="rwd" class="table table-striped table-hover" runat="server">
                        <tr>
                            <th style="width: 77px; height: 30px;">
                                <span style="font-size: 11pt; text-decoration: underline">Sr&nbsp;No.</span>
                            </th>
                            <th style="width: 296px; height: 30px;">
                                <span style="font-size: 11pt; text-decoration: underline">Fast Track</span>
                            </th>
                            <th style="width: 336px; height: 30px;">
                                <span style="font-size: 11pt; text-decoration: underline">Time (Days)</span>
                            </th>
                            <th style="width: 344px; height: 30px">
                                <span style="font-size: 11pt; text-decoration: underline">Bonus</span>
                            </th>
                            <th style="width: 175px; height: 30px;">
                                <span style="font-size: 11pt; text-decoration: underline"></span>
                            </th>
                            <th style="width: 344px; height: 30px">
                                <span style="font-size: 11pt; text-decoration: underline">Life Time</span>
                            </th>
                            <th colspan="1" style="height: 30px; width: 344px;">
                                <span style="font-size: 11pt; text-decoration: underline">Comments</span>
                            </th>
                            <th colspan="1" style="height: 30px; width: 344px;">
                                <span style="font-size: 11pt; text-decoration: underline">Status</span>
                            </th>
                        </tr>
                        <tr>
                            <td style="height: 65px; width: 77px;">1
                            </td>
                            <td style="height: 65px; width: 296px;">40
                            </td>
                            <td style="height: 65px; width: 336px;">90 days
                            </td>
                            <td style="width: 344px; height: 65px">Rs.10000/-for     
                    <br />
                                Digital Camera 
                            </td>
                            <td style="width: 175px; text-align: center; height: 65px;">&nbsp;
                    <asp:Image ID="imgDVDPlayer" runat="server" ImageUrl="~/Reward/1.png" />
                            </td>
                            <td style="width: 344px; height: 65px">60
                            </td>
                            <td style="height: 65px; text-align: left;">&nbsp;<asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="DarkRed"></asp:Label>
                            </td>
                            <td style="height: 65px; text-align: center;">&nbsp;<asp:Label ID="lblDVDPlayer" runat="server" Font-Bold="True" ForeColor="Black"></asp:Label>
                            </td>
                        </tr>
                        <tr class="altrow">
                            <td style="height: 65px; width: 77px;">2
                            </td>
                            <td style="height: 65px; width: 296px;">Next 75
                            </td>
                            <td style="height: 65px; width: 336px;">120 Days
                            </td>
                            <td style="width: 344px; height: 65px">Rs.20000/-    for  
                    <br />
                                Laptop
                            </td>
                            <td style="width: 175px; text-align: center; height: 65px;">
                                <asp:Image ID="imgDigitalCamera" runat="server" ImageUrl="~/Reward/2.png" />
                                &nbsp;
                            </td>
                            <td style="width: 344px; height: 65px">Next 100
                            </td>
                            <td style="height: 65px; text-align: left;">&nbsp;<asp:Label ID="Label2" runat="server" Font-Bold="True" ForeColor="DarkRed"></asp:Label>
                            </td>
                            <td style="height: 65px; text-align: center;">
                                <asp:Label ID="lblDigitalCamera" runat="server" Font-Bold="True" ForeColor="Black"></asp:Label>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 65px; width: 77px;">3
                            </td>
                            <td style="height: 65px; width: 296px;">Next 100
                            </td>
                            <td style="height: 65px; width: 336px;">150 days
                            </td>
                            <td style="width: 344px; height: 65px">Rs.35000/-    for  
                    <br />
                                Bike
                            </td>
                            <td style="width: 175px; text-align: center; height: 65px;">&nbsp;<asp:Image ID="imgRefrigrator" runat="server" ImageUrl="~/Reward/3.png" />
                            </td>
                            <td style="width: 344px; height: 65px">Next 130
                            </td>
                            <td style="height: 65px; text-align: left;">&nbsp;<asp:Label ID="Label3" runat="server" Font-Bold="True" ForeColor="DarkRed"></asp:Label>
                            </td>
                            <td style="height: 65px; text-align: center;">&nbsp;
                    <asp:Label ID="lblRefrigrator" runat="server" Font-Bold="True" ForeColor="Black"></asp:Label>
                            </td>
                        </tr>
                        <tr class="altrow">
                            <td style="height: 65px; width: 77px;">4
                            </td>
                            <td style="height: 65px; width: 296px;">Next 325
                            </td>
                            <td style="height: 65px; width: 336px;">180 days
                            </td>
                            <td style="width: 344px; height: 65px">Rs.230000/- for 
                    Hyundai EON
                            </td>
                            <td style="width: 175px; text-align: center; height: 65px;">
                                <asp:Image ID="imgLaptop" runat="server" ImageUrl="~/Reward/4.png" />
                            </td>
                            <td style="width: 344px; height: 65px">Next 500 + International Tour
                            </td>
                            <td style="height: 65px; text-align: left;">&nbsp;<asp:Label ID="Label4" runat="server" Font-Bold="True" ForeColor="DarkRed"></asp:Label>
                            </td>
                            <td style="height: 65px; text-align: center;">
                                <asp:Label ID="lblLaptop" runat="server" Font-Bold="True" ForeColor="Black"></asp:Label>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 65px; width: 77px;">5
                            </td>
                            <td style="height: 65px; width: 296px;">Next 750
                            </td>
                            <td style="height: 65px; width: 336px;">210 days
                            </td>
                            <td style="width: 344px; height: 65px">Rs.350000/-    for  
                    <br />
                                Wagon R
                            </td>
                            <td style="width: 175px; text-align: center; height: 65px;">
                                <asp:Image ID="imgBike" runat="server" ImageUrl="~/Reward/5.png" />
                            </td>
                            <td style="width: 344px; height: 65px">Next 1250 + International Tour
                            </td>
                            <td style="height: 65px; text-align: left;">&nbsp;<asp:Label ID="Label5" runat="server" Font-Bold="True" ForeColor="DarkRed"></asp:Label>
                            </td>
                            <td style="height: 65px; text-align: center;">
                                <asp:Label ID="lblBike" runat="server" Font-Bold="True" ForeColor="Black"></asp:Label>
                            </td>
                        </tr>
                        <tr class="altrow">
                            <td style="height: 65px; width: 77px;">6
                            </td>
                            <td style="height: 65px; width: 296px;">Next 1500
                            </td>
                            <td style="height: 65px; width: 336px;">365 days
                            </td>
                            <td style="width: 344px; height: 65px">Rs.500000/-    for  
                    <br />
                                Swift
                            </td>
                            <td style="width: 175px; text-align: center; height: 65px;">
                                <asp:Image ID="imgNanoCar" runat="server" ImageUrl="~/Reward/6.png" />
                            </td>
                            <td style="width: 344px; height: 65px">Next 2250 + International Tour
                            </td>
                            <td style="height: 65px; text-align: left;">&nbsp;<asp:Label ID="Label6" runat="server" Font-Bold="True" ForeColor="DarkRed"></asp:Label>
                            </td>
                            <td style="height: 65px; text-align: center;">
                                <asp:Label ID="lblNanoCar" runat="server" Font-Bold="True" ForeColor="Black" Height="11px"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 65px; width: 77px;">7
                            </td>
                            <td style="height: 65px; width: 296px;">Next 3250
                            </td>
                            <td style="height: 65px; width: 336px;">540 days
                            </td>
                            <td style="width: 344px; height: 65px">Rs.750000/-for 
Honda City
                            </td>
                            <td style="width: 175px; text-align: center; height: 65px;">
                                <asp:Image ID="imgAltoSparkCar" runat="server" ImageUrl="~/Reward/7.png" />
                            </td>
                            <td style="width: 344px; height: 65px">Next 4500 + International Tour for Couple
                            </td>
                            <td style="height: 65px; text-align: left;">&nbsp;<asp:Label ID="Label7" runat="server" Font-Bold="True" ForeColor="DarkRed"></asp:Label>
                            </td>
                            <td style="height: 65px; text-align: center;">&nbsp;
                    <asp:Label ID="lblAltoSparkCar" runat="server" Font-Bold="True" ForeColor="Black"></asp:Label>
                            </td>
                        </tr>
                        <tr class="altrow">
                            <td style="height: 65px; width: 77px;">8
                            </td>
                            <td style="height: 65px; width: 296px;">Next 9000
                            </td>
                            <td style="height: 65px; width: 336px;">N/A
                            </td>
                            <td style="width: 344px; height: 65px">Rs.25 Lac for 
BMW
                            </td>
                            <td style="width: 175px; text-align: center; height: 65px;">
                                <asp:Image ID="imgSwift" runat="server" ImageUrl="~/Reward/8.png" />
                            </td>
                            <td style="width: 344px; height: 65px">Next 9000 + International Tour for Couple
                            </td>
                            <td style="height: 65px; text-align: left;">&nbsp;<asp:Label ID="Label8" runat="server" Font-Bold="True" ForeColor="DarkRed"></asp:Label>
                            </td>
                            <td style="height: 65px; text-align: center;">
                                <asp:Label ID="lblSwift" runat="server" Font-Bold="True" ForeColor="Black"></asp:Label>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 65px; width: 77px;">9
                            </td>
                            <td style="height: 65px; width: 296px;">Next 20000
                            </td>
                            <td style="height: 65px; width: 336px;">N/A
                            </td>
                            <td style="width: 344px; height: 65px">Rs.51 Lac for 
Audi
                            </td>
                            <td style="width: 175px; height: 65px;">
                                <asp:Image ID="imgSkoda" runat="server" ImageUrl="~/Reward/9.png" />
                            </td>
                            <td style="width: 344px; height: 65px">Next 20000 + International Tour for Couple
                            </td>
                            <td style="height: 65px; text-align: left;">&nbsp;<asp:Label ID="Label9" runat="server" Font-Bold="True" ForeColor="DarkRed"></asp:Label>
                            </td>
                            <td style="height: 65px; text-align: center;">
                                <asp:Label ID="lblSkoda" runat="server" Font-Bold="True" ForeColor="Black"></asp:Label>
                            </td>
                        </tr>
                        <tr class="altrow">
                            <td style="height: 65px; width: 77px;">10
                            </td>
                            <td style="height: 65px; width: 296px;">Next 50000
                            </td>
                            <td style="height: 65px; width: 336px;">N/A
                            </td>
                            <td style="width: 344px; height: 65px">Rs.75 Lac for 
Villa
                            </td>
                            <td style="width: 175px; text-align: center; height: 65px;">&nbsp;<asp:Image ID="imgMerceces" runat="server" ImageUrl="~/Reward/10.png" />
                            </td>
                            <td style="width: 344px; height: 65px">Next 50000  + International Tour for Couple
                            </td>
                            <td style="height: 65px; text-align: left;">&nbsp;<asp:Label ID="Label10" runat="server" Font-Bold="True" ForeColor="DarkRed"></asp:Label>
                            </td>
                            <td style="height: 65px; text-align: center;">
                                <asp:Label ID="lblMerceces" runat="server" Font-Bold="True" ForeColor="Black" Height="11px"></asp:Label>
                            </td>
                        </tr>
                        <tr class="altrow">
                            <td style="width: 77px; height: 65px">11
                            </td>
                            <td style="width: 296px; height: 65px">Next 90000
                            </td>
                            <td style="width: 336px; height: 65px">N/A
                            </td>
                            <td style="width: 344px; height: 65px">Rs.1 Cr for 
                    <br />
                                Bungalow
                            </td>
                            <td style="width: 175px; height: 65px; text-align: center">
                                <asp:Image ID="imgCash" runat="server" ImageUrl="~/Reward/11.png" />
                            </td>
                            <td style="width: 344px; height: 65px">Next 90000  + International Tour for Couple
                            </td>
                            <td style="height: 65px; text-align: left;">&nbsp;<asp:Label ID="Label11" runat="server" Font-Bold="True" ForeColor="DarkRed"></asp:Label>
                            </td>
                            <td style="height: 65px; text-align: center">
                                <asp:Label ID="lblCash" runat="server" Font-Bold="True" ForeColor="Black" Height="11px"></asp:Label>
                            </td>
                        </tr>

                    </table>
                    <br />
                    
                    <br />
                    <table border="0" cellpadding="0" cellspacing="0" class="table table-striped table-hover" style="width:100%" id="t3"  runat="server">
                       
                    <h1>International Tour</h1>
                        <tr>
                            <th style="width: 77px; height: 30px;">
                                <span style="font-size: 11pt; text-decoration: underline">Sr&nbsp;No.</span>
                            </th>
                            <th style="width: 296px; height: 30px;">
                                <span style="font-size: 11pt; text-decoration: underline">Fast Track</span>
                            </th>
                            <th style="width: 336px; height: 30px;">
                                <span style="font-size: 11pt; text-decoration: underline">Time (Days)</span>
                            </th>
                            <th style="width: 344px; height: 30px">
                                <span style="font-size: 11pt; text-decoration: underline">Bonus</span>
                            </th>
                            <th style="width: 175px; height: 30px;">
                                <span style="font-size: 11pt; text-decoration: underline"></span>
                            </th>
                            <th style="width: 344px; height: 30px">
                                <span style="font-size: 11pt; text-decoration: underline">Life Time</span>
                            </th>
                            <th colspan="1" style="height: 30px; width: 344px;">
                                <span style="font-size: 11pt; text-decoration: underline">Comments</span>
                            </th>
                            <th colspan="1" style="height: 30px; width: 344px;">
                                <span style="font-size: 11pt; text-decoration: underline">Status</span>
                            </th>
                        </tr>

                        <tr class="altrow">
                            <td style="height: 65px; width: 77px;">12
                            </td>
                            <td style="height: 65px; width: 296px;">85 Tour Points 
                            </td>
                            <td style="height: 65px; width: 336px;">4 months
                            </td>
                            <td style="width: 344px; height: 65px">4 Nights All Expense Paid Trip to Thailand
                            </td>
                            <td style="width: 175px; text-align: center; height: 65px;">&nbsp;<asp:Image ID="Image1" runat="server" ImageUrl="~/Reward/12.png" />
                            </td>
                            <td style="width: 344px; height: 65px">N/A
                            </td>
                            <td style="height: 65px; text-align: center;">&nbsp;<asp:Label ID="Label12" runat="server" Font-Bold="True" ForeColor="Black"></asp:Label>
                            </td>
                            <td style="height: 65px; text-align: center;">
                                <asp:Label ID="lblthailand" runat="server" Font-Bold="True" ForeColor="Black" Height="16px"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </center>
            </ContentTemplate>
        </asp:UpdatePanel>
</asp:Content>

