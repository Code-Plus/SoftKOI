class Notifications
  constructor: ->
    @notifications = $("[data-behavior='notifications']")
    @setup() if @notifications.length > 0

  setup: ->
    $("[data-behavior='notifications-link']").on "click", @handleClick
    $.ajax(
      url: "/notifications.json"
      dataType: "JSON"
      method: "GET"
      success: @handleSuccess
    )

  handleClick: (e) =>
    $.ajax(
      url: "/notifications/read"
      dataType: "JSON"
      method: "POST"
      success: ->
        $("[data-behavior='unread-count']").text(0)
    )
  handleSuccess: (data) =>
    items = $.map data, (notification) ->
      "<i class='fa fa-flag' aria-hidden='true'></i>&nbsp;<a class='dropdown-item' href='#'> #{notification.trackable} #{notification.key}</a><hr style='border: 1; margin-top: 9px; margin-bottom: 0px;'><br>"

    $("[data-behavior='unread-count']").text(items.length)
    $("[data-behavior= 'notifications-items']").html(items)
    checknotification()
jQuery ->
  new Notifications
