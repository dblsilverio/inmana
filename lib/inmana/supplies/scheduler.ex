defmodule Inmana.Supplies.Scheduler do
  use GenServer

  alias Inmana.Supplies.ExpirationNotification

  # Client
  def start_link(_state) do
    GenServer.start_link(__MODULE__, %{})
  end

  # Server
  @impl true
  def init(state \\ %{}) do
    schedule_notification()

    {:ok, state}
  end

  # Async
  @impl true
  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  # Sync
  @impl true
  def handle_call({:get, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end

  @impl true
  def handle_info(:generate, state) do
    ExpirationNotification.send()

    schedule_notification()

    {:noreply, state}
  end

  defp schedule_notification() do
    # 24h scheduler
    Process.send_after(self(), :generate, 86_400_000)
  end
end
