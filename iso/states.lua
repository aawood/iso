function addState(object, state, value)
	value = value or true
	object.states[state] = value
end

function removeState(object, state)
	object.states[state] = nil
end

function stateExists(object, state)
	if object.states then
		return object.states[state] ~= nil
	else
		return false
	end
end
