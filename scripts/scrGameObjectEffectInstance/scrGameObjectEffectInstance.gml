
#region __private

function __GameObjectEffectInstance(_effectForm) constructor {
	
	/* вы должны гарантировать, что поле и данные внутри него
	** не будут изменятся
	*/
	self.form = _effectForm;
	self.form.__create(self);
	
	#region __private
	
	self.__time = _effectForm.maxTime;
	
	if (self.form.type > GAME_OBJECT_EFFECT_TYPE.UPD) 
		self.__count = 1;
	
	#endregion
	
	static getTime = function() {
		
		return self[$ "__time"];
	}
	
	static getCount = function() {
		
		return self[$ "__count"];
	}
	
	static getCoef = function() {
		
		return self[$ "__time"] / self.form.maxTime;
	}
	
}

#endregion

