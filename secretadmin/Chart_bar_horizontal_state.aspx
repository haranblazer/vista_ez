<div id="LoaderImgState" class="loader-data" style="display: none;">
    <img src="../images/preloader.gif" alt="" style="height: 200px" />
</div>

<div class="row">
    <div class="col-md-2">
        <select id="ddl_TopState" class="form-control">
            <option value="99999">All</option>
            <option value="5">Top 5</option>
            <option value="10">Top 10</option>
            <option value="20">Top 20</option>
            <option value="30">Top 30</option>
            <option value="50">Top 50</option>
        </select>
    </div>

    <div class="col-md-2">
        <input type="text" id="txtFromDateState" class="form-control" title="dd/mm/yyyy" placeholder="From Date" />
    </div>

    <div class="col-md-2">
        <input type="text" id="txtToDateState" class="form-control" title="dd/mm/yyyy" placeholder="To Date" />
    </div>

    <div class="col-md-2">
        <select id="ddl_StateType" class="form-control" onclick="SalesType()">
            <option value="BUYER">Buyer Wise</option>
            <option value="SELLER">Seller Wise</option>
        </select>
    </div>

    <div class="col-md-2">
        <select id="ddl_SalesType" class="form-control" style="display: none;">
            <option value="1">Primary Sales</option>
            <option value="2">Secondary Sales</option>
        </select>
    </div>

    <div class="col-md-2">
        <button type="button" title="Search" class="btn btn-primary" onclick="Details_state_horizontal()">Search</button>
    </div>
</div>
<div class="clearfix"></div>

<figure class="highcharts-figure_state_horizontal">
    <div id="highcharts_div_state_horizontal" style="min-width: 310px; min-height: 650px; max-height: 1250px; margin: 0 auto"></div>
</figure>


<script src="datepick/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="datepick/jquery.datepick.js" type="text/javascript"></script>
<link href="datepick/jquery.datepick.css" rel="stylesheet" type="text/css" />
<script> var $JD = $.noConflict(true); </script>
<script type="text/javascript">
    $JD(function () {
        $JD('#txtFromDateState').datepick({ dateFormat: 'dd/mm/yyyy' });
        $JD('#txtToDateState').datepick({ dateFormat: 'dd/mm/yyyy' });

        var d = new Date();

        $JD('#txtFromDateState').val("01/" + (d.getMonth() + 1) + "/" + d.getFullYear());
        $JD('#txtToDateState').val(d.getDate() + "/" + (d.getMonth() + 1) + "/" + d.getFullYear());

    });

    function SalesType() {
        if ($('#ddl_StateType').val() == "SELLER") {
            $('#ddl_SalesType').css("display", "block");
        }
        else {
            $('#ddl_SalesType').css("display", "none");
        }
    }


    function Details_state_horizontal() {
        if ($('#txtFromDateState').val() == "") {
            alert('Please Select From Date');
            return false;
        }
        if ($('#txtToDateState').val() == "") {
            alert('Please Select To Date');
            return false;
        }
        let FromDate = dateFormate($('#txtFromDateState').val());
        let ToDate = dateFormate($('#txtToDateState').val());
        let Type = $('#ddl_StateType').val();
        let SalesType = $('#ddl_SalesType').val();
        let Top = $('#ddl_TopState').val();
        $('#LoaderImgState').show();
        $.ajax({
            type: "POST",
            url: 'Services.aspx/Get_Chart_Data_Admin_State_Wise',
            data: '{mstkey: "STATE_WISE", FromDate: "' + FromDate + '" , ToDate: "' + ToDate + '", Top: "' + Top + '", Type: "' + Type + '", SalesType: "' + SalesType + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSales_state_horizontal,
            failure: function (response) { $('#LoaderImgState').hide(); alert(response.d); }
        });
    }


    function OnSales_state_horizontal(data) {
        $('#LoaderImgState').hide();
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
            GetSales_state_horizontal(Total, Month_Name, Total_Sales);
        }
    }


    function GetSales_state_horizontal(Total, Month_Name, Total_Sales) {
        Highcharts.chart('highcharts_div_state_horizontal', {
            chart: { type: 'bar' },
            title: { text: 'State Wise Total Sale: ' + Total.toFixed(2) + ' INR', align: 'left' },
            xAxis: { categories: Month_Name, title: { text: null } },
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
            series: [{ name: 'State', data: Total_Sales, color: "#0f4076" }]
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

    .figure_state_horizontal,
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


