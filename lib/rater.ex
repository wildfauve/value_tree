defmodule Rater do

  def call(tree) do
    Idify.call(tree)
    |> rating(rules(tree.tuple), base_rate(tree.tuple))
  end

  # List.foldl([5, 5], 10, fn x, acc -> x + acc end)

  defp rating(ids, rules, base_price) do
    List.foldl(rules, [base_price], fn rule, price -> option_rating(rule, ids, price ) end)
  end

  defp base_rate(%Val{id: "urn:lic:product:allflex:premium_calf_pack", value: _}), do: %Price{value: 1000, text: "Base pack price"}
  defp base_rate(_), do: %Price{value: 0, text: ""}

  defp rules(%Val{id: "urn:lic:product:allflex:premium_calf_pack", value: _}) do
    [
      %{
        rule_ctx: %Val{id: "urn:lic:products:size", value: "urn:lic:products:colour:large"},
        inc: %Price{value: 100, text: "Adding the large male/female tag option"},
        compare_fn: id_and_value()
      },
      %{
        rule_ctx: %Val{id: "urn:lic:products:config:custom_text"},
        inc: %Price{value: 50, text: "Adding Custom Text to the tag"},
        compare_fn: id_only()
      },
      %{
        rule_ctx: %Val{id: "urn:lic:product:product:allflex:hdx_tamperproof_cattle_deer_rfid"},
        inc: %Price{value: 90, text: "Nait Levy"},
        compare_fn: id_only()
      }
    ]
  end
  defp rates(_), do: []

  defp option_rating(rule, ids, prices) do
    case Enum.count(ids, fn id -> rule.compare_fn.(id, rule.rule_ctx) end) do
      0 -> prices
      n -> price_modification(n, prices, rule)
    end
  end

  defp price_modification(n, prices, %{rule_ctx: _, inc: p}), do: prices ++ [%Price{value: p.value * n, text: p.text}]
  defp price_modification(n, prices, %{rule_ctx: _, dec: p}), do: prices ++ [%Price{value: p.value * n, text: p.text}]

  defp id_and_value, do: fn id, rule -> id == rule end

  defp id_only, do: fn id, rule -> id.id == rule.id end

end
