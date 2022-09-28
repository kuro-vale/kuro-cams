var remoteUser = {}
var localStream
async function initStream() {
    try {
        const stream = await navigator.mediaDevices.getUserMedia({ audio: true, video: true, width: "1280" })
        localStream = stream;
        document.getElementById("local-video").srcObject = stream
    } catch (e) {
        console.log(e)
    }
}

function createPeerConnection(lv, fromUser, offer) {
    let newPeerConnection = new RTCPeerConnection({
        iceServers: [
            { urls: "stun:127.0.0.1:3478" }
        ]
    })

    remoteUser.peerConnection = newPeerConnection;

    localStream.getTracks().forEach(track => newPeerConnection.addTrack(track, localStream))

    if (offer !== undefined) {
        newPeerConnection.setRemoteDescription({ type: "offer", sdp: offer })
        newPeerConnection.createAnswer()
            .then((answer) => {
                newPeerConnection.setLocalDescription(answer)
                console.log("Sending this ANSWER to the requester:", answer)
                lv.pushEvent("answer", { toUser: fromUser, description: answer })
            })
            .catch((err) => console.log(err))
    }

    newPeerConnection.onicecandidate = async ({ candidate }) => {
        lv.pushEvent("ice_candidate", { toUser: fromUser, candidate })
    }

    if (offer === undefined) {
        newPeerConnection.onnegotiationneeded = async () => {
            try {
                newPeerConnection.createOffer()
                    .then((offer) => {
                        newPeerConnection.setLocalDescription(offer)
                        console.log("Sending this OFFER to the requester:", offer)
                        lv.pushEvent("sdp_offer", { toUser: fromUser, description: offer })
                    })
                    .catch((err) => console.log(err))
            }
            catch (error) {
                console.log(error)
            }
        }
    }

    newPeerConnection.ontrack = async (event) => {
        console.log("Track received:", event)
        document.getElementById("remote-video").srcObject = event.streams[0]
    }

    return newPeerConnection;
}

let Hooks = {}
Hooks.JoinCall = {
    mounted() {
        initStream()
    }
}

Hooks.InitUser = {
    mounted() {
        remoteUser = { peerConnection: null }
    },

    destroyed() {
        remoteUser = {}
    }
}

Hooks.HandleOfferRequest = {
    mounted() {
        let fromUser = this.el.dataset.fromUserId
        console.log("new offer request from", fromUser)
        createPeerConnection(this, fromUser)
    }
}
Hooks.HandleIceCandidateOffer = {
    mounted() {
        let data = this.el.dataset
        let fromUser = data.fromUserId
        let iceCandidate = JSON.parse(data.iceCandidate)
        let peerConnection = remoteUser.peerConnection

        console.log("new ice candidate from", fromUser, iceCandidate)

        peerConnection.addIceCandidate(iceCandidate)
    }
}

Hooks.HandleSdpOffer = {
    mounted() {
        let data = this.el.dataset
        let fromUser = data.fromUserId
        let sdp = data.sdp

        if (sdp != "") {
            console.log("new sdp OFFER from", data.fromUser, data.sdp)

            createPeerConnection(this, fromUser, sdp)
        }
    }
}

Hooks.HandleAnswer = {
    mounted() {
        let data = this.el.dataset
        let fromUser = data.fromUserId
        let sdp = data.sdp
        let peerConnection = remoteUser.peerConnection

        if (sdp != "") {
            console.log("new sdp ANSWER from", fromUser, sdp)
            peerConnection.setRemoteDescription({ type: "answer", sdp: sdp })
        }
    }
}

export default Hooks