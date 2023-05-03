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

-- Table of contents
-- SELENIUM
--   import typical libraries : [S]elenium[W]ebelement[I]mports
--   find element shorthand   : [S]elenium[W]ebelement[F]indElement
-- SKLEARN
--   make pipeline and insert imputer : [SK]learn[P]ipeline[I]mport
-- PANDAS
--   typical data cleaning routine like `drop_duplicates()`
--   one-hot encode with `get_dummies()`
-- RECORDLINKAGE
--   typical search for a string, numerical, etc.
-- SCIPY.STATS
--   generate a given distribution and get a statistic back
-- NUMPY
--   generate a distribution and 

-- Import all common selenium names
-- s({ trig="selimp"},
-- 	{
-- 	t({"from selenium import webdriver"}),
-- 	t({"from selenium.webdriver.common.by import By"}),
-- 	t({""}),
-- 	t({"driver = webdriver.Firefox()"}),
-- 	t({"driver.implicitly_wait(10)"}),
-- 	t({"driver.get("}),
-- 	i(1, URL),
-- 	t({")"}),
-- 	    }),
--
-- s({ trig="dfx"},
-- 	{
-- 	t({"driver.find_element${1}(By.XPATH, ${2})"}),
-- 	})
--
-- # TODO: make a pipeline for any kind of imputer
-- s({ trig="skpi" },
-- {
-- 	t({"from sklearn.pipeline import make_pipeline"}),
-- 	t({}),
-- 	i(1, pipeline = make_pipeline({$1})
-- 	}),
--
-- # TODO: pandas drop duplicates, other cleaning functions
-- # s({ trig="pdd"}
--
--
-- # TODO: scipy.stats generate a distribution relevant to a problem
-- # we can make a functionnode that interviews the user!
-- # e.g. P(A|B) = P(B|A) * P(A) / P(B)
-- # So the typical A B being
-- # rain, clouds ; clouds 'presage' rain
-- # "Is the statement reversible?" -> chance of clouds given rain seems good
-- # But where the hypothesis is "rain 'presages' no-shows"
-- # "the chance of rain given no-shows" is not reversible
-- # So this interview might be of importance, might suggest a different type of distribution
-- # c.f. also C:\Users\maxde\code\interpreting\aguila\stats\finances.md
-- s({ trig="ssd",},
-- {
-- 	t({"from scipy.stats import"}),
-- 	i(1, "DISTRIBUTION"),
-- 	})
--
-- # generate bootstrap samples for a dataframe
--
-- # return the 
-- s({ trig="ssb", },
-- {
-- 	t({"import scipy.stats"}),
-- 	t({"from scipy.stats import binomial"}),
-- }
