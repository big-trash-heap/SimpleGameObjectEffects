

#region abstract-class

function GameObjectProperty(_value) constructor {
	
	// обязан быть публичным
	self.value = _value;
	
	static stateRemember = undefined;
	static stateRecall   = undefined;
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
		//self.__value = undefined; // гарантировать это должны вы
	}
	
}

function GameObjectPropertyArrayBox(_array) : GameObjectProperty(_array) constructor {
	
	#region __private
	
	self.__array = [];
	
	#endregion
	
	static stateRemember = function() {
		
		var _size = array_length(self.__array);
		array_resize(self.__array, _size);
		array_copy(self.__array, 0, self.value, 0, _size);
	}
	
	static stateRecall = function() {
	
		var _size = array_length(self.value);
		array_resize(self.value, _size);
		array_copy(self.value, 0, self.__array, 0, _size);
		array_resize(self.__array, 0);
	}
	
}

#endregion

