local indentscope = require('mini.indentscope')
--- @type Plugin
return {
  event = 'BufEnter',
  opts = {
    symbol = '·',
    draw = {
      delay = 0,
      animation = indentscope.gen_animation.none(),
    },
    mappings = {
      object_scope = '',
      object_scope_with_border = '',
      goto_top = '',
      goto_bottom = '',
    },
    options = {
      border = 'top',
      try_as_border = true,
    },
  },
}
