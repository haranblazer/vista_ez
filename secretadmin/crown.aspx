<%@ Page Language="C#" AutoEventWireup="true" CodeFile="crown.aspx.cs" Inherits="secretadmin_crown" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=PT+Sans+Narrow&family=PT+Sans:ital,wght@0,400;0,700;1,400;1,700&display=swap" rel="stylesheet">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Fjalla+One&display=swap" rel="stylesheet">


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.min.js"></script>



    <script type="text/javascript">

        $(function () {
            downloadimage();
        });

        function downloadimage() {

            var container = document.getElementById("htmltoimage");
            html2canvas(container, {
                onrendered: function (canvas) {
                    //getCanvas = canvas;

                    var link = document.createElement("a");
                    document.body.appendChild(link);
                    link.download = "<%=UserName%>" + ".jpg";
                    link.href = canvas.toDataURL();
                    link.target = '_blank';
                    link.click();

                     window.close();
                    //window.top.close();
                    //var win = window.open("about:blank", "_self");

                    //win.close();
                }
            });
        }

    </script>

    <style>
        font-family: 'PT Sans', sans-serif;
        font-family: 'Fjalla One', sans-serif;
    </style>
</head>
<body  style="width: 720px; margin: auto">
    <form id="form1" runat="server">

        <table id="htmltoimage">
            <tbody>
                <tr>
                    <td style="color: Black; background-color: White;">
                        <table cellspacing="5" cellpadding="3" border="0">
                            <tbody>
                                <tr>
                                    <td style="color: Black; background-color: White;">
                                        <div class="article">
                                            <div style="background-image: url( images/crown.jpg); background-repeat: no-repeat; height: 1280px; width: 720px;">
                                                <div style="padding-left: 157px; padding-top: 166px;">
                                                    <table>
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <img src="../images/KYC/ProfileImage/<%=Img%>" style="height: 401px; width: 400px; border-width: 0px;" />
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                                <div style="padding-left: 96px; padding-top: 9px;">
                                                    <table>
                                                        <tbody>
                                                            <tr>
                                                                <td colspan="2" style="text-align: center">
                                                                    <span style="font-size: 53px; color: #151412; font-family: 'PT Sans', sans-serif;">FOR ACHIEVING</span>

                                                                </td>

                                                            </tr>
                                                            <tr>
                                                                <td colspan="2" style="text-align: center">

                                                                    <div style="font-size: 55px; color: #02008d; font-weight: bold; font-family: arial; margin-top: -16px;"><%=Rank%> RANK</div>
                                                                </td>

                                                            </tr>
                                                            <tr>

                                                                <td colspan="2" style="text-align: center">

                                                                    <p style="font-size: 25px; color: #161511; font-weight: bold; font-family: arial; margin: 0;"></p>
                                                                </td>
                                                            </tr>


                                                        </tbody>
                                                    </table>
                                                </div>
                                                <div style="padding-left: 0px; padding-top: 55px; /* color: #000; */">
                                                    <table style="width:100%">
                                                        <tbody>

                                                            <tr>
                                                                <td colspan="2" style="text-align: center">

                                                                    <div style="font-size: 55px; color: #0201f5; font-weight: bold; font-family: arial; margin-top: -16px;"><%=RankName%></div>
                                                                </td>

                                                            </tr>
                                                            <tr>

                                                                <td colspan="2" style="text-align: center">

                                                                    <p style="font-size: 25px; color: #161511; font-weight: bold; font-family: arial; margin: 0;"></p>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td></td>
                                                                <td style="text-align: center">
                                                                    <div style="font-size: 39px; color: #161511; /* margin: 22px 0 0; */">
                                                                        In The Month of <%=Month%>
                                                                    </div>

                                                                </td>
                                                            </tr>

                                                        </tbody>
                                                    </table>
                                                </div>
                                                <div style="padding-left: 49px; padding-top: 39px;">
                                                    <table>
                                                        <tbody>
                                                            <tr>
                                                                <td>
                                                                    <span style="font-size: 35px; color: #151412; font-weight: 600; font-family: arial;">Name
   
                                                                    </span>

                                                                </td>
                                                                <td>
                                                                    <span style="font-size: 35px; color: #151412; font-weight: 600; font-family: arial;">:
   
                                                                    </span>

                                                                </td>
                                                                <td>
                                                                    <span style="font-size: 35px; color: #151412; font-weight: 600; font-family: arial;"><%=UserName%>                                                                        
                                                                    </span>

                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <span style="font-size: 35px; color: #151412; font-weight: 600; font-family: arial;">DIST. </span>

                                                                </td>
                                                                <td>
                                                                    <span style="font-size: 35px; color: #151412; font-weight: 600; font-family: arial;">:
   
                                                                    </span>

                                                                </td>
                                                                <td>
                                                                    <span style="font-size: 35px; color: #151412; font-weight: 600; font-family: arial;"><%=Distinct%>                                                                                 
                                                                    </span>

                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td><span style="font-size: 35px; color: #151412; font-weight: 600; font-family: arial;">STATE</span>

                                                                </td>
                                                                <td>
                                                                    <span style="font-size: 35px; color: #151412; font-weight: 600; font-family: arial;">:
   
                                                                    </span>

                                                                </td>
                                                                <td>
                                                                    <span style="font-size: 35px; color: #151412; font-weight: 600; font-family: arial;"><%=State%> </span>

                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </td>

                                </tr>
                            </tbody>
                        </table>
                    </td>

                </tr>
            </tbody>
        </table>

    </form>
</body>
</html>
