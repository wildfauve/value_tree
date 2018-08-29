defmodule ProductIdify do

  alias Value

  def call(product) do
    products([product])
  end

  defp products([p|xs]) do
    [
      name_value(p, :product),
      non_recursive_collection({:variants, p["variant"]}) ++ non_recursive_collection({:config_requirement, p["configuration_requirements"]}) ++ products(p["products"]) ++ products(xs)
    ]
  end
  defp products([]), do: []
  defp products(nil), do: []

  defp non_recursive_collection({type, [x|xs]}) do
    [ name_value(x, type) | non_recursive_collection({type, xs})]
  end
  defp non_recursive_collection({_type, []}), do: []
  defp non_recursive_collection({_type, nil}), do: []

  defp name_value(struct, type) do
    %Val{ id: struct["id"], value: struct["name"], type: type}
  end

end
