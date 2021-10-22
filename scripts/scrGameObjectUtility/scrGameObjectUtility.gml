#macro _ undefined

#region functors

function functorFunc(_methOrFunc) {
	return (is_method(_methOrFunc) ? method_get_index(_methOrFunc) : _methOrFunc);
}

function functorMeth(_methOrFunc) {
	return method(undefined, _methOrFunc);
}

function functorEm() { return undefined; };

function functorId(_value) { return _value; };

#endregion

#region applicator

function applicatorSome(_some, _f, _default=undefined) {
	if (_some != undefined) return _f(_some);
	return _default;
}

function applicatorSelf(_name, _value) {
	if (_value != undefined) self[$ _name] = _value;
}

#endregion

#region Class-PriorityArray

function PriorityArray() constructor {
	
	/* ЭТО ГАВНО НАДО ПЕРЕПИСАТЬ */
	// тут должно быть красно-чёрное дерево
	
	#region __private
	
	self.__size  = 0;
	self.__array = [];
	
	#endregion
	
	static getSiz = function() {
		
		return self.__size;
	}
	
	static fndIndBeg = function(_priority) {
		
		for (var _i = 0; _i < self.__size; ++_i) {
			
			if (_priority <= self.__array[_i * 2]) return _i;
		}
		
		return -1;
	}
	
	static fndIndEnd = function(_priority) {
		
		for (var _i = self.__size - 1; _i >= 0; --_i) {
			
			if (_priority >= self.__array[_i * 2]) return _i;
		}
		
		return -1;
	}
	
	static fndIndBegEq = function(_priority) {
		
		for (var _i = 0; _i < self.__size; ++_i) {
			
			if (_priority == self.__array[_i * 2]) return _i;
		}
		
		return -1;
	}
	
	static fndIndEndEq = function(_priority) {
		
		for (var _i = self.__size - 1; _i >= 0; --_i) {
			
			if (_priority == self.__array[_i * 2]) return _i;
		}
		
		return -1;
	}
	
	static addValBeg = function(_priority, _value) {
		
		var _ind = self.fndIndBeg(_priority);
		if (_ind == -1)
			array_push(self.__array, _priority, _value);
		else
			array_insert(self.__array, _ind * 2, _priority, _value);
		
		++self.__size;
	}
	
	static addValEnd = function(_priority, _value) {
		
		var _ind = self.fndIndEnd(_priority);
		if (_ind == -1)
			array_insert(self.__array, 0, _priority, _value);
		else
			array_insert(self.__array, _ind * 2 + 2, _priority, _value);
		
		++self.__size;
	}
	
	static getVal = function(_index) {
		
		return self.__array[_index * 2 + 1];
	}
	
	static remVal = function(_index) {
		
		--self.__size;
		array_delete(self.__array, _index * 2, 2);
	}
	
	static forAllBeg = function(_f, _data) {
		
		for (var _v, _j, _i = 0; _i < self.__size; ++_i) {
			
			_j = _i * 2;
			var _v = _f(self.__array[_j + 1], _data, _i);
			if (_v == -1) exit;
			if (_v == 1) {
				
				--_i;
				--self.__size;
				array_delete(self.__array, _j, 2);
			}
		}
	}
	
	static forAllEnd = function(_f, _data) {
		
		for (var _v, _j, _i = self.__size - 1; _i >= 0; --_i) {
			
			_j = _i * 2;
			var _v = _f(self.__array[_j + 1], _data, _i);
			if (_v == -1) exit;
			if (_v == 1) {
				
				array_delete(self.__array, _j, 2);
			}
		}
		
		self.__size = array_length(self.__array) div 2;
	}
	
	static clr = function() {
		
		self.__size = 0;
		array_resize(self.__array, 0);
	}
	
	static toArray = function() {
		
		var _array = array_create(self.__size);
		for (var _i = 0; _i < self.__size; ++_i) {
			
			_array[_i] = self.__array[_i * 2 + 1]; 
		}
		
		return _array;
	}
	
	static toString = function() {
		
		return string(self.toArray());
	}
	
}

#endregion


