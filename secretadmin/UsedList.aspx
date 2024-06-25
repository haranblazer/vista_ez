<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UsedList.aspx.cs" Inherits="admin_UsedList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <center><table border="0" cellpadding="0" cellspacing="0" style="width: 800px">
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td style="height: 25px; width: 350px;">
            </td>
            <td style="height: 25px; width: 350px;">
            </td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 24px">
            </td>
            <td colspan="2" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                border-left: #000000 1px solid; width: 700px; border-bottom: #000000 1px solid;
                height: 24px; background-color: #2881A2; text-align: center">
                <strong><span style="font-size: 16px; color: #ffffff; font-family: Arial;">Used List</span></strong></td>
            <td style="width: 50px; height: 24px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 350px; height: 35px; background-color: #edf0fd;">
                &nbsp;</td>
            <td style="border-right: #000000 1px solid; width: 350px; height: 35px; text-align: right; background-color: #edf0fd;">
                <span style="font-family: Arial">
                No Of Records&nbsp; :</span> &nbsp;<asp:TextBox ID="txtnorec" runat="server" Width="46px"></asp:TextBox>
                &nbsp;&nbsp;
            </td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td style="border-left: #000000 1px solid; width: 350px; height: 35px; text-align: center; border-bottom: #000000 1px solid; background-color: #edf0fd;">
                <span style="font-family: Arial">
                From&nbsp;</span>
                <asp:DropDownList
                    ID="ddlday1" runat="server" Style="position: relative" Width="53px">
             <asp:ListItem>1</asp:ListItem>
            <asp:ListItem>2</asp:ListItem>
            <asp:ListItem>3</asp:ListItem>
            <asp:ListItem>4</asp:ListItem>
            <asp:ListItem>5</asp:ListItem>
            <asp:ListItem>6</asp:ListItem>
            <asp:ListItem>7</asp:ListItem>
            <asp:ListItem>8</asp:ListItem>
            <asp:ListItem>9</asp:ListItem>
            <asp:ListItem>10</asp:ListItem>
            <asp:ListItem>11</asp:ListItem>
            <asp:ListItem>12</asp:ListItem>
            <asp:ListItem>13</asp:ListItem>
            <asp:ListItem>14</asp:ListItem>
            <asp:ListItem>15</asp:ListItem>
            <asp:ListItem>16</asp:ListItem>
            <asp:ListItem>17</asp:ListItem>
            <asp:ListItem>18</asp:ListItem>
            <asp:ListItem>19</asp:ListItem>
            <asp:ListItem>20</asp:ListItem>
            <asp:ListItem>21</asp:ListItem>
            <asp:ListItem>22</asp:ListItem>
            <asp:ListItem>23</asp:ListItem>
            <asp:ListItem>24</asp:ListItem>
            <asp:ListItem>25</asp:ListItem>
            <asp:ListItem>26</asp:ListItem>
            <asp:ListItem>27</asp:ListItem>
            <asp:ListItem>28</asp:ListItem>
            <asp:ListItem>29</asp:ListItem>
            <asp:ListItem>30</asp:ListItem>
            <asp:ListItem>31</asp:ListItem>
            
                </asp:DropDownList>
                /
                <asp:DropDownList ID="ddlmonth1" runat="server" Style="left: 0px; position: relative;
                    top: 0px" Width="46px">
                <asp:ListItem>1</asp:ListItem>
            <asp:ListItem>2</asp:ListItem>
            <asp:ListItem>3</asp:ListItem>
            <asp:ListItem>4</asp:ListItem>
            <asp:ListItem>5</asp:ListItem>
            <asp:ListItem>6</asp:ListItem>
            <asp:ListItem>7</asp:ListItem>
            <asp:ListItem>8</asp:ListItem>
            <asp:ListItem>9</asp:ListItem>
            <asp:ListItem>10</asp:ListItem>
            <asp:ListItem>11</asp:ListItem>
            <asp:ListItem>12</asp:ListItem>    
                </asp:DropDownList>
                /
                <asp:DropDownList ID="ddlyear1" runat="server" Style="position: relative"
                    Width="68px">
                    <asp:ListItem>2008</asp:ListItem>
              <asp:ListItem>2009</asp:ListItem>
            <asp:ListItem>2010</asp:ListItem>
              <asp:ListItem>2011</asp:ListItem>
            <asp:ListItem>2012</asp:ListItem>
              <asp:ListItem>2013</asp:ListItem>
            <asp:ListItem>2014</asp:ListItem>
              <asp:ListItem>2015</asp:ListItem>
            <asp:ListItem>2016</asp:ListItem>
                    <asp:ListItem>2017</asp:ListItem>
                    <asp:ListItem>2018</asp:ListItem>
                    <asp:ListItem>2019</asp:ListItem>
                    <asp:ListItem>2020</asp:ListItem>
               
                
                
                
                  
                   
                      
                </asp:DropDownList></td>
            <td style="border-right: #000000 1px solid; width: 350px; height: 35px; text-align: center; border-bottom: #000000 1px solid; background-color: #edf0fd;">
                <span style="font-family: Arial">
                To Date</span>
                <asp:DropDownList
                    ID="ddlday" runat="server" Style="position: relative" Width="53px">
                    <asp:ListItem>1</asp:ListItem>
            <asp:ListItem>2</asp:ListItem>
            <asp:ListItem>3</asp:ListItem>
            <asp:ListItem>4</asp:ListItem>
            <asp:ListItem>5</asp:ListItem>
            <asp:ListItem>6</asp:ListItem>
            <asp:ListItem>7</asp:ListItem>
            <asp:ListItem>8</asp:ListItem>
            <asp:ListItem>9</asp:ListItem>
            <asp:ListItem>10</asp:ListItem>
            <asp:ListItem>11</asp:ListItem>
            <asp:ListItem>12</asp:ListItem>
            <asp:ListItem>13</asp:ListItem>
            <asp:ListItem>14</asp:ListItem>
            <asp:ListItem>15</asp:ListItem>
            <asp:ListItem>16</asp:ListItem>
            <asp:ListItem>17</asp:ListItem>
            <asp:ListItem>18</asp:ListItem>
            <asp:ListItem>19</asp:ListItem>
            <asp:ListItem>20</asp:ListItem>
            <asp:ListItem>21</asp:ListItem>
            <asp:ListItem>22</asp:ListItem>
            <asp:ListItem>23</asp:ListItem>
            <asp:ListItem>24</asp:ListItem>
            <asp:ListItem>25</asp:ListItem>
            <asp:ListItem>26</asp:ListItem>
            <asp:ListItem>27</asp:ListItem>
            <asp:ListItem>28</asp:ListItem>
            <asp:ListItem>29</asp:ListItem>
            <asp:ListItem>30</asp:ListItem>
            <asp:ListItem>31</asp:ListItem>
                </asp:DropDownList>
                &nbsp; /
                <asp:DropDownList ID="ddlmonth" runat="server" Style="position: relative"
                    Width="53px">
                       <asp:ListItem>1</asp:ListItem>
            <asp:ListItem>2</asp:ListItem>
            <asp:ListItem>3</asp:ListItem>
            <asp:ListItem>4</asp:ListItem>
            <asp:ListItem>5</asp:ListItem>
            <asp:ListItem>6</asp:ListItem>
            <asp:ListItem>7</asp:ListItem>
            <asp:ListItem>8</asp:ListItem>
            <asp:ListItem>9</asp:ListItem>
            <asp:ListItem>10</asp:ListItem>
            <asp:ListItem>11</asp:ListItem>
            <asp:ListItem>12</asp:ListItem>    
                </asp:DropDownList>
                /
                <asp:DropDownList ID="ddlyear" runat="server" Style="position: relative">
                <asp:ListItem>2008</asp:ListItem>
                    <asp:ListItem>2009</asp:ListItem>
                    <asp:ListItem>2010</asp:ListItem>
                    <asp:ListItem>2011</asp:ListItem>
                    <asp:ListItem>2012</asp:ListItem>
                    <asp:ListItem>2013</asp:ListItem>
                    <asp:ListItem>2014</asp:ListItem>
                    <asp:ListItem>2015</asp:ListItem>
                    <asp:ListItem>2016</asp:ListItem>
                    <asp:ListItem>2017</asp:ListItem>
                    <asp:ListItem>2018</asp:ListItem>
                    <asp:ListItem>2019</asp:ListItem>
                    <asp:ListItem>2020</asp:ListItem>
                </asp:DropDownList></td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td colspan="2" style="height: 25px; text-align: center; border-left-width: 1px; border-left-color: #000000; border-right-width: 1px; border-right-color: #000000;">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Italic="False" ForeColor="Red" Font-Names="Arial" Font-Size="Small"></asp:Label></td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td colspan="2" style="height: 35px; text-align: center; border-left-width: 1px; border-left-color: #000000; border-right-width: 1px; border-right-color: #000000;">
                <asp:Button ID="btnShow" runat="server" Text="Show" Width="61px" OnClick="btnShow_Click1" BackColor="#2881A2" BorderColor="Black" Font-Bold="True" ForeColor="White" /></td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td colspan="2" style="border-right: #000000 1px solid; border-bottom: #000000 1px solid; border-left: #000000 1px solid;
                height: 25px; text-align: center; border-top: #000000 1px solid;" valign="top">
                <asp:GridView ID="dgrd" runat="server" AllowPaging="True" CellPadding="4" Font-Names="Arial"
                    Font-Size="Small" ForeColor="#333333" GridLines="None" PageSize="500" AutoGenerateColumns="False" OnPageIndexChanging="dgrd_PageIndexChanging" Width="687px">
                    <FooterStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
                    <Columns>
                          <asp:TemplateField  HeaderText="Sr.No" >
                <ItemTemplate>
                    <%#Container.DataItemIndex+1 %>
                </ItemTemplate>
            </asp:TemplateField>
                        <asp:BoundField DataField="PinSerial_No" HeaderText="PinSerial_No" />
                         <asp:BoundField DataField="Regno" HeaderText="User ID"/>
                         <asp:BoundField DataField="name" HeaderText="User Name"/>
                         
                        <asp:BoundField DataField="Active_Date" HeaderText="Active_Date"/>
                        <asp:BoundField DataField="IsActivate" HeaderText="IsActivate"/>
                        <asp:BoundField />
                    </Columns>
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <EditRowStyle BackColor="#999999" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <PagerStyle BackColor="#2881A2" ForeColor="White" HorizontalAlign="Center" />
                    <HeaderStyle BackColor="#2881A2" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                </asp:GridView>
            </td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
    </table></center>
    </div>
    </form>
</body>
</html>
