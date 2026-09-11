--PostHook last function in init, make sure that all attachments and whatnot have been set up.
Hooks:PostHook(WeaponFactoryTweakData, "_set_inaccessibles", "SupAdmBar-PostHook-WeaponFactoryTweakData:_set_inaccessibles", function(self)
	--Safely add a value to the table of a part_id. Creates the table if it does not exist.
	--Does nothing if value==part_id or if the value is already in the table.
	local function wftd_safe_add_value(part_id, table_name, value)
		if value ~= part_id and self.parts[part_id] then
			self.parts[part_id][table_name] = self.parts[part_id][table_name] or {}
			if not table.contains(self.parts[part_id][table_name], value) then
				table.insert(self.parts[part_id][table_name], value)
			end
		end
	end

	--New localization by OSA/AOLA
	self.parts.wpn_fps_sho_ksg_b_legendary.legend_part_name_type = "barrel_sup"

	--Combined stats of Short Barrel and Silent Killer Suppressor
	--Optical Illusions bug will give the same bonus that you get on a real suppressed Raven
	self.parts.wpn_fps_sho_ksg_b_legendary.stats = {
		value = 1,
		alert_size = 12,
		spread_moving = -2,
		damage = -3,
		suppression = 12,
		recoil = -1,
		concealment = 2,
		extra_ammo = -2,
		spread = -2
	}

	--Add "silencer" perk, "gadget" perk is not overwritten
	wftd_safe_add_value("wpn_fps_sho_ksg_b_legendary", "perks", "silencer")

	--Suppressed fire sound, clone Silent Killer Suppressor
	self.parts.wpn_fps_sho_ksg_b_legendary.sound_switch = deep_clone(self.parts.wpn_fps_upg_ns_shot_thick.sound_switch)

	--Block all barrel extensions
	for _, part_id in pairs(self.wpn_fps_sho_ksg.uses_parts) do
		if self.parts[part_id] and self.parts[part_id].type == "barrel_ext" then
			wftd_safe_add_value("wpn_fps_sho_ksg_b_legendary", "forbids", part_id)
		end
	end

	--Block Dragon's Breath
	wftd_safe_add_value("wpn_fps_sho_ksg_b_legendary", "forbids", "wpn_fps_upg_a_dragons_breath")
end)
