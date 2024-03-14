MyConfig = {
  work = false
}
if require('util').isModuleAvailable('work.config') then
  MyConfig = { work = true }
end

return MyConfig
