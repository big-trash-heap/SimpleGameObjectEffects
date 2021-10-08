#macro GAME_OBJECT_EFFECT_FORM_PREPROCESSOR_CHECK_UNIQUE true

enum GAME_OBJECT_EFFECT_TYPE { ADD, UPD, STACK, COUNTER };

function gameObjectNewEffectForm(_name, _priority, _type, _maxTime, _create, _free, _tick) {
	
	var _object = {};
	with (_object) {
	
	#region init
	
	static _map = __gameObjectFabEffectFormMapGet();
	
	if (GAME_OBJECT_EFFECT_FORM_PREPROCESSOR_CHECK_UNIQUE) {
		
	if (ds_map_exists(_map, _name)) {
		
		show_error("gameObjectFabEffectForm: не может быть объектов с одинаковым именем", true);
	}
	
	if (ds_map_exists(_map, _priority)) {
		
		show_error("gameObjectFabEffectForm: не может быть объектов с одинаковым приоритетом", true);
	}
	
	}
	
	ds_map_set(_map, _name, self);
	ds_map_set(_map, _priority, self);
	
	#endregion
	
	/* вы должны гарантировать, что все эти поля никогда не будут изменены */
	
	// свойства
	self.name     = _name;     /* unique */
	self.priority = _priority; /* unique */
	
	self.type     = _type;
	self.maxTime  = _maxTime;
	
	#region __private
	
	// функции
	self.__create = getFunction(_create);
	self.__free   = getFunction(_free);
	self.__tick   = getFunction(_tick);
	
	#endregion
	
	}
	
}


#region __private

if (variable_global_exists("__gameObjecFabEffectFormMap")) exit;
global.__gameObjecFabEffectFormMap = ds_map_create();

function __gameObjectFabEffectFormMapGet() {
	static _init = scrGameObjectFabEffectForm();
	return global.__gameObjecFabEffectFromMap;
}

#endregion

