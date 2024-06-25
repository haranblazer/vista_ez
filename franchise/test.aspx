<%@ Page Title="" Language="C#" MasterPageFile="~/franchise/MasterPage.master" AutoEventWireup="true" CodeFile="test.aspx.cs" Inherits="franchise_test" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <%-- <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">--%>
    <%--  <link rel="stylesheet" href="/resources/demos/style.css">--%>
    <%--<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        $(function () {
            var names = ["Jörn Zaefferer", "Scott González", "John Resig"];

            var accentMap = {"á": "a","ö": "o"};
            var normalize = function (term) {
                var ret = "";
                for (var i = 0; i < term.length; i++) {
                    ret += accentMap[term.charAt(i)] || term.charAt(i);
                }
                return ret;
            };

            $("#developer").autocomplete({
                source: function (request, response) {
                    var matcher = new RegExp($.ui.autocomplete.escapeRegex(request.term), "i");
                    response($.grep(names, function (value) {
                        value = value.label || value.value || value;
                        return matcher.test(value) || matcher.test(normalize(value));
                    }));
                }
            });
        });
    </script>
    <label for="developer">Developer: </label>
    <input id="developer">--%>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

  <%--  <link href="css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.autocomplete.js" type="text/javascript"></script>--%>


    <script>
        $(function () {
            var acList = ['smart',
                         'over smart',
                         'smart land',
                         'under smart',
                         'very smart',
                         'ajay kumar'
            ];

            $('#<%=txt_Barcode.ClientID%>').autocomplete({
                source: function (request, response) {
                    var matches = $.map(acList, function (acItem) {
                        if (acItem.toUpperCase().indexOf(request.term.toUpperCase()) != -1) {
                            return acItem;
                        }
                    });
                    response(matches);
                }
            });
        });
    </script>

    <input id="ac" />

     <asp:TextBox ID="txt_Barcode" runat="server" CssClass="form-control" placeholder="Select Product..."></asp:TextBox>
</asp:Content>

