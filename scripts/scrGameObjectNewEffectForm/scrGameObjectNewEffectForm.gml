#macro GAME_OBJECT_EFFECT_FORM_PREPROCESSOR_CHECK_UNIQUE true

enum GAME_OBJECT_EFFECT_TYPE { ADD = 0, UPD = 1, STACK = 2, COUNTER = 3 };

function gameObjectNewEffectForm(_name, _priority, _type, _maxTime, _create, _free, _tick) {
	
	static _map = __gameObjectFabEffectFormMapGet();
	
	var _object = {};
	with (_object) {
	
	#region init
	
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
	
	// функции                            /* arg0                */ /* space          */
	//															 
	self.__create = functorFunc(_create); /* new EffectInstance  */ /* void           */
	self.__free   = functorFunc(_free);	  /* EffectInstance      */ /* void           */
	self.__tick   = functorFunc(_tick);	  /* EffectInstance, arg */ /* EffectInstance */
	
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

