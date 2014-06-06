defmodule RogueAgent do
  @name  __MODULE__
  def start_link  do
    Agent.start_link(fn -> [] end, name: @name)
  end
end