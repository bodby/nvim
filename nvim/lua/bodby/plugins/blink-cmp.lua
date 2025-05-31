local options = {
  --- Whether to show the autocompletion menu by default.
  --- Note that this does not affect the cmdline menu, which will always show.
  --- @type boolean
  show_menu = false,

  --- Change the appearance of the autocompletion menu.
  --- Some border options were left out because they don't look good IMO.
  --- @type 'none' | 'single' | 'rounded' | 'solid' | 'padded'
  menu_border = require('bodby.shared').ui.border.name,

  --- Show the documentation window next to the autocompletion menu.
  --- @type boolean
  show_docs = false,

  --- Show a preview of the currently selected autocompletion icon.
  --- This works best when `show_menu` is false.
  --- @type boolean
  show_ghost_text = true,

  --- Show the source that a completion icon came from, e.g. "[lsp]".
  --- @type boolean
  show_item_source = false,

  --- Which implementation of the fuzzy algorithm to use.
  --- @type 'prefer_rust' | 'prefer_rust_with_warning' | 'rust' | 'lua'
  fuzzy_impl = 'prefer_rust',

  --- Add and show a trailing slash at the end of directories.
  --- @type boolean
  trailing_slash = true,

  --- The maximum number of items to show in the menu.
  --- @type integer
  max_items = 100,
}

--- @type Plugin
return {
  event = 'BufEnter',
  opts = {
    keymap = {
      preset = 'none',
      ['<C-Space>'] = { 'show' },
      ['<Tab>'] = { 'select_and_accept', 'fallback' },
      ['<C-n>'] = {
        function(cmp)
          if not cmp.is_menu_visible() then
            cmp.show()
          end
          cmp.select_next()
        end,
      },
      ['<C-p>'] = {
        function(cmp)
          if not cmp.is_menu_visible() then
            cmp.show()
          end
          cmp.select_prev()
        end,
      },
    },

    completion = {
      list = {
        max_items = options.max_items,
        selection = { preselect = true, auto_insert = false },
      },

      accept = {
        auto_brackets = { enabled = false },
      },

      trigger = {
        -- '#' breaks snippet expansion in Lua.
        show_on_blocked_trigger_characters = { '#', ' ', '\n', '\t' },
      },

      menu = {
        enabled = true,
        min_width = 12,
        max_height = vim.o.pumheight,
        border = options.menu_border,
        scrolloff = 4,
        scrollbar = false,
        auto_show = options.show_menu,
        draw = {
          padding = 1,
          gap = 1,
          columns = function()
            if options.show_item_source then
              return {
                { 'kind' },
                { 'label', 'source', gap = 1 },
              }
            end
            return {
              { 'kind' },
              { 'label' },
            }
          end,

          components = {
            kind = {
              ellipsis = false,

              text = function(context)
                return context.kind_icon
              end,

              highlight = function(context)
                return context.kind_hl
              end,
            },

            label = {
              ellipsis = true,
              width = {
                max = 48,
                fill = true,
              },

              text = function(context)
                return context.label
              end,

              highlight = function(context)
                local base = 'BlinkCmpLabel'
                local hl = context.deprecated and base .. 'Deprecated' or base
                local highlights = {
                  { 0, #context.label, group = hl },
                }

                for _, v in ipairs(context.label_matched_indices) do
                  table.insert(highlights, {
                    v,
                    v + 1,
                    group = base .. 'Match',
                  })
                end

                return highlights
              end,
            },

            source = {
              ellipsis = false,

              text = function(context)
                return '[' .. context.source_name .. ']'
              end,

              highlight = 'BlinkCmpSource',
            },
          },
        },
      },

      documentation = { auto_show = options.show_docs },
      ghost_text = {
        enabled = options.show_ghost_text,
        show_with_menu = false,
      },
    },

    fuzzy = {
      implementation = options.fuzzy_impl,
      max_typos = function(keyword)
        return math.floor(#keyword / 4)
      end,

      sorts = { 'exact', 'score' },
      use_frecency = true,
      use_proximity = true,
      prebuilt_binaries = { download = false },
    },

    -- NOTE: Use 'should_show_items' to always show a source's items.
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lsp = {
          name = 'lsp',
          module = 'blink.cmp.sources.lsp',
          fallbacks = {},
        },

        path = {
          name = 'path',
          module = 'blink.cmp.sources.path',
          score_offset = 100,
          fallbacks = {},
          opts = {
            trailing_slash = options.trailing_slash,
            show_hidden_files_by_default = true,
            label_trailing_slash = options.trailing_slash,
          },
        },

        snippets = {
          name = 'snippet',
          module = 'blink.cmp.sources.snippets',
          score_offset = 5,
          fallbacks = {},
          should_show_items = true,
          opts = {
            friendly_snippets = false,
            search_paths = {
              vim.fs.joinpath(vim.split(vim.o.rtp, ',')[1], '/snippets'),
            },
            global_snippets = { 'all' },
          },
        },

        buffer = {
          name = 'buffer',
          module = 'blink.cmp.sources.buffer',
          fallbacks = {},
          should_show_items = true,

          transform_items = function(context, items)
            --- @type string
            local keyword = context.get_keyword()
            --- @type fun(str: string): string
            local modifier = string.upper
            if keyword:match('^%l') then
              modifier = string.lower
            elseif not keyword:match('^%u') then
              return items
            end

            local result = {}
            local prev = {}

            for _, v in ipairs(items) do
              local text = modifier(v.insertText:sub(1, 1))
                .. v.insertText:sub(2)
              v.insertText = text
              v.label = text

              if not prev[v.insertText] then
                prev[v.insertText] = true
                table.insert(result, v)
              end
            end

            return result
          end,
        },
      },
    },

    cmdline = {
      enabled = true,
      keymap = {
        preset = 'none',
        ['<Tab>'] = { 'show', 'accept', 'fallback' },
        ['<C-n>'] = { 'select_next' },
        ['<C-p>'] = { 'select_prev' },
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
      },

      completion = {
        menu = { auto_show = true },
      },
    },

    appearance = {
      kind_icons = {
        Text = 'b',
        Method = 'f',
        Function = 'f',
        Constructor = 'm',
        Field = 'v',
        Variable = 'x',
        Property = 'p',
        Class = 't',
        Interface = 'i',
        Struct = 't',
        Module = 'm',
        Unit = 'u',
        Value = 'v',
        Enum = 'e',
        EnumMember = 'e',
        Keyword = 'k',
        Constant = 'k',
        Snippet = 's',
        Color = 'c',
        File = 'f',
        Reference = '&',
        Folder = 'd',
        Event = 'e',
        Operator = '+',
        TypeParameter = 't',
      },
    },
  },
}
