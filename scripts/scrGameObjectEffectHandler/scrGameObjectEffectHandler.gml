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
		
		if (GAME_OBJECT_EFFECT_HANDLER_APPEND_PREPROCESSOR_CHECK_EXISTS) {
		
		if (ds_map_exists(self.__map, _nameEffectForm) == false) {
		
			show_error("GameObjectEffectHandler.append: не существует указанной формы", true);
		}
		
		}
		
		var _form = self.__map[? _nameEffectForm];
		if (_form.type == GAME_OBJECT_EFFECT_TYPE.ADD) {
			
			self.__priorityArray.addValEnd(_form.priority, new __GameObjectEffectInstance(_form));
			exit;
		}
		
		var _effectInd = self.__priorityArray.fndIndBeg(_form.priority);
		if (_effectInd == -1) {
			
			self.__priorityArray.addValEnd(_form.priority, new __GameObjectEffectInstance(_form));
			exit;
		}
		
		var _effect = self.__priorityArray.getVal(_effectInd);
		
		_effect.__time = _form.maxTime;
		if (_form.type != GAME_OBJECT_EFFECT_TYPE.UPD) {
			
			_effect.__count += 1;
		}
		
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
					
					_effect.__counter -= 1;
					if (_effect.__counter == 0) {
						
						_form.__free(_effect);
						return true;
					}
				}
				else {
					
					_form.__free(_effect);
					return true;
				}
			}
			
		}, _data);
	}
	
}

