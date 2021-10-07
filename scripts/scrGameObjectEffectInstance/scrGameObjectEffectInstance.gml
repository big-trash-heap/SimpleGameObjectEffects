

function GameObjectEffectInstance(_effectForm) constructor {
	
	/* вы должны гарантировать, что поле и данные внутри него
	** не будут изменятся
	*/
	self.form = _effectForm;
	_effectForm.__create(self);
	
	#region __private
	
	self.__time  = _effectForm.maxTime;
	self.__count = 1;
	
	#endregion
	
}

