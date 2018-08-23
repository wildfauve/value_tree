defmodule Rater do

  def call(tree) do
    Idify.call(tree)
    |> rating(rules(tree.tuple), base_rate(tree.tuple))
  end

  # List.foldl([5, 5], 10, fn x, acc -> x + acc end)

  defp rating(ids, rules, base_price) do
    List.foldl(rules, base_price, fn rule, price -> option_rating(rule, ids, price ) end)
  end

  defp base_rate(%Val{id: "urn:lic:product:allflex:premium_calf_pack", value: _}), do: %Price{value: 1000}
  defp base_rate(_), do: %Price{value: 0}

  defp rules(%Val{id: "urn:lic:product:allflex:premium_calf_pack", value: _}) do
    [
      %{rule_ctx: %Val{id: "urn:lic:products:size", value: "urn:lic:products:colour:large"}, inc: %Price{value: 100}, f: id_and_value() },
      %{rule_ctx: %Val{id: "urn:lic:products:config:custom_text"}, inc: %Price{value: 50}, f: id_only() }
    ]
  end
  defp rates(_), do: []

  defp option_rating(rule, ids, price) do
    # case Enum.count(ids, fn id -> id == rule.rule end ) do
    case Enum.count(ids, fn id -> rule.f.(id, rule.rule_ctx) end) do
      0 -> price
      n -> price_change(n, price, rule)
    end
  end

  defp price_change(n, price, %{rule_ctx: _, inc: p}), do: %Price{value: price.value + (p.value * n)}
  defp price_change(n, price, %{rule_ctx: _, dec: p}), do: %Price{value: price.value - (p.value * n)}

  defp id_and_value, do: fn id, rule -> id == rule end

  defp id_only, do: fn id, rule -> id.id == rule.id end

end
