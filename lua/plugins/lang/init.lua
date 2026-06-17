-- Per-language plugin specs live in this directory.
--
-- lazy.nvim's top-level `{ import = "plugins" }` only descends into a
-- subdirectory when that subdirectory contains an init.lua -- and even then it
-- loads ONLY this init.lua, not the sibling files. So this file's job is to
-- pull in everything else in the folder.
--
-- `{ import = "plugins.lang" }` makes lazy scan this directory and import every
-- *.lua spec in it (rust.lua, go.lua, php.lua, ...). It re-enters this init.lua
-- once, but lazy's module guard stops the recursion. The upside over listing
-- each file by hand: new languages are picked up automatically -- just drop a
-- new <lang>.lua here.
return {
  { import = "plugins.lang" },
}
