<%@ Page Title="" Language="C#" MasterPageFile="~/User/user.master" AutoEventWireup="true"
    CodeFile="payment-cancel.aspx.cs" Inherits="User_payment_cancel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
 <br />
  
    <div class="container-fluid" style="background: url(images/blur_nbanner.jpeg); height: 800px;
        margin-top: -54px;">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                </div>
                <div class="col-md-4" style="height: 400px; max-width: 500px; background-color: #fff;
                    margin-top: 60px; border-radius: 10px;">
                    <div class="clearfix">
                    </div>
                    <br />
                    <center>
                        
                        <img src="images/cancel-icon.png" style="height: 80px;" />
                        
                        <hr />
                        <p>
                            Dear Customer Your Transaction Id is <asp:label id="lblTranid" runat="server"></asp:label>
                            <br />
                            <p> <asp:label id="lbl_msg" runat="server"></asp:label> </p>
                            <br />
                            OOPS !!! Your payment for Make New PO was not processed successfully. Kindly try again for
                            EKSBD VENTURES PVT LTD. 
                        </p>
                    </center>
                    <br />
                    <center>
                        <a href="#">Return To Shoppping <span class="fa fa-arrow-right"></span></a>
                    </center>
                </div>
                <div class="col-md-4">
                </div>
            </div>
        </div>
    </div>
    
</asp:Content>
