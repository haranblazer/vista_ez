<div id="LoaderImgComparison" class="loader-data" style="display: none;">
    <img src="../images/preloader.gif" alt="" style="height: 200px" />
</div>


<div class="row">
    <%--<div class="col-md-2">
        <select id="ddl_TopFran" class="form-control">
            <option value="5">Top 5</option>
            <option value="10">Top 10</option>
            <option value="20" selected="selected">Top 20</option>
            <option value="30">Top 30</option>
            <option value="50">Top 50</option>
            <option value="99999">All</option>
        </select>
    </div>--%>
     
     <div class="col-md-2">
        <select id="ddl_MstKeyComparison" class="form-control">
            <option value="STATE_WISE">State Wise</option>
            <option value="FRANCHISE_WISE">Franchise Wise</option>
        </select>
    </div>

    <div class="col-md-2">
        <select id="ddl_FranTypeComparison" class="form-control" onclick="Details_Pie_Chart_CateWise()">
            <option value="SELLER">Seller Wise</option>
            <option value="BUYER">Buyer Wise</option>
        </select>
    </div>

     <div class="col-md-2">
        <select id="ddl_SalesTypeComparison" class="form-control">
            <option value="1">Primary Sales</option>
            <option value="2">Secondary Sales</option>
        </select>
    </div> 

    <div class="col-md-2">
        <button type="button" title="Search" class="btn btn-primary" onclick="PopulateDashboard_Comparison()">Search</button>
    </div>
</div>
<div class="clearfix"></div>


<figure class="highcharts-figure_Comparison">
    <div id="highcharts_div_Comparison"></div>
</figure>
<script type="text/javascript">

    function Details_Pie_Chart_CateWise() {
        if ($('#ddl_FranTypeComparison').val() == "SELLER") {
            $('#ddl_SalesTypeComparison').css("display", "block");
        }
        else {
            $('#ddl_SalesTypeComparison').css("display", "none");
        }
    }


    function PopulateDashboard_Comparison() {
        $('#LoaderImgComparison').show();
        let mstkey = $('#ddl_MstKeyComparison').val();
        let Top = 9999;
        let Type = $('#ddl_FranTypeComparison').val();
        let SalesType = $('#ddl_SalesTypeComparison').val(); 
        $.ajax({
            type: "POST",
            url: 'Services.aspx/Get_ComparisonChart', 
            data: '{mstkey: "' + mstkey+'", Type: "' + Type + '", SalesType: "' + SalesType + '", Top: "' + Top + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSalesTargetReportPopulatedComparison,
            failure: function (response) { $('#LoaderImgComparison').hide(); alert(response.d); }
        });
    }

    function OnSalesTargetReportPopulatedComparison(data) {
        $('#LoaderImgComparison').hide();
        if (data.d.length > 0) {
            var CateWise = [];
            CateWise.length = 0;

            var M1 = [];
            M1.length = 0;

            var M2 = [];
            M2.length = 0;

            var M3 = [];
            M3.length = 0;
            let Total = 0;
            for (var j = 0; j < data.d.length; j++) {
                CateWise.push(data.d[j].CateWise);

                M1.push(parseFloat(data.d[j].M1));
                M2.push(parseFloat(data.d[j].M2));
                M3.push(parseFloat(data.d[j].M3));

                Total += parseFloat(data.d[j].M1) + parseFloat(data.d[j].M2) + parseFloat(data.d[j].M3); 
            }

            GetSalesChartComparison(Total, CateWise, M1, M2, M3, data.d[0].Month1, data.d[0].Month2, data.d[0].Month3);
        }
    }


    function GetSalesChartComparison(Total, CateWise, M1, M2, M3, Month1, Month2, Month3) {

        Highcharts.chart('highcharts_div_Comparison', {
            chart: { type: 'column' },
            title: { text: ' Month Wise Sales ', align: 'left' },
            subtitle: { text: '&nbsp; ' },
            xAxis: { categories: CateWise, crosshair: true },
            yAxis: { min: 0, title: { text: '', align: 'high' }, },
            tooltip: {
                shared: true
            },
            legend: {
                layout: 'horizontal',
                align: 'center',
                verticalAlign: 'top',
                x: 10,
                y: -10,
                itemMarginTop: 5,
                itemMarginBottom: 5,
                borderWidth: 1,
                backgroundColor: Highcharts.defaultOptions.legend.backgroundColor || '#FFFFFF',
            },
            credits: { enabled: false },
            series: [
                { name: Month1, color: '#0f4076', data: M1 },
                { name: Month2, color: '#fe6a00', data: M2 },
                { name: Month3, color: '#34b10b', data: M3 },
            ]
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


    .highcharts-data-table table, highcharts-figure_Comparison {
        min-width: 310px;
        max-width: 650px;
        margin: 2em auto;
    }

    #containerDivID {
        height: 450px;
    }

    .highcharts-data-table table {
        font-family: Arial;
        border: 2px solid #e9e9e9;
        margin: 10px auto;
        text-align: center;
        max-width: 500px;
        width: 90%;
    }

    .highcharts-data-table caption {
        padding: 1em 0;
        font-size: 1.1e;
        color: #FFFF;
    }

    .highcharts-data-table tr: background: bed
    }
    .highchats-data t font-w; padding: 0.5em;
    }

    ghcharts-data-table td .highch r th,
    .highc - padding: 0.6em;
    }

    .highcharts-data-table thead tr,
    .highcharts-data-table tr:nth-child(even) {
        background: #f8f8f8;
    }
</style>
