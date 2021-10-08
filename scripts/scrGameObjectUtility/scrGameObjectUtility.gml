

#region functors

function functorFunc(_methOrFunc) {
	return (is_method(_methOrFunc) ? method_get_index(_methOrFunc) : _methOrFunc);
}

function functorMeth(_methOrFunc) {
	return method(undefined, _methOrFunc);
}

#endregion

#region Class-PriorityMap

function PriorityMap() constructor {
	
	
}

#endregion

