

#region abstract-class

function GameObjectProperty(_value) constructor {
	
	// обязан быть публичным
	self.value = _value;
	
	// вы должны гарантировать что stateRecall будет вызван после stateRemember
	static stateRemember = undefined;
	static stateRecall   = undefined;
	static stateIsEmpty  = undefined;
	
	static controlSet = function(_value) {
		
		if (self.stateIsEmpty())  self.stateRemember();
	}
	
	static controlReset = function() {
		
		if (!self.stateIsEmpty()) self.stateRecall();
	}
	
}

#endregion

#region base-class

function GameObjectPropertyBox(_value) : GameObjectProperty(_value) constructor {
	
	#region __private
	
	self.__value = undefined;
	
	#endregion
	
	static stateRemember = function() {
		
		self.__value = self.value;
	}
	
	static stateRecall = function() {
		
		self.value   = self.__value;
		self.__value = undefined;
	}
	
	static stateIsEmpty = function() {
		
		return is_undefined(self.__value);
	}
	
}

function GameObjectPropertyArrayBox(_array) : GameObjectProperty(_array) constructor {
	
	#region __private
	
	self.__array = [true];
	
	#endregion
	
	static stateRemember = function() {
		
		self.__array[0] = false;
		
		var _size = array_length(self.value);
		array_resize(self.__array, _size + 1);
		array_copy(self.__array, 1, self.value, 0, _size);
	}
	
	static stateRecall = function() {
		
		self.__array[0] = true;
		
		var _size = array_length(self.__array) - 1;
		array_resize(self.value, _size);
		array_copy(self.value, 0, self.__array, 1, _size);
		array_resize(self.__array, 1);
	}
	
	static stateIsEmpty = function() {
		
		return self.__array[0];
	}
	
}

#endregion

