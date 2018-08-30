defmodule OrderedProductIdifyTest do
  use ExUnit.Case
  # doctest ValueTree

  def get_json(filename) do
    with {:ok, body} <- File.read(filename),
         {:ok, json} <- Poison.decode(body), do: {:ok, json}
  end

  test 'Ordered Product-idify' do

    {_, bundle} = get_json("test/fixtures/ordered_premium_pack_example.json")

    identity = OrderedProductIdify.call(bundle)
               |> Idify.flatten
               |> Enum.map(fn x -> x.id end)

               require IEx
               IEx.pry()




    expected_result = ["/product/products/allflex-premium-calf-pack",
                       "urn:lic:predicate:responsible_party",
                       "urn:lic:predicate:owning_party",
                       "urn:lic:predicate:assign_to_operation",
                       "urn:lic:id:predicate:animal_timeline_group",
                       "/product/products/allflex-tamperproof-tag",
                       "/product/products/allflex-tamperproof-tag/components/tamperproof-female-tag",
                       "urn:lic:id:confreq:birth_id",
                       "/product/products/allflex-tamperproof-tag/components/tamperproof-male-tag",
                       "urn:lic:id:confreq:birth_id",
                       "/product/products/hdx-tamperproof-cattle-deer-rfid",
                       "urn:lic:id:confreq:species",
                       "urn:lic:id:confreq:nait_number",
                       "urn:lic:id:confreq:nait_tag_prod_type",
                       "/product/products/allflex-tamperproof-tag/components/hdx_nait_tamperproof_cattle_female_eid",
                       "/product/products/allflex-tamperproof-tag/components/nait_long_stem_male_button"]

    assert identity == expected_result
  end


end
