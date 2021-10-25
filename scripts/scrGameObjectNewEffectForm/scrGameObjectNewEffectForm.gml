#macro GAME_OBJECT_EFFECT_FORM_PREPROCESSOR_CHECK_UNIQUE true

/*
	with (effect) {
		f_tick(bind)
		f_updata(bind)
		f_create(bind)
		f_free(bind)
		
		custom f::f (effect, bind, data, index)
	}
*/

/// @function gameObjectNewEffectForm(name, priority, constructorShell, [argumentShell], [f_tick], [f_create], [f_free]);
function gameObjectNewEffectForm(_name, _priority, _constructorShell, _argumentShell, _fTick, _fCreate, _fFree) {
	
	#region __private
	
	var _object = __gameObjectNewEffectForm(_name, _priority, _constructorShell, _argumentShell);
	with (_object) {
	
	self.__isUpdata = false;
	self.__tick     = applicatorSome(_fTick,   functorFunc, functorEm);
	self.__create   = applicatorSome(_fCreate, functorFunc, functorEm);
	self.__free     = applicatorSome(_fFree,   functorFunc, functorEm);
	
	}
	
	#endregion
	
	return _object;
}

/// @function gameObjectNewEffectFormUpdata(name, priority, constructorShell, [argumentShell], [f_tick], [f_updata], [f_create], [f_free]);
function gameObjectNewEffectFormUpdata(_name, _priority, _constructorShell, _argumentShell, _fTick, _fUpdata, _fCreate, _fFree) {
	
	#region __private
	
	var _object = __gameObjectNewEffectForm(_name, _priority, _constructorShell, _argumentShell);
	with (_object) {
	
	self.__isUpdata = true;
	self.__tick     = applicatorSome(_fTick,   functorFunc, functorEm);
	self.__updata   = applicatorSome(_fUpdata, functorFunc, functorEm);
	self.__create   = applicatorSome(_fCreate, functorFunc, functorEm);
	self.__free     = applicatorSome(_fFree,   functorFunc, functorEm);
	
	}
	
	#endregion
	
	return _object;
}


#region __private

function __gameObjectNewEffectFormMapGet() {
	static _map = ds_map_create();
	return _map;
}

function __gameObjectNewEffectForm(_name, _priority, _constructorShell, _argumentShell) {
	
	var _map = __gameObjectNewEffectFormMapGet();
	
	if (GAME_OBJECT_EFFECT_FORM_PREPROCESSOR_CHECK_UNIQUE) {
	
	if (ds_map_exists(_map, _name)) {
		
		show_error("__gameObjectNewEffectForm: не может быть объектов с одинаковым именем", true);
	}
	
	if (ds_map_exists(_map, _priority)) {
		
		show_error("__gameObjectNewEffectForm: не может быть объектов с одинаковым приоритетом", true);
	}
	
	}
	
	var _object = {};
	with (_object) {
	
	ds_map_set(_map, _name, self);
	ds_map_set(_map, _priority, self);
	
	/* вы должны гарантировать, что все эти поля и данные лежищие в них,
	** никогда не будут изменены
	*/
	
	// свойства
	self.name     = _name;     /* unique */
	self.priority = _priority; /* unique */
	
	applicatorSelf("argumentShell", _argumentShell);
	
	#region __private
	
	self.__constructorShell = _constructorShell;
	
	#endregion
	
	}
	
	return _object;
}

#endregion

