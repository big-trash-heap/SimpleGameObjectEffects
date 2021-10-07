

function getFunction(_methOrFunc) {
	return 
		( is_method(_methOrFunc) 
		? method_get_index(_methOrFunc) 
		: _methOrFunc);
}

