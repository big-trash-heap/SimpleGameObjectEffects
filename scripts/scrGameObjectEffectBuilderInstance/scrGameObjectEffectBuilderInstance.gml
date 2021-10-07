

function GameObjectEffectBuilderInstance(_effectForm) constructor {
	
	/* вы должны гарантировать, что поле и данные внутри него
	** не будут изменятся
	*/
	self.form = _effectForm;
	
	static setField = function(_key, _value) {
		
		self[$ _key] = _value;
		return self;
	}
	
	_effectForm.__create(self);
	
}

