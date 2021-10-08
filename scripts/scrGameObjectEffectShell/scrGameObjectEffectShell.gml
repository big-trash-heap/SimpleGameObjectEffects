

#region class-GameObjectEffectShell

function GameObjectEffectShell(_effectForm) : __GameObjectEffectShell(_effectForm) constructor {
	
	#region __private
		
	static __create = function() {
		
		var _f = self.form.__create;
		if (_f != undefined) _f();
	}
	
	static __free = function() {
		
		var _f = self.form.__free;
		if (_f != undefined) _f();
	}
	
	static __updata = function() {
		
		var _f = self.form.__updata;
		if (_f != undefined) _f();
	}
	
	static __tick = function(_argument) {
		
		return self.form[$ "__tick"](_argument);
	}
	
	#endregion
	
}

#endregion


#region __private

function __GameObjectEffectShell(_effectForm) constructor {
	
	/* вы должны гарантировать, что поле и данные внутри него
	** не будут изменятся
	*/
	self.form = _effectForm;
	
	#region __private
	
	static __create = functorEm; /*         */
	static __free   = functorEm; /*         */
	static __tick   = functorEm; /* subject */
	static __updata = functorEm; /*         */
	
	#endregion
	
}

#endregion

