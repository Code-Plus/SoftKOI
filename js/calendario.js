  $(document).ready(function() {
                var date = new Date();
                var d = date.getDate();
                var m = date.getMonth();
                var y = date.getFullYear();

                var cId = $('#calendar'); 

                //se crea el calendario
                cId.fullCalendar({
                    header: {
                        right: '',
                        center: 'prev, title, next',
                        left: ''
                    },

                    theme: true, //Do not remove this as it ruin the design
                    selectable: true,
                    selectHelper: true,
                    editable: true,

                    //Add Events
                    events: [
                        {
                            title: 'ir con amigos',
                            start: new Date(y, m, 1),
                            end: new Date(y, m, 2),
                            className: 'bgm-cyan'
                        },
                        {
                            title: 'encontrarse con clientes',
                            start: new Date(y, m, 10),
                            allDay: true,
                            className: 'bgm-red'
                        },
                        {
                            title: 'repetir evento',
                            start: new Date(y, m, 18),
                            allDay: true,
                            className: 'bgm-blue'
                        },
                        {
                            title: 'ir a trabajar',
                            start: new Date(y, m, 20),
                            end: new Date(y, m, 23),
                            className: 'bgm-green'
                        },
                        {
                            title: 'terminar calendario',
                            start: new Date(y, m, 5),
                            end: new Date(y, m, 6),
                            className: 'bgm-purple'
                        },
                        {
                            title: 'tomar cafe',
                            start: new Date(y, m, 21),
                            className: 'bgm-orange'
                        },
                        {
                            title: 'ir a entrevista de trabajo',
                            start: new Date(y, m, 5),
                            className: 'bgm-dark'
                        },
                        {
                            title: 'conecer lenguajes nuevos',
                            start: new Date(y, m, 5),
                            className: 'bgm-cyan'
                        },
                        {
                            title: 'tomarse unas vacaciones',
                            start: new Date(y, m, 1),
                            className: 'bgm-purple'
                        },
                        {
                            title: 'ver TV',
                            start: new Date(y, m, 15),
                            end: new Date(y, m, 17),
                            className: 'bgm-orange'
                        },
                        {
                            title: 'ir a conferencia de software',
                            start: new Date(y, m, 25),
                            end: new Date(y, m, 28),
                            className: 'bgm-blue'
                        },
                        {
                            title: 'tiempo de cafe',
                            start: new Date(y, m, 30),
                            className: 'bgm-orange'
                        },
                        {
                            title: 'ir a entrevista de',
                            start: new Date(y, m, 30),
                            className: 'bgm-dark'
                        },
                    ],
                     
                    //On Day Select
                    select: function(start, end, allDay) {
                        $('#addNew-event').modal('show');   
                        $('#addNew-event input:text').val('');
                        $('#getStart').val(start);
                        $('#getEnd').val(end);
                    }
                });

                //Create and ddd Action button with dropdown in Calendar header. 
                var actionMenu = '<ul class="actions actions-alt" id="fc-actions">' +
                                    '<li class="dropdown">' +
                                        '<a href="" data-toggle="dropdown"><i class="ellipsis vertical icon"></i></a>' +
                                        '<ul class="dropdown-menu dropdown-menu-right">' +
                                            '<li class="active">' +
                                                '<a data-view="month" href="">Month View</a>' +
                                            '</li>' +
                                            '<li>' +
                                                '<a data-view="basicWeek" href="">Week View</a>' +
                                            '</li>' +
                                            '<li>' +
                                                '<a data-view="agendaWeek" href="">Agenda Week View</a>' +
                                            '</li>' +
                                            '<li>' +
                                                '<a data-view="basicDay" href="">Day View</a>' +
                                            '</li>' +
                                            '<li>' +
                                                '<a data-view="agendaDay" href="">Agenda Day View</a>' +
                                            '</li>' +
                                        '</ul>' +
                                    '</div>' +
                                '</li>';


                cId.find('.fc-toolbar').append(actionMenu);
                
                //Event Tag Selector
                (function(){
                    $('body').on('click', '.event-tag > span', function(){
                        $('.event-tag > span').removeClass('selected');
                        $(this).addClass('selected');
                    });
                })();
            
                //Add new Event
                $('body').on('click', '#addEvent', function(){
                    var eventName = $('#eventName').val();
                    var tagColor = $('.event-tag > span.selected').attr('data-tag');
                        
                    if (eventName != '') {
                        //Render Event
                        $('#calendar').fullCalendar('renderEvent',{
                            title: eventName,
                            start: $('#getStart').val(),
                            end:  $('#getEnd').val(),
                            allDay: true,
                            className: tagColor
                            
                        },true ); //Stick the event
                        
                        $('#addNew-event form')[0].reset()
                        $('#addNew-event').modal('hide');
                    }
                    
                    else {
                        $('#eventName').closest('.form-group').addClass('has-error');
                    }
                });   

                //Calendar views
                $('body').on('click', '#fc-actions [data-view]', function(e){
                    e.preventDefault();
                    var dataView = $(this).attr('data-view');
                    
                    $('#fc-actions li').removeClass('active');
                    $(this).parent().addClass('active');
                    cId.fullCalendar('changeView', dataView);  
                });
            });                        