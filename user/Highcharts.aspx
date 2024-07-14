<figure class="highcharts-figure">
    <div id="highcharts_div"></div>
</figure>
<script src="https://code.highcharts.com/highcharts.src.js"></script>
<script src="datepick/jquery-1.4.2.min.js"></script>
<script type="text/javascript">

    $(function () {
         
        PopulateDashboard_Details();
       // var IdleInterval = setInterval("PopulateDashboard_Details()", 300000);
        //Message ('Auto Call');
        function PopulateDashboard_Details() {
            $.ajax({
                type: "POST",
                url: 'UserServices.aspx/GetSalesData',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSalesTargetReportPopulated,
                failure: function (response) {
                    alert(response.d);
                }
            });
        }

        function OnSalesTargetReportPopulated(response) {
            if (response.d.length > 0) {
                var Month_Name = [];
                var Joining_Sales = [];
                var Package_Sales = [];
                var Repurchase_Sales = [];
                var Total_Sales = [];

                Month_Name.length = 0;
                Joining_Sales.length = 0;
                Package_Sales.length = 0;
                Repurchase_Sales.length = 0;
                Total_Sales.length = 0;

                for (var j = 0; j < response.d.length; j++) {
                    Month_Name.push(response.d[j].MonthName);
                    Joining_Sales.push(parseFloat(response.d[j].JoiningSales));
                    Package_Sales.push(parseFloat(response.d[j].PackageSales));
                    Repurchase_Sales.push(parseFloat(response.d[j].RepurchaseSales));
                    Total_Sales.push(parseFloat(response.d[j].TotalSales));
                }
                GetSalesChart(Month_Name, Joining_Sales, Package_Sales, Repurchase_Sales, Total_Sales);
            }
        }

        function GetSalesChart(Month_Name, Joining_Sales, Package_Sales, Repurchase_Sales, Total_Sales) {

            Highcharts.chart('highcharts_div', {
                chart: { type: 'column' },
                title: { text: '' },
                //subtitle: { text: 'Report ' + new Date().getFullYear() },
                subtitle: { text: '&nbsp; '},
                xAxis: { categories: Month_Name, crosshair: true },
                yAxis: { min: 0, title: { text: 'Sales in (PV)', align: 'high' }, },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                    '<td style="padding:0"><b>{point.y:.0f}</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: { column: { pointPadding: 0.2, borderWidth: 0 } },
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
                    { name: 'Generation Sales', color: '#fe6a00', data: Repurchase_Sales }
                    //{ name: 'Topper Sales', color: '#d1d2d4', data: Package_Sales },
                    //{ name: 'Total Sales', color: '#0f306f', data: Total_Sales }
                ]
            });
        }
    });

</script>
<style type="text/css">
   

    .highcharts-data-table table, highcharts-figure {
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
 