/*-----------------------cart---------------*/
$(document).ready(function ($) {
    // Declare the body variable
    var $body = $("body");

    // Function that shows and hides the sidebar cart
    $(".cart-button, .close-button, #sidebar-cart-curtain").click(function (e) {
        e.preventDefault();

        // Add the show-sidebar-cart class to the body tag
        $body.toggleClass("show-sidebar-cart");

        // Check if the sidebar curtain is visible
        if ($("#sidebar-cart-curtain").is(":visible")) {
            // Hide the curtain
            $("#sidebar-cart-curtain").fadeOut(500);
        } else {
            // Show the curtain
            $("#sidebar-cart-curtain").fadeIn(500);
        }
    });
/*-----------------------end---------------*/