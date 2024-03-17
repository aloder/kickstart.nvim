M = {}
function M.isModuleAvailable(name)
  if package.loaded[name] then
    return true
  else
    ---@diagnostic disable-next-line: deprecated
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

function M.require_if_work(path)
  if MyConfig.work then
    return require(path)
  end
  return {}
end

return M
