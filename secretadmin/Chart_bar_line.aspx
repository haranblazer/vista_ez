<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/series-label.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
<script src="datepick/jquery-1.4.2.min.js"></script>

<figure class="highcharts-figure_Bar_Line">
    <div id="container_Bar_Line"></div>
</figure>

<script type="text/javascript">
    $(function () {
        PopulateDashboard_Details_Bar_Line();
    });


    function PopulateDashboard_Details_Bar_Line() {
        $.ajax({
            type: "POST",
            url: 'Services.aspx/Get_Monthwise_Chart_Report_Admin',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSalesTargetReportPopulated_Bar_Line,
            failure: function (response) { alert(response.d); }
        });
    }

    function OnSalesTargetReportPopulated_Bar_Line(data) {
      
        if (data.d.length > 0) {

            var MainData = [];
            MainData.length = 0;

            var Month_Name = [];
            Month_Name.length = 0;

            var New_Members = [];
            New_Members.length = 0;
            var New_Paid_Members = [];
            New_Paid_Members.length = 0;
            var New_Unpaid = [];
            New_Unpaid.length = 0;
            var Purchasing_Members = [];
            Purchasing_Members.length = 0;
            var Booster_Mem = [];
            Booster_Mem.length = 0;

            var New_Members_Per = [];
            New_Members_Per.length = 0;
            var New_Paid_Members_Per = [];
            New_Paid_Members_Per.length = 0;
            var New_Unpaid_Per = [];
            New_Unpaid_Per.length = 0;
            var Purchasing_Members_Per = [];
            Purchasing_Members_Per.length = 0;
            var Booster_Mem_Per = [];
            Booster_Mem_Per.length = 0;
 

            for (var j = 0; j < data.d.length; j++) {
                Month_Name.push(data.d[j].MonthName);

                New_Members.push(parseFloat(data.d[j].New_Members));
                New_Paid_Members.push(parseFloat(data.d[j].New_Paid_Members));
                New_Unpaid.push(parseFloat(data.d[j].New_Unpaid));
                Purchasing_Members.push(parseFloat(data.d[j].Purchasing_Members));
                Booster_Mem.push(parseFloat(data.d[j].Booster_Mem));

                New_Members_Per.push(data.d[j].New_Members_Per);
                New_Paid_Members_Per.push(data.d[j].New_Paid_Members_Per);
                New_Unpaid_Per.push(data.d[j].New_Unpaid_Per);
                Purchasing_Members_Per.push(data.d[j].Purchasing_Members_Per);
                Booster_Mem_Per.push(data.d[j].Booster_Mem_Per);

                MainData.push({ MonthName: data.d[j].MonthName,
                    New_Members: data.d[j].New_Members, New_Paid_Members: data.d[j].New_Paid_Members, New_Unpaid: data.d[j].New_Unpaid,
                    Purchasing_Members: data.d[j].Purchasing_Members, Booster_Mem: data.d[j].Booster_Mem, 
                    New_Members_Per: data.d[j].New_Members_Per,
                    New_Paid_Members_Per: data.d[j].New_Paid_Members_Per, New_Unpaid_Per: data.d[j].New_Unpaid_Per,
                    Purchasing_Members_Per: data.d[j].Purchasing_Members_Per, Booster_Mem_Per: data.d[j].Booster_Mem_Per
                });


            }
            GetSalesChart_Bar_Line(MainData, Month_Name, New_Members, New_Paid_Members, New_Unpaid, Purchasing_Members, Booster_Mem,
                New_Members_Per, New_Paid_Members_Per, New_Unpaid_Per, Purchasing_Members_Per, Booster_Mem_Per);
        }
    }

    function GetSalesChart_Bar_Line(MainData, Month_Name, New_Members, New_Paid_Members, New_Unpaid, Purchasing_Members, Booster_Mem,
        New_Members_Per, New_Paid_Members_Per, New_Unpaid_Per, Purchasing_Members_Per, Booster_Mem_Per) {
  
        Highcharts.chart('container_Bar_Line', {
            title: { text: '' },
            xAxis: { categories: Month_Name },
            yAxis: { title: { text: 'Monthly Member Detail' } },
            tooltip: {
                formatter: function () { 
                    var s = '<span style="font-size:10px">' + this.x + '</span> <br/';
                    for (var i = 0; i < MainData.length; i++) {
                        if (MainData[i].MonthName == this.x) {
                            s += '<span> New Mem.: ' + MainData[i].New_Members +' </span>:<span style="padding:0"> (' + Highcharts.numberFormat(MainData[i].New_Members_Per) + '%)</span><br/>'
                            s += '<span> New Paid: ' + MainData[i].New_Paid_Members +' </span>: <span style="padding:0">  (' + Highcharts.numberFormat(MainData[i].New_Paid_Members_Per) + '%)</span><br/>'
                            s += '<span> New Unpaid: ' + MainData[i].New_Unpaid +' </span>: <span style="padding:0"> (' + Highcharts.numberFormat(MainData[i].New_Unpaid_Per) + '%)</span><br/>'
                            s += '<span> Purch. Mem.: ' + MainData[i].Purchasing_Members +' </span>: <span style="padding:0"> (' + Highcharts.numberFormat(MainData[i].Purchasing_Members_Per) + '%)</span><br/>'
                            //s += '<span> Booster. Mem.: ' + MainData[i].Booster_Mem +' </span>: <span style="padding:0"> (' + Highcharts.numberFormat(MainData[i].Booster_Mem_Per) + '%)</span><br/>'
                        } 
                    }
                    return s; 
                },
                shared: true
            }, 
            chart: { type: 'column' },
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
            series: [
                { name: 'New Mem.', color: '#003f5c' , data: New_Members },
                //{
                   // type: 'spline', name: 'Avg', data: New_Members
                    //type: 'spline', name: 'Avg', data: New_Members, markerColor: "red",
                    //marker: { lineWidth: 5, lineColor: Highcharts.getOptions().colors[3], fillColor: 'white' }
               // },

                { name: 'New Paid', color: '#58508d', data: New_Paid_Members },
                //{
                    //type: 'spline', name: 'Avg', data: New_Paid_Members,
                    //marker: { lineWidth: 5, lineColor: Highcharts.getOptions().colors[3], fillColor: 'white' }
               // },

                { name: 'New Unpaid', color: '#bc5090', data: New_Unpaid },
               // {
                    //type: 'spline', name: 'Avg', data: New_Unpaid,
                   // marker: { lineWidth: 5, lineColor: Highcharts.getOptions().colors[3], fillColor: 'white' }
               // },

                { name: 'Purch. Mem.', color: '#ff6361', data: Purchasing_Members },
                //{
                    //type: 'spline', name: 'Avg', data: Purchasing_Members,
                    //marker: { lineWidth: 5, lineColor: Highcharts.getOptions().colors[3], fillColor: 'white' }
                //},

               // { name: 'Booster. Mem.', color: '#ffa600', data: Booster_Mem },
               // {
                    //type: 'spline', name: 'Avg', data: Booster_Mem,
                    //marker: { lineWidth: 5, lineColor: Highcharts.getOptions().colors[3], fillColor: 'white' }
                //},
            ]
        });

    }
</script>


<style>
    .highcharts-figure_Bar_Line,
    .highcharts-data-table table {
        /*  min-width: 310px;
        max-width: 800px;*/
        margin: 1em auto;
    }

    #container_Bar_Line {
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

