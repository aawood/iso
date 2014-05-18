function addState(objectIndex, state, value)
	value = value or true
	objects[objectIndex].states.state = value
end

function removeState(object, state)
	object.states.state = nil
end

function stateExists(object, state)
	if object.states.state then
		return true
	else
		return false
	end
end
