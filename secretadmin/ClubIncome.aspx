<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClubIncome.aspx.cs" Inherits="admin_BeforPayout" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Club Income</title>
    <script language=javascript>
    function number(){
    var x;
    x=event.keyCode;
    if(x<48 ||x>57){
    if(x==32){
    event.returnValue=true;
    }else{
    alert("only number");
    event.returnValue=false;
    
    }
    }     
    }
    
    
    </script>
   

    
    <style type="text/css">
    
    body,td,th{
    font-family: Arial;
    font-size: 12px;
    }
    
    
    </style>
</head>
<body style="color: #000000">
    <form id="form1" runat="server">
    <div align="center">
    <table border="0" cellpadding="0" cellspacing="0" style="width: 800px; border-top-width: 1px; border-left-width: 1px; border-left-color: black; border-bottom-width: 1px; border-bottom-color: black; border-top-color: black; border-right-width: 1px; border-right-color: black;">
        
            <td style="width: 50px; height: 35px">
            </td>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td align="center" colspan="2" style="border-top-width: 1px; border-left-width: 1px;
                border-left-color: #000000; border-bottom-width: 1px; border-bottom-color: #000000;
                border-top-color: #000000; height: 25px; background-color: #2881a2; text-align: center;
                border-right-width: 2px; border-right-color: #000000" valign="middle">
                <strong><span style="font-size: 12pt; color: #ffffff">Salary Club</span></strong></td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td align="center" style="border-top-width: 1px; border-top-color: #000000; height: 30px;
                background-color: #ffffff; 
                border-right-width: 2px; border-right-color: #000000; border-left-width: 1px; border-left-color: #000000; border-bottom-width: 1px; border-bottom-color: #000000; text-align: left;"
                valign="middle" colspan="2">
                &nbsp;<table cellspacing="0" style="width: 900px">
                      <tr>
                                            <td style="border-left: #000000 1px solid; width: 23%; height: 35px; text-align: right">
                            Select Selection:.</td>
                                            <td style="width: 26%; height: 35px; text-align: left"><asp:DropDownList ID="DropDownList2" runat="server" Width="118px" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" AutoPostBack="True">
                                                <asp:ListItem Selected="True">Select</asp:ListItem>
                                                
                                                <asp:ListItem Value="1">Club Wise</asp:ListItem>
                                                <asp:ListItem Value="2"> Closing Wise</asp:ListItem>
                                            </asp:DropDownList></td>
                                            <td style="border-right: #000000 1px solid; width: 55%; height: 35px">
                                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                &nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
                                                &nbsp; &nbsp;&nbsp;
                                            </td>
                                        </tr>
                </table>
            </td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr >
            <td style="width: 50px; height: 25px">
            </td>
            <td colspan="2" style="border-bottom-width: 1px; border-bottom-color: #000000; height: 25px;
                text-align: left; border-right-width: 1px; border-right-color: #000000">
                <table border ="1" runat="server" id="club" style="width: 904px; height: 119px" cellspacing="0">
                    <tr style ="background-color :#2881A2">
                        <td colspan="3">
                            <strong><span style="font-size: 12pt; color: #ffffff;" >Select Income Type</span></strong></td>
                    </tr>
                <tr>
                    <td style="width: 30%; text-align: right; height: 24px;">
                        <asp:RadioButton ID="rdbtnC1" runat="server" Text="S1" GroupName ="a"
                         TextAlign="Left" ValidationGroup="w" Width="70px" /></td>
                    <td style="width: 30%; text-align: right; height: 24px;">
                        <asp:RadioButton ID="rdbtnC5" runat="server" Text="S5" GroupName ="a"
                        TextAlign="Left" ValidationGroup="w" Width="73px" /></td>
                <td style="width: 40%; text-align: right; height: 24px;">
                    <asp:RadioButton ID="rdbtnC9" runat="server" Text="S9" GroupName ="a"
                    TextAlign="Left" ValidationGroup="w" /></td>
                </tr>
                    <tr>
                        <td style="width: 30%; text-align: right">
                        <asp:RadioButton ID="rdbtnC2" runat="server" Text="S2"  GroupName ="a"
                        TextAlign="Left" ValidationGroup="w" Width="71px" /></td>
                        <td style="width: 30%; text-align: right">
                        <asp:RadioButton ID="rdbtnC6" runat="server" Text="S6"  GroupName ="a"
                        TextAlign="Left" ValidationGroup="w" Width="73px" /></td>
                        <td style="width: 40%; text-align: right">
                    <asp:RadioButton ID="rdbtnC10" runat="server" Text="S10" TextAlign="Left"  GroupName ="a"
                    ValidationGroup="w" /></td>
                    </tr>
                <tr>
                    <td style="width: 30%; height: 14px; text-align: right;">
                            <asp:RadioButton ID="rdbtnC3" runat="server" GroupName ="a" 
                             Text="S3" TextAlign="Left" ValidationGroup="w" Width="101px" /></td>
                    <td style="width: 30%; height: 14px; text-align: right;">
                            <asp:RadioButton ID="rdbtnC7" runat="server" Text="S7" GroupName ="a"
                             TextAlign="Left" 
                            ValidationGroup="w" Width="69px" /></td>
                <td style="width: 40%; height: 14px; text-align: right;">
                            <asp:RadioButton ID="rdbtnC11" runat="server" Text="S11"  GroupName ="a"
                            TextAlign="Left" ValidationGroup="w" /></td>
                </tr>
                <tr>
                    <td style="width: 30%; height: 26px; text-align: right;">
                        <asp:RadioButton ID="rdbtnC4" runat="server" GroupName ="a"
                        Text="S4" TextAlign="Left" ValidationGroup="w" Width="73px" /></td>
                    <td style="width: 30%; height: 26px; text-align: right;">
                    <asp:RadioButton ID="rdbtnC8" runat="server" Text="S8" GroupName ="a"
                    TextAlign="Left" ValidationGroup="w" /></td>
                <td style="width: 40%; height: 26px; text-align: right;">
                    <asp:RadioButton ID="rdbtnC12" runat="server" Text="S12"  GroupName ="a"
                            TextAlign="Left" ValidationGroup="w" /></td>
                </tr>
                    <tr>
                        <td style="width: 30%; height: 28px; text-align: right;">
                            </td>
                        <td style="width: 30%; height: 28px; text-align: right;">
                    </td>
                        <td style="width: 40%; height: 28px; text-align: right;">
                            </td>
                    </tr>
                </table>
            </td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr >
            <td style="width: 50px; height: 25px">
            </td>
            <td colspan="2" style="border-bottom-width: 1px; border-bottom-color: #000000; height: 25px;
                text-align: left; border-right-width: 1px; border-right-color: #000000">
                <table runat="server" id="closing" cellspacing="0" style="width: 512px">
                    <tr>
                        <td style="width: 40%; text-align: right;">
                            Select
                            Closing No:.</td>
                        <td style="width: 26%">
                            <asp:DropDownList ID="DropDownList1" runat="server" Width="62px">
                                <asp:ListItem Selected="True">Select</asp:ListItem><asp:ListItem>1</asp:ListItem>
                                <asp:ListItem>2</asp:ListItem>
                            </asp:DropDownList></td>
                        <td style="width: 30%">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="DropDownList1"
                                Display="Dynamic" ErrorMessage="Please Select Closing No !" Font-Bold="True"
                                ForeColor="#C00000" InitialValue="Select" Style="position: static" ValidationGroup="ci">Please Select Closing No !</asp:RequiredFieldValidator></td>
                    </tr>
                </table>
            </td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td colspan="2" style="border-bottom-width: 1px; border-bottom-color: #000000; height: 25px;
                text-align: center; border-right-width: 1px; border-right-color: #000000">
                    <asp:Label ID="lbl" runat="server" Font-Bold="True" ForeColor="#C00000" Width="319px"></asp:Label><asp:Image
                        ID="Image1" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/admin_images/excel.gif" /><asp:Button
                            ID="Button3" runat="server" BackColor="#093872" BorderStyle="None" Font-Bold="True"
                            Font-Italic="True" ForeColor="White" OnClick="Button3_Click" Text="EXPORT" /></td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 35px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 35px;
                text-align: center; border-right-width: 1px; border-right-color: #000000">
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="View List" BackColor="#2881A2" BorderColor="Black" BorderWidth="1px" Font-Bold="True" ForeColor="White" ValidationGroup="ci" /></td>
            <td style="width: 50px; height: 35px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 24px">
            </td>
            <td colspan="2" style="border-left-width: 1px; border-left-color: #000000; height: 24px;
                text-align: right; border-right-width: 1px; border-right-color: #000000">
                <strong>No Of Records Found</strong>:<asp:Label ID="Label1" runat="server" Font-Bold="True"></asp:Label></td>
            <td style="width: 50px; height: 24px">
            </td>
        </tr>
        <tr>
            <td style="width: 50px; height: 25px">
            </td>
            <td colspan="2" style="border-right: #000000 1px solid; border-top: #000000 1px solid;
                border-left: #000000 1px solid; border-bottom: #000000 1px solid; height: 25px;
                text-align: center; width: 700px;" valign="top">
                 <asp:Panel ID="Panel1" runat="server">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" 
            ForeColor="#333333" GridLines="None"
             PageSize="50" Width="900px" AllowPaging="True" 
             OnPageIndexChanging="GridView1_PageIndexChanging">
                        <Columns>
                            <asp:TemplateField   HeaderText="SrNo." ItemStyle-Font-Bold="true" >
                            <ItemTemplate >
                          <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                            </asp:TemplateField>
                              <asp:BoundField ItemStyle-HorizontalAlign="Left" 
                              HeaderStyle-HorizontalAlign="Left" 
                              DataField="regno" 
                              HeaderText="User ID" />
                           <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" 
                            DataField="name" HeaderText="Name"/>
                           <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" 
                           DataField="date" HeaderText="Date of Qualify"/>
                                      <asp:BoundField ItemStyle-HorizontalAlign="Left"
                                       HeaderStyle-HorizontalAlign="Left" DataField="SponsorTotal" 
                                       HeaderText="Sponser Total"/>
                                           <asp:BoundField ItemStyle-HorizontalAlign="Left"
                                            HeaderStyle-HorizontalAlign="Left" DataField="pairrank" 
                                            HeaderText="Pair Rank"/>
                                            <asp:BoundField ItemStyle-HorizontalAlign="Left"
                                                      HeaderStyle-HorizontalAlign="Left" DataField="rank" 
                                                      HeaderText="Rank"/>
                                                <asp:BoundField ItemStyle-HorizontalAlign="Left" 
                                                HeaderStyle-HorizontalAlign="Left" DataField="status" HeaderText="Status"/>
                                                    
                                    
                                                                                                                                 
                                   
                        </Columns>
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <RowStyle BackColor="#EDF0FD" />
                        <EditRowStyle BackColor="#2461BF" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <PagerStyle BackColor="#69B5D1" ForeColor="White" HorizontalAlign="Center" />
                        <HeaderStyle BackColor="#69B5D1" Font-Bold="True" ForeColor="White" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                    </asp:Panel>
            </td>
            <td style="width: 50px; height: 25px">
            </td>
        </tr>
    </table>
</div>
    </form>
</body>
</html>
