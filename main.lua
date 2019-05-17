require "values"
require "utils"
require "input"
require "audio"
require "game/unit"
require "game/movement"
require "game/rules"
require "game/undo"
game = require 'game/scene'

function love.load()
	sprites = {}
	move_sound_data = nil
	move_sound_source = nil

  local files = love.filesystem.getDirectoryItems("assets/sprites")
  for _,file in ipairs(files) do
    if string.sub(file, -4) == ".png" then
      local spritename = string.sub(file, 1, -5)
      local sprite = love.graphics.newImage("assets/sprites/" .. file)
      sprites[spritename] = sprite
    end
  end
  registerSound("move")
  registerSound("break")
  registerSound("unlock")
  registerSound("sink")
  registerSound("rule")
  registerSound("win")

  scene = game
  scene.load()
end

function love.keypressed(key,scancode,isrepeat)
	if key == "f1" and scene ~= game then
		scene = game
		scene.load()
	elseif key == "f2" then
		print("editor will go here")
	end

	if scene and scene.keypressed then
		scene.keypressed(key)
	end
end

function love.keyreleased(key)
	if scene and scene.keyreleased then
		scene.keyreleased(key)
	end
end

function love.update(dt)
	if scene and scene.update then
		scene.update(dt)
	end

  updateMusic()
end

function love.draw()
  local dt = love.timer.getDelta()

  if scene and scene.draw then
  	scene.draw(dt)
  end
end