<div id="LoaderImgFran" class="loader-data" style="display: none;">
    <img src="../images/preloader.gif" alt="" style="height: 200px" />
</div>

<div class="row">
    <div class="col-md-2">
        <select id="ddl_TopFran" class="form-control">
            <option value="5">Top 5</option>
            <option value="10">Top 10</option>
            <option value="20" selected="selected">Top 20</option>
            <option value="30">Top 30</option>
            <option value="50">Top 50</option>
            <option value="99999">All</option>
        </select>
    </div>

    <div class="col-md-2">
        <input type="text" id="txtFromDateFran" class="form-control" title="dd/mm/yyyy" placeholder="From Date" />
    </div>

    <div class="col-md-2">
        <input type="text" id="txtToDateFran" class="form-control" title="dd/mm/yyyy" placeholder="To Date" />
    </div>

    <div class="col-md-2">
        <select id="ddl_FranType" class="form-control" onclick="SalesTypeFran()">
            <option value="SELLER">Seller Wise</option>
            <option value="BUYER">Buyer Wise</option>
        </select>
    </div>

    <div class="col-md-2">
        <select id="ddl_SalesTypeFran" class="form-control">
            <option value="1">Primary Sales</option>
            <option value="2">Secondary Sales</option>
        </select>
    </div>

    <div class="col-md-2">
        <button type="button" title="Search" class="btn btn-primary" onclick="Details_Fran_horizontal()">Search</button>
    </div>
</div>
<div class="clearfix"></div>

<figure class="highcharts-figure_Fran_horizontal">
    <div id="highcharts_div_Fran_horizontal" style="min-width: 310px; min-height: 650px; max-height: 1250px; margin: 0 auto"></div>
</figure>


<script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="datepick/jquery.datepick.js" type="text/javascript"></script>
<link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
<script> var $JD = $.noConflict(true); </script>
<script type="text/javascript">
    $JD(function () {
        $JD('#txtFromDateFran').datepick({ dateFormat: 'dd/mm/yyyy' });
        $JD('#txtToDateFran').datepick({ dateFormat: 'dd/mm/yyyy' });

        var d = new Date();

        $JD('#txtFromDateFran').val("01/" + (d.getMonth() + 1) + "/" + d.getFullYear());
        $JD('#txtToDateFran').val(d.getDate() + "/" + (d.getMonth() + 1) + "/" + d.getFullYear());

    });

    function SalesTypeFran() {
        if ($('#ddl_SalesTypeFran').val() == "SELLER") {
            $('#ddl_SalesTypeFran').css("display", "block");
        }
        else {
            $('#ddl_SalesTypeFran').css("display", "none");
        }
    }


    function Details_Fran_horizontal() {
        if ($('#txtFromDateFran').val() == "") {
            alert('Please Select From Date');
            return false;
        }
        if ($('#txtToDateFran').val() == "") {
            alert('Please Select To Date');
            return false;
        }
        let FromDate = dateFormate($('#txtFromDateFran').val());
        let ToDate = dateFormate($('#txtToDateFran').val());
        let Type = $('#ddl_FranType').val();
        let SalesTypeFran = $('#ddl_SalesTypeFran').val();
        let Top = $('#ddl_TopFran').val();
        $('#LoaderImgFran').show();
        $.ajax({
            type: "POST",
            url: 'Services.aspx/Get_Chart_Data_Admin_Fran_Wise',
            data: '{mstkey: "FRANCHISE_WISE", FromDate: "' + FromDate + '" , ToDate: "' + ToDate + '", Top: "' + Top + '", Type: "' + Type + '", SalesType: "' + SalesTypeFran + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSales_Fran_horizontal,
            failure: function (response) { $('#LoaderImgFran').hide(); alert(response.d); }
        });
    }


    function OnSales_Fran_horizontal(data) {
        $('#LoaderImgFran').hide();
        if (data.d.length > 0) {
            var Month_Name = [];
            Month_Name.length = 0;

            var Total_Sales = [];
            Total_Sales.length = 0;
            let Total = 0;
            for (var j = 0; j < data.d.length; j++) {

                Month_Name.push(data.d[j].ProductName);
                Total_Sales.push(parseFloat(data.d[j].Val));
                Total += parseFloat(data.d[j].Val);
            }
            GetSales_Fran_horizontal(Total, Month_Name, Total_Sales);
        }
    }


    function GetSales_Fran_horizontal(Total, Month_Name, Total_Sales) {
        Highcharts.chart('highcharts_div_Fran_horizontal', {
            chart: { type: 'bar' },
            title: { text: 'Franchise Wise Total Sale: ' + Total.toFixed(2) + ' INR', align: 'left' },
            xAxis: { categories: Month_Name, crosshair: true },
            yAxis: {
                min: 0, title: { text: '', align: 'high' }
            },
            tooltip: { valueSuffix: ' INR', shared: true },
            plotOptions: { bar: { dataLabels: { enabled: true } } },
            legend: {
                layout: 'horizontal', align: 'center', verticalAlign: 'top',
                x: 10, y: -10, floating: true, borderWidth: 1, itemMarginTop: 5,
                itemMarginBottom: 5,
                backgroundColor: Highcharts.defaultOptions.legend.backgroundColor || '#FFFFFF',
                shadow: true
            },
            credits: { enabled: false },
            series: [{ name: 'Franchise', data: Total_Sales, color: "#0f4076" }]
        });
    }

</script>

<style type="text/css">
    .loader-data {
        width: 100%;
        text-align: center;
        position: fixed;
        z-index: 99999;
        right: -66px;
        top: 300px;
    }

    .figure_Fran_horizontal,
    .highcharts-data-table table {
        min-width: 310px;
        max-width: 800px;
        margin: 1em auto;
    }

    #container {
        height: 400px;
    }

    .highcharts-data-table table {
        font-family: Verdana, sans-serif;
        border-collapse: collapse;
        border: 1px solid #ebebeb;
        margin: 10px auto;
        text-align: center;
        width: 100%;
        max-width: 500px;
    }

    .highcharts-data-table caption {
        padding: 1em 0;
        font-size: 1.2em;
        color: #555;
    }

    .highcharts-data-table th {
        font-weight: 600;
        padding: 0.5em;
    }

    .highcharts-data-table td,
    .highcharts-data-table th,
    .highcharts-data-table caption {
        padding: 0.5em;
    }

    .highcharts-data-table thead tr,
    .highcharts-data-table tr:nth-child(even) {
        background: #f8f8f8;
    }

    .highcharts-data-table tr:hover {
        background: #f1f7ff;
    }
</style>


