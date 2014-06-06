defmodule RogueTalker do
  use Application

  # See http://elixir-lang.org/docs/stable/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      # worker(RogueTalker.Worker, [arg1, arg2, arg3])
      worker(RogueAgent, [])
    ]

    # See http://elixir-lang.org/docs/stable/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RogueTalker.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
