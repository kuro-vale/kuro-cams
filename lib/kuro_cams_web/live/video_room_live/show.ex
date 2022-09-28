defmodule KuroCamsWeb.VideoRoomLive.Show do
  use KuroCamsWeb, :live_view

  alias KuroCams.Cams
  alias Phoenix.Socket.Broadcast

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"uuid" => uuid}, _, socket) do
    Phoenix.PubSub.subscribe(
      KuroCams.PubSub,
      "room:" <> uuid
    )

    {:noreply,
     socket
     |> assign(:video_room, Cams.get_video_room_by_uuid(uuid))
     |> assign(:offer_request, nil)
     |> assign(:ice_candidate_offer, nil)
     |> assign(:sdp_offer, nil)
     |> assign(:answer, nil)}
  end

  @impl true
  def handle_event("join_call", _params, socket) do
    send_direct_message(
      socket.assigns.video_room.uuid,
      "request_offer",
      %{}
    )

    {:noreply, socket}
  end

  @impl true
  def handle_event("ice_candidate", payload, socket) do
    send_direct_message(
      socket.assigns.video_room.uuid,
      "ice_candidate",
      payload
    )

    {:noreply, socket}
  end

  @impl true
  def handle_event("sdp_offer", payload, socket) do
    send_direct_message(
      socket.assigns.video_room.uuid,
      "sdp_offer",
      payload
    )

    {:noreply, socket}
  end

  @impl true
  def handle_event("answer", payload, socket) do
    send_direct_message(
      socket.assigns.video_room.uuid,
      "answer",
      payload
    )

    {:noreply, socket}
  end

  def handle_info(%Broadcast{event: "request_offer", payload: request}, socket) do
    {:noreply,
     socket
     |> assign(:offer_request, request)}
  end

  @impl true
  def handle_info(%Broadcast{event: "ice_candidate", payload: payload}, socket) do
    {:noreply,
     socket
     |> assign(:ice_candidate_offer, payload)}
  end

  @impl true
  def handle_info(%Broadcast{event: "sdp_offer", payload: payload}, socket) do
    {:noreply,
     socket
     |> assign(:sdp_offer, payload)}
  end

  @impl true
  def handle_info(%Broadcast{event: "answer", payload: payload}, socket) do
    {:noreply,
     socket
     |> assign(:answer, payload)}
  end

  defp send_direct_message(uuid, event, payload) do
    KuroCamsWeb.Endpoint.broadcast_from(
      self(),
      "room:" <> uuid,
      event,
      payload
    )
  end
end
