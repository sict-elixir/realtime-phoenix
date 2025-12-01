import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// This line is required now
socket.connect()

export default socket