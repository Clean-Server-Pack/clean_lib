lib.install = {
  create = function(data)

  end,
}

return lib.install

-- This will create an INSTALLATION folder within your resource with the following structure:
-- itemsToAdd/
  -- oxItems.lua 
  -- esxItems.sql
  -- qbItems.lua 
-- jobsToAdd/ 
  -- esxJobs.sql
  -- qbJobs.lua
-- script_name.sql (any sql tables you want to add)

-- If enabled it will also try auto build the SQL table on resource start up.


-- lib.install.create({
--   file_path = 'server.lua',

--   jobs  = {
--     {
--       name  = 'police',
--       label = 'Police',
--       ranks = {
--         [1] = {
--           label = 'Cadet',
--           payment = 1000,
--           isBoss = true,
--         }
--       }, 
--     },
--   },

--   items = {
--     --## Bunch of items in here
--   },

--   sql_tables = {
--     {
--       name             = 'players',
--       delete_if_exists = true,
--       columns          = {
--         {name = 'id', type = 'int', length = 11, primary = true, auto_increment = true},
--         {name = 'name', type = 'varchar', length = 255},
--         {name = 'money', type = 'int', length = 11},
--       },
--     }
--   },
-- })