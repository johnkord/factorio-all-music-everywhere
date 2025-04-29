local original_sounds = {}
for name, sound in pairs(data.raw["ambient-sound"] or {}) do
  table.insert(original_sounds, sound)
end

local discovered_planets = {}
for name, sound in pairs(data.raw["ambient-sound"] or {}) do
  if sound.planet then
    discovered_planets[sound.planet] = true
  end
end

local planets = {}
for planet, _ in pairs(discovered_planets) do
  table.insert(planets, planet)
end

data.raw["ambient-sound"] = {}
for _, sound in ipairs(original_sounds) do
  for _, planet in ipairs(planets) do
    local clone = table.deepcopy(sound)
    clone.name = sound.name .. "-" .. planet
    clone.planet = planet
    if clone.track_type == "hero-track" then
      clone.track_type = "main-track" -- "there's a limit on how many hero-tracks can be set per planet (1), so just make them all main-track. no idea what hero-tracks are!"
    end
    data:extend({clone})
  end
end

-- log(serpent.block(data.raw))
