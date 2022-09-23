defmodule KuroCamsWeb.VideoRoomLive.Show do
  use KuroCamsWeb, :live_view

  alias KuroCams.Cams

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"uuid" => uuid}, _, socket) do
    {:noreply,
     socket
     |> assign(:video_room, Cams.get_video_room_by_uuid(uuid))}
  end
end
