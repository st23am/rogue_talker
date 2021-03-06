defmodule Rogue do
  import PortUtils
  use GenServer

  ## Server
  def handle_call({:command_rogue, port, command}, _from, []) do
    send(port, {self, {:command, command }})
    gather_intel(port)
    {:reply, {:ok, "command sent"}, []}
  end

  def handle_call(:start_game, _from, []) do
    port = PortUtils.open_port("rogue")
    gather_intel(port)
    {:reply, {:ok, port}, []}
  end

  def handle_call(:get_intel, _from, []) do
    intel = "#{List.last(Agent.get(RogueAgent, fn(state) -> state end))}"
    {:reply, intel, []}
  end

  def gather_intel(port) do
    receive do
      {^port, {:data, new_data}} ->
        Agent.update(RogueAgent, fn(state) -> Enum.concat(state, [new_data]) end)
      {^port, {:exit_status, status}} ->
        PortUtils.close(port)
    end
  end

  ## Client
  def start do
   {:ok, pid} = GenServer.start_link(Rogue, [])
   {:ok, port} = GenServer.call(pid, :start_game)
   {pid, port}
  end

  def stop({_pid, port}) do
    Port.close(port)
  end

  def command({pid, port}, command) do
    GenServer.call(pid, {:command_rogue, port, command})
  end

  def show({pid, port}) do
    redraw({pid, port})
    msg = GenServer.call(pid, :get_intel)
    IO.puts(IO.ANSI.clear() <> IO.ANSI.reset() <> IO.ANSI.green() <> msg <> IO.ANSI.reset() <> IO.ANSI.home())
  end

  defp redraw({pid, port}) do
    #Hack to get Rogue to redraw
    GenServer.call(pid, {:command_rogue, port, "?"}) #"
    GenServer.call(pid, {:command_rogue, port, "*"})
    GenServer.call(pid, {:command_rogue, port, " "})
  end
end
