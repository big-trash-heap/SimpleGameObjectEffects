

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
		
		self.form[$ "__updata"]();
	}
	
	static __tick = function(_argument) {
		
		return self.form[$ "__tick"](_argument);
	}
	
	#endregion
	
}

function GameObjectEffectShellTime(_effectForm) : GameObjectEffectShell(_effectForm) constructor {
	
	#region __private
	
	self.__time = _effectForm.argumentShell;
	
	static __updata = function() {
		
		self.__time = self.form.argumentShell;
		self.form[$ "__updata"]();
	}
	
	static __tick = function(_argument) {
		
		if (self.__time > 0) {
			
			--self.__time;
			self.form[$ "__tick"](_argument);
			return false;
		}
		return true;
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

