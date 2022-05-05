## Update(s)
 - No longer able to spam the cigarette pack that was removing cigs while in the process of pulling one out.
 - dpemotes no longer required as a resource, as it is handled internally now.

## Info
- Useable item called "redwoodcigs", "cardiaquecigs", and "yukoncigs" to be sold at shops of your choosing
- Cigarette Packs has 20 cigarettes inside
- Use the pack of cigs to get a single cigarette out of it
- Use the cigarette for minor, legal stress relief
- Cigarette pack accurately reflects how many cigarettes are left
- Pack deletes itself when the last cigarette is removed

## Dependencies
- lj-inventory (configure your own inventory if it's different. same concept)
- qb-policejob

## Insert into qb-core:shared:items.lua
```
-- Cigarettes
['redwoodcigs'] 				 	= {['name'] = 'redwoodcigs', 			['label'] = 'Redwood Cigarettes', 	['weight'] = 250, 		["degrade"] = 1.0,		['type'] = 'item', 		['image'] = 'redwoodcigs.png', 				['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Pack of Cigarettes, Made in USA'},
['cardiaquecigs'] 				 	= {['name'] = 'cardiaquecigs', 			['label'] = 'Cardiaque Cigarettes', ['weight'] = 250, 		["degrade"] = 1.0,		['type'] = 'item', 		['image'] = 'cardiaquecigs.png', 			['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Pack of Cigarettes, Made in USA'},
['yukoncigs'] 				 		= {['name'] = 'yukoncigs', 				['label'] = 'Yukon Cigarettes', 	['weight'] = 250, 		["degrade"] = 1.0,		['type'] = 'item', 		['image'] = 'yukoncigs.png', 				['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Pack of Menthol Cigarettes, Made in USA'},
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
} else if (itemData.name == "cardiaquecigs") { // Cigarette Pack
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html(
        "<p>" + itemData.info.uses + " cigarettes left.</p>"
    );
} else if (itemData.name == "yukoncigs") { // Cigarette Pack
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
elseif itemData["name"] == "cardiaquecigs" then
    info.uses = 20
elseif itemData["name"] == "yukoncigs" then
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

## When putting into shops, add this into the config.lua of qb-shops (change the # to whichever is next for you)
```
    [11] = {
        name = "redwoodcigs",
        price = 200,
        amount = 5000,
        info = {
            uses = 20
        },
        type = "item",
        slot = 11,
    },
    [12] = {
        name = "cardiaquecigs",
        price = 200,
        amount = 5000,
        info = {
            uses = 20
        },
        type = "item",
        slot = 12,
    },
    [13] = {
        name = "yukoncigs",
        price = 200,
        amount = 5000,
        info = {
            uses = 20
        },
        type = "item",
        slot = 13,
    },
```
