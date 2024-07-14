<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true"
    CodeFile="news.aspx.cs" Inherits="user_news" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<%--<script type="text/javascript">
    function bigImg(x) {
        x.style.transform = "scale(3)" ;
    }

    function normalImg(x) {
        x.style.transform = "scale(1)";
    }
</script>--%>
    <div class="d-flex align-items-center mb-0 mt-1 flex-wrap">
					<h4 class="fs-20 font-w600  me-auto">News</h4>					
				</div>
   
    <div class="container-fluid page__container" id="newsdata" runat="server">
    <asp:Repeater ID="RepterDetails" runat="server">  
    <HeaderTemplate>  
   
    </HeaderTemplate>  
    <ItemTemplate>  
    <p class='text-dark-gray row align-items-center mt-3'><i class='material-icons icon-muted mr-2'>event</i> <strong><%#Eval("doe") %></strong></p>
     <div class=''>
    <div class='col-sm-auto mb-1 mb-sm-0'> <div class='text-dark-gray'></div> </div>
    <div class='col-sm'><div class='card m-0'><div class='px-4 py-3'> <div class='row align-items-center'> <div class='col' style='min-width: 300px'> 
    <div class='row card-group-row '>
    <div class='col-md-2 col-xs-12 zoom' style='z-index:999;'>
   <input type='checkbox' id='zoomCheck'>
    <label for='zoomCheck' onmouseover="bigImg(this)" class="imagezoomout" onmouseout="normalImg(this)" id='<%#Eval("NewsMstId") %>'>
     <asp:Label ID="lblimg" runat="server" Text='<%#Eval("Photo") %>' Font-Bold="true"/> 
   </label>
    </div>
    <div class="col-md-10 col-xs-12">
     <a href='#' class='text-body'>
     <h5>
     <strong class=' mr-2'><asp:Label ID="Label2" runat="server" Text='<%#Eval("NewsMstTitle") %>' Font-Bold="true"/></strong></h5></a>
     
     <p> <asp:Label ID="Label4" runat="server"  Text='<%#Eval("newsmstdiscription") %>' Font-Bold="true"/>
     </div>  </p>
    </div>
    </div>
    </div>
    </div>
     </div>
    </div>
    </div>
    </ItemTemplate>  
    <FooterTemplate>  
    </table>  
    </FooterTemplate>  
    </asp:Repeater>  
    </div>

   </div>
    
    <script>
        function myFunction() {
            var dots = document.getElementById("dots");
            var moreText = document.getElementById("more");
            var btnText = document.getElementById("myBtn");

            if (dots.style.display === "none") {
                dots.style.display = "inline";
                btnText.innerHTML = "Read more";
                moreText.style.display = "none";
            } else {
                dots.style.display = "none";
                btnText.innerHTML = "Read less";
                moreText.style.display = "inline";
            }
        }
</script>



<style>
    input[type=checkbox] {
  display: none;
}

 .zoom_image{ 
              transform: scale(3);
            cursor: zoom-out;
               }

.zoom_img {

  transition: transform 0.25s ease;
  cursor: zoom-in;
}

input[type=checkbox]:checked ~ label > img {
  transform: scale(3);
  cursor: zoom-out;
}
    
#more {display: none;}

 .imagezoomout img:hover {
    transform: scale(1.7)!important;
}
.imagezoomout img {
transform: scale(1)!important;
}
 @media only screen and (min-width : 180px) and (max-width : 520px)
{
    .imagezoomout img:hover {
transform: scale(1)!important;
}
.imagezoomout img {
transform: scale(1)!important;
}
</style>
</asp:Content>
