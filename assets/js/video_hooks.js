var remoteUser = { peerConnection: null }
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

function createPeerConnection(lv, offer) {
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
                lv.pushEvent("answer", { description: answer })
            })
            .catch((err) => console.log(err))
    }

    newPeerConnection.onicecandidate = async ({ candidate }) => {
        lv.pushEvent("ice_candidate", { candidate })
    }

    if (offer === undefined) {
        newPeerConnection.onnegotiationneeded = async () => {
            try {
                newPeerConnection.createOffer()
                    .then((offer) => {
                        newPeerConnection.setLocalDescription(offer)
                        lv.pushEvent("sdp_offer", { description: offer })
                    })
                    .catch((err) => console.log(err))
            }
            catch (error) {
                console.log(error)
            }
        }
    }

    newPeerConnection.ontrack = async (event) => {
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

Hooks.HandleOfferRequest = {
    mounted() {
        createPeerConnection(this)
    }
}
Hooks.HandleIceCandidateOffer = {
    mounted() {
        let data = this.el.dataset
        let iceCandidate = JSON.parse(data.iceCandidate)
        let peerConnection = remoteUser.peerConnection

        peerConnection.addIceCandidate(iceCandidate)
    }
}

Hooks.HandleSdpOffer = {
    mounted() {
        let data = this.el.dataset
        let sdp = data.sdp

        if (sdp != "") {
            createPeerConnection(this, sdp)
        }
    }
}

Hooks.HandleAnswer = {
    mounted() {
        let data = this.el.dataset
        let sdp = data.sdp
        let peerConnection = remoteUser.peerConnection

        if (sdp != "") {
            peerConnection.setRemoteDescription({ type: "answer", sdp: sdp })
        }
    }
}

export default Hooks