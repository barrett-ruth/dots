local dial_map = require 'dial.map'

map { 'n', '<c-a>', dial_map.inc_normal() }
map { 'n', '<c-x>', dial_map.dec_normal() }
map { 'x', '<c-a>', dial_map.inc_visual() }
map { 'x', '<c-x>', dial_map.dec_visual() }
map { 'x', 'g<c-a>', dial_map.inc_gvisual() }
map { 'x', 'g<c-x>', dial_map.dec_gvisual() }

local augend = require 'dial.augend'

require('dial.config').augends:register_group {
    default = {
        augend.constant.alias.alpha,
        augend.constant.alias.Alpha,
        augend.integer.alias.binary,
        augend.constant.alias.bool,
        augend.date.alias['%d/%m/%Y'],
        augend.integer.alias.decimal_int,
        augend.integer.alias.hex,
        augend.integer.alias.octal,
        augend.semver.alias.semver,
    },
}
