<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="news.aspx.cs" Inherits="user_news" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<%--<script type="text/javascript">
    function bigImg(x) {
        x.style.transform = "scale(3)" ;
    }

    function normalImg(x) {
        x.style.transform = "scale(1)";
    }
</script>--%>
    <h2 class="head">News</h2>
    <div class="container-fluid page__container" id="newsdata" runat="server">
    <asp:Repeater ID="RepterDetails" runat="server">
    <HeaderTemplate>
    </HeaderTemplate>
    <ItemTemplate>    
    <p class='text-dark-gray row align-items-center mt-3'> <strong><%#Eval("doe") %></strong></p>
    <div class='row align-items-center projects-item mb-1'>
    <div class='col-sm-auto mb-1 mb-sm-0'> <div class='text-dark-gray'></div> </div>
    <div class='col-sm'><div class='card m-0'><div class='px-4 py-3'> <div class='row align-items-center'> <div class='col' style='min-width: 300px'> 
    <div class='card-group-row align-items-center'>
    <div class='col-md-2 col-xs-12 zoom' style='z-index:9999999999;'>
    <input type='checkbox' id='zoomCheck'>
    <label for='zoomCheck' onmouseover="bigImg(this)" class="imagezoomout" onmouseout="normalImg(this)" id='<%#Eval("NewsMstId") %>'>
    <asp:Label ID="lblimg" runat="server" Text='<%#Eval("Photo") %>' Font-Bold="true"/> 
    </label>
    </div>
    <div class="col-md-10 col-xs-12">
     <a href='#' class='text-body'>
     <h4>
     <strong class=' mr-2'><asp:Label ID="Label2" runat="server" Text='<%#Eval("NewsMstTitle") %>' Font-Bold="true"/></strong></h4></a>
     <p> <asp:Label ID="Label4" runat="server"  Text='<%#Eval("newsmstdiscription") %>' Font-Bold="true"/>
     </div>  </p>
    </div>
    </div>
    </div>
    </div>
     </div>
    </div>
    </div>
    <br /><br />
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
transform: scale(1.5)!important;
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


