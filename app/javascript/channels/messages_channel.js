import consumer from "./consumer"

consumer.subscriptions.create("CommentsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    roomId = $("#chat-box").data("room-id")
    checkIn(roomId)
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    posts = $(".message-row").length
    if (posts == 10)
      $(".message-row").first().remove()

    $("#chat-box").append(data),
    $("#message-field").val('')
    }
    ,

  checkIn(roomId) {
    if (roomId) {
      this.perform('checkIn', {room_id: roomId} )
    }
    else{
      this.perform('checkOut')
    }
  }
});
