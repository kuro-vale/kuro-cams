import { Socket, Presence } from "phoenix"

if (window.userToken != "") {
    let chat_socket = new Socket("/chat", { params: { token: window.userToken } })
    let presence_channel = chat_socket.channel("room:lobby")
    let presence = new Presence(presence_channel)

    function renderOnlineUsers(presence) {
        let badges = document.getElementsByName("presence_badges")
        badges.forEach(function (badge) {
            badge.className = "px-2 py-1 font-semibold leading-tight text-red-700 bg-red-100 rounded-full dark:text-red-100 dark:bg-red-700"
            badge.innerText = "Offline"
        })
        presence.list((id) => {
            let presence_badge = document.getElementById(`${id}_presence`)
            if (presence_badge) {
                presence_badge.className = "px-2 py-1 font-semibold leading-tight text-green-700 bg-green-100 rounded-full dark:bg-green-700 dark:text-green-100"
                presence_badge.innerText = "Online"
            }
        })
    }

    chat_socket.connect()

    presence.onSync(() => renderOnlineUsers(presence))
    presence_channel.join()
    window.chat_socket = chat_socket
}
