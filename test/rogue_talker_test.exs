defmodule RogueTalkerTest do
  use ExUnit.Case

  # test "rogue retrieves nil when the rogue agent has no intel" do
  #   Rogue.start_game
  #   assert(Rogue.get_intel() == nil)
  # end
  # test "rogue retrieves intel from the rogue agent" do
  #   Rogue.start_game
  #   Agent.cast(RogueAgent, fn(state) ->
  #                              Enum.concat(state, [{:pid, "pid",{:data, "foo"}}]) end)
  #   assert(Rogue.get_intel() == {:pid, "pid", {:data, "foo"}})
  # end

  # test "gets the last message" do
  #   Rogue.start_game
  #   Agent.update(RogueAgent, fn(state) ->
  #                              Enum.concat(state, [{:pid, "pid",{:data, "foo"}}]) end)
  #   Agent.update(RogueAgent, fn(state) ->
  #                              Enum.concat(state, [{:pid, "pid",{:data, "bar"}}]) end)
  #  assert(Rogue.get_intel() == {:pid, "pid", {:data, "bar"}})
  # end
end
