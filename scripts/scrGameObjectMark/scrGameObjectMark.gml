
/* это говно нужно заменить, на что-нибудь */

function gameObjectMarkInit(_caller) {
	
	_caller.__gameObjectMarkMapStatic = {};
	_caller.__gameObjectMarkMapTime = {};
}

function gameObjectMarkIf(_caller, _event, _target, _time=undefined, _timeReset=false, _timeFreeze=false) {
	
	var _key = "$" + _event + string(_target.id);
	if (is_undefined(_time)) {
		
		if (variable_struct_exists(_caller.__gameObjectMarkMapStatic, _key)) return false;
		_caller.__gameObjectMarkMapStatic[$ _key] = undefined;
	}
	else {
		
		if (_timeReset) {
			
			var _getTime = _caller.__gameObjectMarkMapTime[$ _key];
			if (_getTime != undefined) {
				
				if (is_array(_getTime))
					_getTime[@ 0] = _getTime[1];
				else
					_caller.__gameObjectMarkMapTime[$ _key] = _time;
				
				return false;
			}
			
			if (_timeFreeze) {
				
				_caller.__gameObjectMarkMapTime[$ _key] = [_time, _time];
			}
			else {
				
				_caller.__gameObjectMarkMapTime[$ _key] = _time;
			}
			return true;
		}
		
		if (variable_struct_exists(_caller.__gameObjectMarkMapTime, _key)) return false;
		_caller.__gameObjectMarkMapTime[$ _key] = _time;
	}
	
	return true;
}

function gameObjectMarkTick(_caller) {
	
	with (_caller) {
	
	var _keys = variable_struct_get_names(self.__gameObjectMarkMapTime);
	var _size = array_length(_keys);
	var _key, _time;
	while (_size > 0) {
		
		_key  = _keys[--_size];
		_time = self.__gameObjectMarkMapTime[$ _key];
		
		if (is_array(_time)) {
			
			_time = --_time[@ 0];
		}
		else {
			
			self.__gameObjectMarkMapTime[$ _key] = --_time;
		}
		
		if (_time <= 0) variable_struct_remove(self.__gameObjectMarkMapTime, _key);
		
	}
	
	}
}

function gameObjectMarkClear(_caller, _static=true, _time=true) {
	
	if (_static) _caller.__gameObjectMarkMapStatic = {};
	if (_time)   _caller.__gameObjectMarkMapTime = {};
}

