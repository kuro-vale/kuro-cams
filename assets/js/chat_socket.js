import { Socket } from "phoenix"

let chat_socket = new Socket("/chat", { params: { token: window.userToken } })

chat_socket.connect()

window.chat_socket = chat_socket