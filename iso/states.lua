function addState(object, state, value)
  addDebug("Adding state "..tostring(state).." with value "..tostring(value))
  value = value or true
	object.states[state] = value
end

function removeState(object, state)
  addDebug("Removing state "..tostring(state))
	object.states[state] = nil
end

function stateExists(object, state)
--  addDebug("checking "..tostring(object.oType).." state of "..tostring(state))
  theseStates = object.states or nil
	if theseStates then
		return theseStates[state] ~= nil
	else
		return false
	end
end
