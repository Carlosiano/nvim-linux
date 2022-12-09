require('user.base')
require('user.highlights')
require('user.maps')
require('user.plugins')
require('user.reload')

local has = function (x)
  return vim.fn.has(x) == 1
end

local is_mac = has "macunix"
local is_win = has "win32"
local is_linux = has "unix"

if is_linux then
  require('user.linux')
end

if is_mac then
  require('user.macos')
end

if is_win then
  require('user.windows')
end
