var localStream
async function initStream() {
    try {
        // Gets our local media from the browser and stores it as a const, stream.
        const stream = await navigator.mediaDevices.getUserMedia({ audio: true, video: true, width: "1280" })
        localStream = stream;
        // Sets our local video element to stream from the user's webcam (stream).
        document.getElementById("local-video").srcObject = stream
        document.getElementById("local-video-test").srcObject = stream
    } catch (e) {
        console.log(e)
    }
}

let Hooks = {}
Hooks.JoinCall = {
    mounted() {
        initStream()
    }
}

export default Hooks