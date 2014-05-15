function addState(objectIndex, newState, value)
	value = value or true
	objects[objectIndex].states[newState] = value
end

function removeState(object, stateName)
	object.states[stateIndex] = nil
end

function stateExists(object, stateName)
	if object.states[stateName] then
		return true
	else
		return false
	end
end
