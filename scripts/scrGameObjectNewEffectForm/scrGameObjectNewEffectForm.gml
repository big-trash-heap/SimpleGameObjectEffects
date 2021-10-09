#macro GAME_OBJECT_EFFECT_FORM_PREPROCESSOR_CHECK_UNIQUE true

/// @function gameObjectNewEffectForm(name, priority, constructorShell, [argumentShell], [f_tick], [f_updata], [f_create], [f_free]);
function gameObjectNewEffectForm(_name, _priority, _constructorShell, _argumentShell, _fTick, _fUpdata, _fCreate, _fFree) {
	
	static _map = __gameObjectFabEffectFormMapGet();
	
	var _object = {};
	with (_object) {
	
	#region init
	
	if (GAME_OBJECT_EFFECT_FORM_PREPROCESSOR_CHECK_UNIQUE) {
		
	if (ds_map_exists(_map, _name)) {
		
		show_error("gameObjectNewEffectForm: не может быть объектов с одинаковым именем", true);
	}
	
	if (ds_map_exists(_map, _priority)) {
		
		show_error("gameObjectNewEffectForm: не может быть объектов с одинаковым приоритетом", true);
	}
	
	}
	
	ds_map_set(_map, _name, self);
	ds_map_set(_map, _priority, self);
	
	#endregion
	
	/* вы должны гарантировать, что все эти поля и данные лежищие в них,
	** никогда не будут изменены
	*/
	
	// свойства
	self.name     = _name;     /* unique */
	self.priority = _priority; /* unique */
	
	applicatorSelf("argumentShell", _argumentShell);
	
	#region __private
	
	self.__constructorShell = _constructorShell;
	
	applicatorSelf("___tick",   applicatorSome(_fTick,   functorFunc));
	applicatorSelf("___updata", applicatorSome(_fUpdata, functorFunc));
	
	applicatorSelf("__create",  applicatorSome(_fCreate, functorFunc));
	applicatorSelf("__free",    applicatorSome(_fFree,   functorFunc));
	
	#endregion
	
	}
	
	return _object;
}


#region __private

if (variable_global_exists("scrGameObjectNewEffectFormMap")) exit;
global.scrGameObjectNewEffectFormMap = ds_map_create();

function __gameObjectFabEffectFormMapGet() {
	static _init = scrGameObjectNewEffectForm();
	return global.scrGameObjectNewEffectFormMap;
}

#endregion

