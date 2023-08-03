local plugins = {}

local function add_plugins(file_name)
  vim.list_extend(plugins, require('custom.plugins.' .. file_name))
end

add_plugins 'ui'
add_plugins 'editor'
add_plugins 'tools'
add_plugins 'completion'

return plugins
