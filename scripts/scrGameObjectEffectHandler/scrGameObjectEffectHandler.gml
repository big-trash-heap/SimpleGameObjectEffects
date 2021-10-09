#macro GAME_OBJECT_EFFECT_HANDLER_APPEND_PREPROCESSOR_CHECK_EXISTS true

function GameObjectEffectHandler() constructor {
	
	#region __private
	
	static __map = __gameObjectFabEffectFormMapGet();
	static __fdata = {};
	
	self.__priorityArray = new PriorityArray();
	
	#endregion
	
	static clear = function() {
		
		static _ffunc = method_get_index(function(_effect, _data, _index) {
			
			_effect.__free();
			return true;
		});
		
		self.__priorityArray.forAllEnd(_ffunc);
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
		if (_form[$ "__updata"] == undefined) {
			
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
		
		static _ffunc = method_get_index(function(_effect, _fdata, _index) {
			
			with (_effect) {
			
			if (_fdata[$ "f"](_effect, _fdata.data, _index)) {
				
				_effect.__free();
				return true;
			}
			
			}
		});
		
		self.__fdata.f    = _f;
		self.__fdata.data = _data;
		
		self.__priorityArray.forAllBeg(_ffunc, self.__fdata);
		
		self.__fdata.f    = undefined;
		self.__fdata.data = undefined;
	}
	
	static tick = function(_data) {
		
		static _ffunc = method_get_index(function(_effect, _data, _index) {
			
			if (_effect.__tick(_data, _index)) {
				
				_effect.__free();
				return true;
			}
			
		});
		
		self.__priorityArray.forAllBeg(_ffunc, _data);
	}
	
}

