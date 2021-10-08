#macro GAME_OBJECT_EFFECT_HANDLER_APPEND_PREPROCESSOR_CHECK_EXISTS true

function GameObjectEffectHandler() constructor {
	
	#region __private
	
	static __map = __gameObjectFabEffectFormMapGet();
	
	self.__priorityArray = new PriorityArray();
	
	#endregion
	
	static clear = function() {
		
		self.__priorityArray.clr();
	}
	
	static append = function(_nameEffectForm) {
		
		static _appendNew = function(_priorityArray, _form) {
			
			var _effect = new _form.__constructorShell(_form);
			_effect.__create();
			
			_priorityArray.addValEnd(_form.priority, _effect);
		}
		
		if (GAME_OBJECT_EFFECT_HANDLER_APPEND_PREPROCESSOR_CHECK_EXISTS) {
		
		if (ds_map_exists(self.__map, _nameEffectForm) == false) {
		
			show_error("GameObjectEffectHandler.append: не существует указанной формы", true);
		}
		
		}
		
		var _form = self.__map[? _nameEffectForm];
		if (_form.__updata == undefined) {
			
			_appendNew(self.__priorityArray, _form);
			exit;
		}
		
		var _effectInd = self.__priorityArray.fndIndBeg(_form.priority);
		if (_effectInd == -1) {
			
			_appendNew(self.__priorityArray, _form);
			exit;
		}
		
		self.__priorityArray.getVal(_effectInd).__updata();
	}
	
	static forAll = function(_f, _data) {
		
		self.__priorityArray.forAllBeg(_f, _data);
	}
	
	static tick = function(_data) {
		
		self.__priorityArray.forAllBeg(
		function(_effect, _arg) {
			
			var _form = _effect.form;
			
			_effect.__time -= 1;
			_form.__tick(_effect, _arg);
			
			if (_effect.__time == 0) {
				
				if (_form.type == GAME_OBJECT_EFFECT_TYPE.COUNTER) {
					
					_effect.__count -= 1;
					if (_effect.__count == 0) {
						
						_form.__free(_effect);
						return true;
					}
					
					_effect.__time = _form.maxTime;
				}
				else {
					
					_form.__free(_effect);
					return true;
				}
			}
			
		}, _data);
	}
	
}

