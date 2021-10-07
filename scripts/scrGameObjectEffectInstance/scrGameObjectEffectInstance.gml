

function GameObjectEffectInstance(_effectForm) constructor {
	
	/* вы должны гарантировать, что поле и данные внутри него
	** не будут изменятся
	*/
	self.form = _effectForm;
	_effectForm.__create(self);
	
}

