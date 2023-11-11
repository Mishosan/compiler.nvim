--- Rust language actions

local M = {}

-- Frontend  - options displayed on telescope
M.options = {
  { text = "Cargo build and run", value = "option1" },
  { text = "Cargo build", value = "option2" },
  { text = "Cargo run", value = "option3" },
  { text = "", value = "separator" },
  { text = "Cargo build --all and run", value = "option4" },
  { text = "Cargo build --all", value = "option5" },
  { text = "Cargo clippy --fix --allow-dirty", value = "option6" },
}

-- Backend - overseer tasks performed on option selected
function M.action(selected_option)
  local utils = require("compiler.utils")
  local overseer = require("overseer")
  local entry_point = utils.os_path(vim.fn.getcwd() .. "/main.rs")           -- working_directory/main.rs
  --local output_dir = utils.os_path(vim.fn.getcwd() .. "/bin/")               -- working_directory/bin/
  --local output = utils.os_path(vim.fn.getcwd() .. "/bin/program")            -- working_directory/bin/program
  --local arguments = "-D warnings -g"                                         -- arguments can be overriden in .solution
  local final_message = "--task finished--"

  if selected_option == "option1" then
    local task = overseer.new_task({
      name = "- Rust compiler",
      strategy = { "orchestrator",
        tasks = {{ "shell", name = "- Cargo build & run → " .. "Cargo.toml",
          cmd = "cargo build " ..                                                       -- compile
                " && cargo run" ..                                                      --run
                " && echo '" .. final_message .. "'"                                    -- echo
        },},},})
    task:start()
    vim.cmd("OverseerOpen")
  elseif selected_option == "option2" then
    local task = overseer.new_task({
      name = "- Rust compiler",
      strategy = { "orchestrator",
        tasks = {{ "shell", name = "- Cargo build → " .. "Cargo.toml",
          cmd = "cargo build " ..                                                       -- compile
                " && echo '" .. final_message .. "'"                                    -- echo
        },},},})
    task:start()
    vim.cmd("OverseerOpen")
  elseif selected_option == "option3" then
    local task = overseer.new_task({
      name = "- Rust compiler",
      strategy = { "orchestrator",
        tasks = {{ "shell", name = "- Cargo run → " .. "Cargo.toml",
          cmd = "cargo run " ..                                                        -- run
                " && echo '" .. final_message .. "'"                                   -- echo
        },},},})
    task:start()
    vim.cmd("OverseerOpen")
  elseif selected_option == "option4" then
    local task = overseer.new_task({
      name = "- Rust compiler",
      strategy = { "orchestrator",
        tasks = {{ "shell", name = "- Cargo build --all & run → " .. "Cargo.toml",
          cmd = "cargo build --all " ..                                                -- compile
                " && cargo run" ..
                " && echo '" .. final_message .. "'"                                   -- echo
        },},},})
    task:start()
    vim.cmd("OverseerOpen")
  elseif selected_option == "option5" then
    local task = overseer.new_task({
      name = "- Rust compiler",
      strategy = { "orchestrator",
        tasks = {{ "shell", name = "- Cargo build --all → " .. "Cargo.toml",
          cmd = "cargo build --all" ..                                                 -- compile
                " && echo '" .. final_message .. "'"                                   -- echo
        },},},})
    task:start()
    vim.cmd("OverseerOpen")
  elseif selected_option == "option6" then
    local task = overseer.new_task({
      name = "- Clippy fix",
      strategy = { "orchestrator",
        tasks = {{ "shell", name = "- Cargo clippy --fix --allow-dirty → " .. "Cargo.toml",
          cmd = "cargo clippy --fix --allow-dirty " ..
                " && echo '" .. final_message .. "'"
        },},},})
    task:start()
    vim.cmd("OverseerOpen")
    -- vim.cmd(":e %:t")
  end
end

return M
