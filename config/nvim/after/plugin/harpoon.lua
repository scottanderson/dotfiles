local mark = require('harpoon.mark')
local ui = require('harpoon.ui')
vim.keymap.set('n', '<leader>a', mark.add_file)
vim.keymap.set('n', '<leader>t', mark.toggle_file)
vim.keymap.set('n', '<leader>q', ui.toggle_quick_menu)

-- Enable file names in `Telescope keymaps` descriptions
local show_file_name_in_description = true

local function update_harpoon_maps()
    -- Mark (sh[a-z]) and recall (gh[a-z])
    local function update_harpoon_map(i, letter_i, nav_i, mark_i)
        local letter_u = string.upper(letter_i)
        if not show_file_name_in_description then
            vim.keymap.set('n', 'gh' .. letter_i, nav_i, { desc = ('[G]o [H]arpoon [%s] (%02d)'):format(letter_u, i) })
            vim.keymap.set('n', 'sh' .. letter_i, mark_i, { desc = ('[S]et [H]arpoon [%s] (%02d)'):format(letter_u, i) })
            return
        end
        local file_name = mark.get_marked_file_name(i)
        if file_name == nil or file_name == '(empty)' then
            local set_desc = ('[S]et [H]arpoon [%s] (%02d)'):format(letter_u, i)
            vim.keymap.set('n', 'gh' .. letter_i, nav_i)
            vim.keymap.del('n', 'gh' .. letter_i)
            vim.keymap.set('n', 'sh' .. letter_i, mark_i, { desc = set_desc })
        else
            local recall_desc = ('[G]o [H]arpoon [%s] (%02d %s)'):format(letter_u, i, file_name)
            local set_desc = ('[S]et [H]arpoon [%s] (%02d %s)'):format(letter_u, i, file_name)
            vim.keymap.set('n', 'gh' .. letter_i, nav_i, { desc = recall_desc })
            vim.keymap.set('n', 'sh' .. letter_i, mark_i, { desc = set_desc })
        end
    end
    local index = 1
    while index <= 26 do
        local i = index
        local nav_i = function()
            ui.nav_file(i)
            print(('Harpoon %02d: %s'):format(i, mark.get_marked_file_name(i)))
        end
        local alphabet_lower = 'abcdefghijklmnopqrstuvwxyz';
        local letter_i = alphabet_lower:sub(i, i)
        local mark_i
        mark_i = function()
            local current_index = mark.get_current_index()
            if current_index == nil then
                mark.set_current_at(i)
                print(('Installed mark %s'):format(letter_i));
                update_harpoon_map(i, letter_i, nav_i, mark_i)
            elseif current_index == i then
                print(('Mark %s already set'):format(letter_i));
            else
                local file_name = mark.get_marked_file_name(i)
                local letter_o = alphabet_lower:sub(current_index, current_index):upper()
                print(('Error: File %s already marked (%s). Remove with <leader>t'):format(file_name, letter_o))
            end
        end
        update_harpoon_map(i, letter_i, nav_i, mark_i)
        index = index + 1
    end
end

-- Set intial bindings
update_harpoon_maps()
if show_file_name_in_description then
    -- Update binding descriptions any time harpoon marks are modified
    mark.on('changed', update_harpoon_maps)
end
