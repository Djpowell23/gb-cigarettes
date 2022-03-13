## Known Issues
- When purchasing packs from qb-shops, there is no limit to the amount of cigs. Looking for fix

## Welcome ideas/snippets
- Info how to add these items to qb-shops without losing 20 cigs per pack functionality

## Info
- Useable item called "redwoodcigs" to be sold at your choosing
- Redwood Cigarette Pack has 20 cigarettes inside
- Use the pack of cigs to get a single cigarette out of it
- Use the cigarette for minor, legal stress relief
- Cigarette pack accurately reflects how many cigarettes are left (when spawned in)
- Pack deletes itself when the last cigarette is removed (when pack was spawned in)

## Dependencies
- lj-inventory (configure your own inventory if it's different. same concept)
- qb-policejob
- dpemotes

## Insert into qb-core:shared:items.lua
Cigarettes
```
['redwoodcigs'] 				 	= {['name'] = 'redwoodcigs', 			['label'] = 'Redwood Cigarettes', 	['weight'] = 250, 		["degrade"] = 1.0,		['type'] = 'item', 		['image'] = 'redwoodcigs.png', 				['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Pack of Cigarettes, Made in USA'},
["cigarette"] 						= {["name"] = "cigarette",  	     	["label"] = "Cigarette",	 		["weight"] = 250, 		["type"] = "item", 		["image"] = "cigarette.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "Smokeable Tobacco"},
```

## Insert into lj-inventory:html:js:app.js

Under FormatItemInfo
```
else if (itemData.name == "redwoodcigs") { // Cigarette Pack
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html(
        "<p>" + itemData.info.uses + " cigarettes left.</p>"
    );
}
```

## Insert into lj-inventory:server:main.lua (Gives the item it's info.uses for inventory)
Look for QBCore.Commands.Add("giveitem", "Give An Item (Admin Only)" and insert this
```
elseif itemData["name"] == "redwoodcigs" then
    info.uses = 20
```

## Insert into qb-policejob:client:evidence.lua (no real meaning, just a new status effect)

Under local StatusList
```
['tobaccosmell'] = Lang:t('evidence.tobacco_smell'),
```

## Insert into qb-policejob:locales:en.lua (no real meaning, just a new status effect)

Under evidence
```
tobacco_smell = 'Smells like tobacco',
```

## Insert into dpemotes:Client:Emote.lua (stress relief and animation)
```
RegisterNetEvent('animations:client:SmokeCig')
AddEventHandler('animations:client:SmokeCig', function()
  SmokingWeed = true
  Citizen.CreateThread(function()
    while SmokingWeed do
      Citizen.Wait(10000)
      TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
      RelieveCount = RelieveCount + 1
      if RelieveCount == 6 then
        if ChosenDict == "MaleScenario" and IsInAnimation then
          ClearPedTasksImmediately(PlayerPedId())
          IsInAnimation = false
          DebugPrint("Forced scenario exit")
        elseif ChosenDict == "Scenario" and IsInAnimation then
          ClearPedTasksImmediately(PlayerPedId())
          IsInAnimation = false
          DebugPrint("Forced scenario exit")
        end

        if IsInAnimation then
          ClearPedTasks(PlayerPedId())
          DestroyAllProps()
          IsInAnimation = false
        end

        if SmokingWeed then
          SmokingWeed = false
          RelieveCount = 0
        end
      end
    end
  end)
end)
```
