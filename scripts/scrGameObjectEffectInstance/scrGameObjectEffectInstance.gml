#macro GAME_OBJECT_EFFECT_INSTANCE_PREPROCESSOR_CHECK_EXISTS true

function GameObjectEffectInstance(_name) constructor {
	
	var _map = __gameObjectFabEffectFormMapGet();
	
	if (GAME_OBJECT_EFFECT_INSTANCE_PREPROCESSOR_CHECK_EXISTS) {
	
	if (ds_map_exists(_map, _name) == false) {
		
		show_error("GameObjectEffectInstance: не существует указанной формы", true);
	}
	
	}
	
	/* вы должны гарантировать, что поле и данные внутри него
	** не будут изменятся
	*/
	self.form = _map[? _name];
	self.form.__create(self);
	
	#region __private
	
	self.__time  = _effectForm.maxTime;
	self.__count = 1;
	
	#endregion
	
}

