
enum GAME_OBJECT_EFFECT_TYPE { ADD, UPD, STACK, COUNTER };

function GameObjectEffectBuilderForm(_type, _priority, _maxTime, _create, _free, _tick) constructor {
	
	/* вы должны гарантировать, что все эти поля никогда не будут изменены */
	
	// свойства
	self.type     = _type;
	self.priority = _priority;
	self.maxTime  = _maxTime;
	
	#region __private
	
	// функции
	self.__create = getFunction(_create);
	self.__free   = getFunction(_free);
	self.__tick   = getFunction(_tick);
	
	#endregion
}

