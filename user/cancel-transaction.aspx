<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="cancel-transaction.aspx.cs" Inherits="cancel_transaction" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="breadcrumb">
			<div class="container">
				<ul>
					<li><a href="#">Home</a></li>
					<li>Transaction Failed  </li>
				</ul>
			</div>
		</div>


<div class="container-fluid" style="background:url(images/blur_nbanner.jpeg); height:800px; margin-top:-54px;" >
<div class="container">
<div class="row">

<div class="col-md-4"></div>


<div class="col-md-4" style="height:400px; max-width:500px; background-color:#fff; margin-top:60px; border-radius:10px; ">
<div class="clearfix"></div><br />

<center>
<h2>OOPS !!!</h2> 
<img src="images/cancel-icon.png" style="height:80px;" />

<h5> Transaction Failed </h5>
<hr />

<p>Dear Customer Your Transaction Id is<italic> 101 </italic> <BR /> Your payment for Make New PO was not processed successfully. Kindly try again for EKSBD VENTURES PVT LTD. </p>
</center>

<BR />

<center><a href="#">Return To Shoppping <span class="fa fa-arrow-right"></span></a> </center>
</div>



<div class="col-md-4"></div>




</div>
</div>


</div>

</div>


</asp:Content>

