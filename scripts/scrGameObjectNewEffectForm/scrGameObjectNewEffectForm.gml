#macro GAME_OBJECT_EFFECT_FORM_PREPROCESSOR_CHECK_UNIQUE true

function gameObjectNewEffectForm(_name, _priority, _create, _free, _tick, _updata) {
	
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
	
	#region __private
	
	// функции                                            /* arg0                */ /* space          */
	//
	self.__create = applicatorSome(_create, functorFunc); /* new EffectInstance  */ /* void           */
	self.__free   = applicatorSome(_free,   functorFunc); /* EffectInstance      */ /* void           */
	self.__tick   = applicatorSome(_tick,   functorFunc); /* EffectInstance, arg */ /* EffectInstance */
	self.__updata = applicatorSome(_updata, functorFunc); /* EffectInstance      */ /* EffectInstance */
	
	#endregion
	
	}
	
	return _name;
}


#region __private

if (variable_global_exists("scrGameObjectNewEffectFormMap")) exit;
global.scrGameObjectNewEffectFormMap = ds_map_create();

function __gameObjectFabEffectFormMapGet() {
	static _init = scrGameObjectNewEffectForm();
	return global.scrGameObjectNewEffectFormMap;
}

#endregion

