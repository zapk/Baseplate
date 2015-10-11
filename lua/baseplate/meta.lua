local metaTables = {}

-- If you're sandboxing, you probably shouldn't let people use this as they can overwrite things.
function RegisterMetaTable( metaName, tab )
   metaTables[metaName] = tab
end

function FindMetaTable( metaName )
   return metaTables[metaName] or nil
end
