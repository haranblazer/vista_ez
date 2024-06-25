// Copyright 51 Degrees Mobile Experts Limited
function FODIO(width_param, height_param) {

    var src_parameter = "src";
    var width_parameter = "w";
    if (typeof width_param !== "undefined") { width_parameter = width_param; }
    var height_parameter = "h";
    if (typeof height_param !== "undefined") { height_parameter = height_param; }
    var auto_parameter = "auto";

    //* (LoadImage) Loads the image based on measurements taken within the browser. */
    function setImage(image_element, image_src) {

        // Get the query string parameters for the image element src.
        var qs = (function (a) {
            var b = {};
            if (a != "") {
                for (var i = 0; i < a.length; ++i) {
                    var p = a[i].split('=');
                    if (p.length != 2) continue;
                    b[p[0]] = decodeURIComponent(p[1].replace(/\+/g, " "));
                }
            }
            return b;
        })(image_src.split(/[&\?]+/));

        // Does the control have a 1 by 1 image displayed?
        var startWithParent = (image_element.parentNode.nodeName == "A" ||
        (image_element.offsetWidth == 1 &&
        image_element.offsetHeight == 1));

        // Get the width of the image.
        var width = qs[width_parameter];
        if (width != undefined && isNaN(width)) {
            width = getWidth(startWithParent ? image_element.parentNode : image_element);
            if (startWithParent)
                image_element.parentNode.style.width = width + "px";
        }

        // Get the height of the image.
        var height = qs[height_parameter];
        if (height != undefined && isNaN(height)) {
            height = getHeight(startWithParent ? image_element.parentNode : image_element);
            if (startWithParent)
                image_element.parentNode.style.height = height + "px";
        }

        // Change the image source to the selected width and height.
        var parameters = [];

        if (width > 0)
            parameters.push(width_parameter + "=" + width);
        if (height > 0)
            parameters.push(height_parameter + "=" + height);
		if(qs[src_parameter] != undefined)
			parameters.push(src_parameter + "=" + qs[src_parameter]);

        image_element.src = image_src.substring(0, image_src.indexOf("?")) +
        "?" + parameters.join("&");
    }

    function getWidth(element) {
        if (element != undefined) {
            if (element.nodeName != "A" && element.offsetWidth != 0)
                return element.offsetWidth;
            return getWidth(element.parentNode);
        }
        return 0;
    }

    function getHeight(element) {
        if (element != undefined) {
            if (element.nodeName != "A" && element.offsetHeight != 0)
                return element.offsetHeight;
            return getHeight(element.parentNode);
        }
        return 0;
    }

    function setImageSource(image_element, image_src) {
        if (image_src.indexOf("?") >= 0 && (
            image_src.indexOf(width_parameter + "=" + auto_parameter, image_src.indexOf("?")) >= 0 ||
            image_src.indexOf(height_parameter + "=" + auto_parameter, image_src.indexOf("?")) >= 0)) {
            setImage(image_element, image_src);
            return true;
        }
        return false;
    }

    // Loop through all the img elements finding any with the data src
    // attribute set.
    var images = document.getElementsByTagName("img");
    for (var i = 0, max = images.length; i < max; i++) {
        var image_element = images[i];
        if (!setImageSource(image_element, image_element.src)) {
            var data_src = image_element.attributes["data-src"];
            if (data_src != undefined) {
                setImageSource(image_element, data_src.value);
            }
        }
    }
}
