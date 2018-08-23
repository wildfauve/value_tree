defmodule IdifyTest do
  use ExUnit.Case
  # doctest ValueTree

  @tree %N{tuple: %Val{id: "urn:lic:product:allflex:premium_calf_pack", value: ""}, children: [
        %N{tuple: %Val{id: "urn:lic:product:allflex:tamperproof_tag", value: ""}, children: [
          %N{tuple: %Val{id: "urn:lic:product:allflex:tamperproof_female_tag", value: ""}, children: [
            %N{tuple: %Val{id: "urn:lic:products:colour", value: "urn:lic:products:colour:red"}, children: []},
            %N{tuple: %Val{id: "urn:lic:products:size", value: "urn:lic:products:colour:large"}, children: []},
            %N{tuple: %Val{id: "urn:lic:products:config:custom_text", value: "JJ FARMS"}, children: []},
            %N{tuple: %Val{id: "urn:lic:products:config:birth_id", value: "KGCY-2018-963,KGCY-2018-964"}, children: []}
            ]},
          %N{tuple: %Val{id: "urn:lic:product:allflex:tamperproof_male_tag", value: ""}, children: [
            %N{tuple: %Val{id: "urn:lic:products:colour", value: "urn:lic:products:colour:red"}, children: []},
            %N{tuple: %Val{id: "urn:lic:products:size", value: "urn:lic:products:colour:large"}, children: []},
            %N{tuple: %Val{id: "urn:lic:products:config:birth_id", value: "KGCY-2018-963,KGCY-2018-964"}, children: []}
            ]}
        ]},
        %N{tuple: %Val{id: "urn:lic:product:product:allflex:hdx_tamperproof_cattle_deer_rfid", value: ""}, children: [
          %N{tuple: %Val{id: "urn:lic:product:component:allflex:hdx_nait_tamperproof_cattle_rfid", value: ""}, children: [
            %N{tuple: %Val{id: "urn:lic:products:config:birth_id", value: "KGCY-2018-963,KGCY-2018-964"}, children: []}
            ]},
          %N{tuple: %Val{id: "urn:lic:product:component:allflex:nait_long_stem_male_button", value: ""}, children: []},
          %N{tuple: %Val{id: "urn:lic:id:confreq:nait_tag_prod_type", value: "D"}, children: []},
          %N{tuple: %Val{id: "urn:lic:id:confreq:nait_number", value: "1234"}, children: []},
        ]}
      ]}


  test "idify" do
    expected_ids = [
      %Val{id: "urn:lic:product:allflex:tamperproof_tag", value: ""},
      %Val{id: "urn:lic:product:allflex:tamperproof_female_tag", value: ""},
      %Val{id: "urn:lic:products:colour", value: "urn:lic:products:colour:red"},
      %Val{id: "urn:lic:products:size", value: "urn:lic:products:colour:large"},
      %Val{id: "urn:lic:products:config:custom_text", value: "JJ FARMS"},
      %Val{id: "urn:lic:products:config:birth_id", value: "KGCY-2018-963,KGCY-2018-964"},
      %Val{id: "urn:lic:product:allflex:tamperproof_male_tag", value: ""},
      %Val{id: "urn:lic:products:colour", value: "urn:lic:products:colour:red"},
      %Val{id: "urn:lic:products:size", value: "urn:lic:products:colour:large"},
      %Val{id: "urn:lic:products:config:birth_id",value: "KGCY-2018-963,KGCY-2018-964"},
      %Val{id: "urn:lic:product:product:allflex:hdx_tamperproof_cattle_deer_rfid", value: ""},
      %Val{id: "urn:lic:product:component:allflex:hdx_nait_tamperproof_cattle_rfid",value: ""},
      %Val{id: "urn:lic:products:config:birth_id", value: "KGCY-2018-963,KGCY-2018-964"},
      %Val{id: "urn:lic:product:component:allflex:nait_long_stem_male_button",value: ""},
      %Val{id: "urn:lic:id:confreq:nait_tag_prod_type", value: "D"},
      %Val{id: "urn:lic:id:confreq:nait_number", value: "1234"}
    ]
    ids = Idify.call(@tree)

    assert ids == expected_ids
  end

end
