<figure class="highcharts-figure_bar">
    <div id="highcharts_div"></div>
</figure>
<script src="https://code.highcharts.com/highcharts.src.js"></script>
<script src="datepick/jquery-1.4.2.min.js"></script>
<script type="text/javascript">
    $(function () { 
        PopulateDashboard_Details();  
    });


    function PopulateDashboard_Details() {
        $.ajax({
            type: "POST",
            url: 'Services.aspx/GetSalesData',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSalesTargetReportPopulated,
            failure: function (response) { alert(response.d); }
        });
    }

    function OnSalesTargetReportPopulated(response) {
        if (response.d.length > 0) {
            var Month_Name = []; 
            var Total_Sales = []; 
            var TPV_GPV_Invoice_Amount = [];
            var GPV_TPV = [];
            var Loyalty = [];
           
            Month_Name.length = 0;
            
            Loyalty.length = 0;
            Total_Sales.length = 0; 
            TPV_GPV_Invoice_Amount.length = 0;
            GPV_TPV.length = 0;

            for (var j = 0; j < response.d.length; j++) {
                Month_Name.push(response.d[j].MonthName);
                //Online_Sales.push(parseFloat(response.d[j].Online_Sales));
                //Offline_Sales.push(parseFloat(response.d[j].Offline_Sales));
                
                Total_Sales.push(parseFloat(response.d[j].TotalSales));
                TPV_GPV_Invoice_Amount.push(parseFloat(response.d[j].TPV_GPV_Invoice_Amount));
                GPV_TPV.push(parseFloat(response.d[j].GPV_TPV));
                Loyalty.push(parseFloat(response.d[j].Loyalty));
            }
            GetSalesChart(Month_Name, Total_Sales, TPV_GPV_Invoice_Amount, GPV_TPV, Loyalty);
        }
    }

    function GetSalesChart(Month_Name, Total_Sales, TPV_GPV_Invoice_Amount, GPV_TPV, Loyalty) {

        Highcharts.chart('highcharts_div', {
            chart: { type: 'column' },
            title: { text: '' }, 
            subtitle: { text: '&nbsp; ' },
            xAxis: { categories: Month_Name, crosshair: true },
            yAxis: { min: 0, title: { text: 'Primary Sales', align: 'high' }, },
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
                { name: 'Primary', color: '#003f5c', data: Total_Sales },
                //{ name: 'Franchise', color: '#0f4076', data: Franchise_Sales },

                { name: 'Secondary', color: '#58508d', data: TPV_GPV_Invoice_Amount },
                { name: 'GPV', color: '#bc5090', data: GPV_TPV },
               
                { name: 'Loyalty', color: '#ff6361', data: Loyalty },
                //{ name: 'Online', color: '#d4e10b', data: Online_Sales },


               // { name: 'Total', color: '#fe6a00', data: Total_Sales },
                //{ name: 'Franchise', color: '#0f4076', data: Franchise_Sales },

               // { name: 'Secondary', color: '#f108df', data: TPV_GPV_Invoice_Amount },
              //  { name: 'GPV', color: '#3eeafb', data: GPV_TPV },

                //{ name: 'Loyalty', color: '#34b10b', data: Loyalty },
                //{ name: 'Online', color: '#d4e10b', data: Online_Sales },
            ]
        });
    }
</script>


<style type="text/css"> 
    .highcharts-data-table table, highcharts-figure_bar {
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
 
