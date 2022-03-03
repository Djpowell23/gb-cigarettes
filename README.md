## Dependencies
- lj-inventory (configure your own inventory if it's different. same concept)

## Insert into qb-policejob:client:evidence.lua

Under local StatusList
    <!-- ['tobaccosmell'] = Lang:t('evidence.tobacco_smell'), -->


## Insert into qb-policejob:locales:en.lua

Under evidence
    tobacco_smell = 'Smells like tobacco',


## Insert into lj-inventory:html:js:app.js

Under FormatItemInfo
    else if (itemData.name == "redwoodcigs") { // Cigarette Pack
        $(".item-info-title").html("<p>" + itemData.label + "</p>");
        $(".item-info-description").html(
            "<p>" + itemData.info.uses + " cigarettes left.</p>"
        );

## Insert into qb-core:shared:items.lua
    -- Cigarettes
['redwoodcigs'] 				 	= {['name'] = 'redwoodcigs', 			['label'] = 'Redwood Cigarettes', 	['weight'] = 250, 		["degrade"] = 1.0,		['type'] = 'item', 		['image'] = 'redwoodcigs.png', 				['unique'] = true, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Pack of Cigarettes, Made in USA'},
["cigarette"] 						= {["name"] = "cigarette",  	     	["label"] = "Cigarette",	 		["weight"] = 250, 		["type"] = "item", 		["image"] = "cigarette.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,   	["combinable"] = nil,   ["description"] = "Smokeable Tobacco"},

## Insert into lj-inventory:server:main.lua
    elseif itemData["name"] == "redwoodcigs" then
        info.uses = 20
