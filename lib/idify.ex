defmodule Idify do

  def call(tree) do
    values(tree.children)
    |> flatten
  end

  def values([%{tuple: t, children: c}|xs]), do: [t, values(c) ++ values(xs)]
  def values([]), do: []

  def flatten([x|xs]), do: flatten(x) ++ flatten(xs)
  def flatten([]), do: []
  def flatten(id), do: [id]

end
