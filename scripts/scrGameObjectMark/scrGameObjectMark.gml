
/* это говно нужно заменить, на что-нибудь */

function GameObjectMark() constructor {
	
	#region __private
	
	self.__mapTime = {};
	
	#endregion
	
	static isCast = function(_event, _target, _time=undefined, _timeReset=false, _timeFreeze=false) {
		
		var _key = "$" + _event + string(_target.id);
		if (is_undefined(_time)) {
		
			if (variable_struct_exists(self, _key)) return false;
			self[$ _key] = undefined;
		}
		else {
		
			if (_timeReset) {
				
				var _getTime = self.__mapTime[$ _key];
				if (_getTime != undefined) {
				
					if (is_array(_getTime))
						_getTime[@ 0] = _getTime[1];
					else
						self.__mapTime[$ _key] = _time;
				
					return false;
				}
				
				if (_timeFreeze) {
				
					self.__mapTime[$ _key] = [_time, _time];
				}
				else {
				
					self.__mapTime[$ _key] = _time;
				}
				return true;
			}
			
			if (variable_struct_exists(self.__mapTime, _key)) return false;
			self.__mapTime[$ _key] = _time;
		}
	
		return true;
	}
	
	static tick = function() {
		
		var _keys = variable_struct_get_names(self.__mapTime);
		var _size = array_length(_keys);
		var _key, _time;
		while (_size > 0) {
			
			_key  = _keys[--_size];
			_time = self.__mapTime[$ _key];
			
			if (is_array(_time)) {
			
				_time = --_time[@ 0];
			}
			else {
			
				self.__mapTime[$ _key] = --_time;
			}
			
			if (_time <= 0) variable_struct_remove(self.__mapTime, _key);
		
		}
		
	}
	
	static clear = function(_static=true, _time=true) {
		
		if (_static) {
			
			var _map = self.__mapTime;
			var _keys = variable_struct_get_names(self);
			var _size = array_length(_keys);
			while (_size > 0) variable_struct_remove(self, _keys[--_size]);
			
			self.__mapTime = _map;
		}
		
		if (_time) self.__mapTime = {};
	}
	
}

