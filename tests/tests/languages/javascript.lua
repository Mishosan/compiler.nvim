--- This test file run all supported cases of use.
--- @usage :luafile ~/.local/share/nvim/lazy/compiler.nvim/tests/tests/languages/javascript.lua

local ms = 1000 -- wait time
local language = require("compiler.languages.javascript")
local example = vim.fn.stdpath "data" .. "/lazy/compiler.nvim/tests/examples/languages/javascript/"

-- Run
vim.api.nvim_set_current_dir(example .. "run-program/")
language.action("option2")
vim.wait(ms)

-- npm install
vim.api.nvim_set_current_dir(example .. "npm/")
language.action("option3")
vim.wait(ms)

-- npm start
vim.api.nvim_set_current_dir(example .. "npm/")
language.action("option4")
vim.wait(ms)
