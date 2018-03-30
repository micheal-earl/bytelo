return {
  --[[
  Object = require 'lib/classic/classic',
  Input = require 'lib/input/Input',
  Timer = require 'lib/hump/timer',
  Camera = require 'lib/hump/camera',
  Bump = require 'lib/bump/bump',
  --]]
  
  require 'lib/utils',

  require 'objects/GameObject',
  require 'objects/Player',
  require 'objects/Area',
  require 'objects/Bullet',
  require 'objects/Upgrade',
  require 'objects/Enemy',
  require 'objects/Notify',

  require 'rooms/Stage'
}