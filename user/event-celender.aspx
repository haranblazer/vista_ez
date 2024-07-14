<%@ Page Title="" Language="C#" MasterPageFile="~/user/user.master" AutoEventWireup="true" CodeFile="event-celender.aspx.cs" Inherits="user_event_celender" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
                    <div class="container-fluid page__heading-container">
                        <div class="page__heading d-flex align-items-center">
                            <div class="flex">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb mb-0">
                                        <li class="breadcrumb-item"><a href="#"><i class="material-icons icon-20pt">home</i></a></li>
                                        <li class="breadcrumb-item">Apps</li>
                                        <li class="breadcrumb-item active" aria-current="page">Event Calendar</li>
                                    </ol>
                                </nav>
                                <h1 class="m-0">Event Calendar</h1>
                            </div>
                            <a href="" data-toggle="modal" data-target="#add-category" class="btn btn-success ml-3">New Event</a>
                        </div>
                    </div>
                    <div class="container-fluid page__container">
                        <div class="row">
                            <div class="col-lg-9">
                                <div class="card card-body">
                                    <div id="calendar" data-toggle="fullcalendar"></div>
                                </div>
                            </div><!-- end col -->
                            <div class="col-lg-3">
                                <div id="external-events">
                                    <p class="text-muted">Drag and drop your event or click in the calendar.</p>
                                    <div class="external-event bg-success" data-class="bg-success">
                                        <i class="mr-2 material-icons">drag_handle</i>
                                        <span class="external-event__title">New Theme Release</span>
                                    </div>
                                    <div class="external-event bg-info" data-class="bg-info">
                                        <i class="mr-2 material-icons">drag_handle</i>
                                        <span class="external-event__title">My Event</span>
                                    </div>
                                    <div class="external-event bg-warning" data-class="bg-warning">
                                        <i class="mr-2 material-icons">drag_handle</i>
                                        <span class="external-event__title">Meet manager</span>
                                    </div>
                                    <div class="external-event bg-danger" data-class="bg-danger">
                                        <i class="mr-2 material-icons">drag_handle</i>
                                        <span class="external-event__title">Create New theme</span>
                                    </div>
                                </div>
                                <!-- checkbox -->
                                <div class="custom-control custom-checkbox">
                                    <input type="checkbox" class="custom-control-input" id="drop-remove">
                                    <label class="custom-control-label" for="drop-remove">Remove after drop</label>
                                </div>
                            </div> <!-- end col-->
                        </div> <!-- end row -->
                    </div>
                    </div>
                    <!-- App Settings FAB -->
    <div id="app-settings">
      <%--  <app-settings layout-active="default" :layout-location="{
      'default': 'app-fullcalendar.html',
      'fixed': 'fixed-app-fullcalendar.html',
      'fluid': 'fluid-app-fullcalendar.html',
      'mini': 'mini-app-fullcalendar.html'
    }"></app-settings>--%>
    </div>
                     <!-- jQuery UI (for draggable) -->
    <script src="assets/vendor/jquery-ui.min.js"></script>

    <!-- Moment.js -->
    <script src="assets/vendor/moment.min.js"></script>

    <!-- FullCalendar -->
    <%--<script src="assets/vendor/fullcalendar/fullcalendar.min.js"></script>
    <script src="assets/js/fullcalendar.js" type="text/javascript"></script>--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.js"></script>
    <script>
    $(document).ready(function() {
		
		$('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
			},
			defaultDate: '2014-06-12',
			defaultView: 'month',
			editable: true,
			events: [
				{
					title: 'All Day Event',
					start: '2014-06-01'
				},
				{
					title: 'Long Event',
					start: '2014-06-07',
					end: '2014-06-10'
				},
				{
					id: 999,
					title: 'Repeating Event',
					start: '2014-06-09T16:00:00'
				},
				{
					id: 999,
					title: 'Repeating Event',
					start: '2014-06-16T16:00:00'
				},
				{
					title: 'Meeting',
					start: '2014-06-12T10:30:00',
					end: '2014-06-12T12:30:00'
				},
				{
					title: 'Lunch',
					start: '2014-06-12T12:00:00'
				},
				{
					title: 'Birthday Party',
					start: '2014-06-13T07:00:00'
				},
				{
					title: 'Click for Google',
					url: 'http://google.com/',
					start: '2014-06-28'
				}
			]
		});

});
    </script>

</asp:Content>

