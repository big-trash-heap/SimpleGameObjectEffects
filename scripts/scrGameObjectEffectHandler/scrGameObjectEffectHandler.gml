#macro GAME_OBJECT_EFFECT_HANDLER_APPEND_PREPROCESSOR_CHECK_EXISTS true

function GameObjectEffectHandler(_bind) constructor {
	
	#region __private
	
	static __map = __gameObjectNewEffectFormMapGet();
	static __fdata = {};
	
	self.__priorityArray = new PriorityArray();
	self.__bind = _bind;
	
	#endregion
	
	static clear = function() {
		
		static _ffunc = method_get_index(function(_effect, _data) {
			
			_effect.__free(_data);
			return true;
		});
		
		self.__priorityArray.forAllEnd(_ffunc, self.__bind);
	}
	
	static append = function(_nameEffectForm) {
		
		static _appendNew = function(_priorityArray, _form) {
			
			var _effect = new _form.__constructorShell(_form);
			_effect.__create(self.__bind);
			
			_priorityArray.addValEnd(_form.priority, _effect);
		}
		
		if (GAME_OBJECT_EFFECT_HANDLER_APPEND_PREPROCESSOR_CHECK_EXISTS) {
		
		if (ds_map_exists(self.__map, _nameEffectForm) == false) {
		
			show_error("GameObjectEffectHandler.append: не существует указанной формы", true);
		}
		
		}
		
		var _form = self.__map[? _nameEffectForm];
		if (_form.__isUpdata == false) {
			
			_appendNew(self.__priorityArray, _form);
			exit;
		}
		
		var _effectInd = self.__priorityArray.fndIndBegEq(_form.priority);
		if (_effectInd == -1) {
			
			_appendNew(self.__priorityArray, _form);
			exit;
		}
		
		self.__priorityArray.getVal(_effectInd).__updata(self.__bind);
	}
	
	// f -> with effect (with f.object : (effect, bind, data, index))
	static forAll = function(_f, _data) {
		
		static _ffunc = method_get_index(function(_effect, _fdata, _index) {
			
			with (_effect) {
			
			_index = _fdata[$ "f"](_effect, _fdata.this, _fdata.data, _index);
			if (_index == 1) _effect.__free(_fdata.this);
			
			return _index;
			
			}
		});
		
		self.__fdata.f    = _f;
		self.__fdata.data = _data;
		self.__fdata.this = self.__bind;
		
		self.__priorityArray.forAllBeg(_ffunc, self.__fdata);
		
		self.__fdata.f    = undefined;
		self.__fdata.data = undefined;
		self.__fdata.this = undefined;
	}
	
	static tick = function() {
		
		static _ffunc = method_get_index(function(_effect, _data) {
			
			if (_effect.__tick(_data)) {
				
				_effect.__free(_data);
				return 1;
			}
			
		});
		
		self.__priorityArray.forAllBeg(_ffunc, self.__bind);
	}
	
}

