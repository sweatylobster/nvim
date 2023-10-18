local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet


-- define the function used by the snippet 
local date = function() return {os.date('%Y-%m-%d')} end

ls.add_snippets(nil, {
  all = {
    s({trig = "nodis", desc = "State that the patient has no diseases."}, {
      t({"The patient has no known history of heart disease, high blood pressure, kidney disease, diabetes, tuberculosis, cancer, ulcers, pneumonia, lung disease, eye problems, skin problems, asthma, hepatitis, liver disease, thyroid disease, gout, rheumatoid arthritis, Lupus, or arthritis."}),
    }),
    s({trig = "noinjwr", desc = "No work-related injuries."}, c(1, {
      t"The patient denies having sustained any work-related injuries.",
    })),
    s({trig = "noinjper", desc = "No MVA or personal injuries."}, {
      t({"The patient denies having sustained any personal, sports-related, or motor-vehicle injuries."}),
    }),
    s({trig = "dmg"}, {
      t({"prolonged standing and sitting, continuous fine manipulation of the hands and fingers, gripping, grasping, pulling, pushing, twisting, turning, torquing, dragging, stooping, squatting, working overhead, and lifting up to 40 pounds"}),
    }),
    s("trig", c(1, {
      t("Ugh boring, a text node"),
      i(nil, "At least I can edit something now..."),
      f(function(args) return "Still only counts as text!!" end, {})
    })),
  }
})

