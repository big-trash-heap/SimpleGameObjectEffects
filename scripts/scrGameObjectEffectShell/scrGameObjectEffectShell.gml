

#region class-GameObjectEffectShell

function GameObjectEffectShell(_effectForm) : __GameObjectEffectShell(_effectForm) constructor {
	
	#region __private
		
	static __create = function() {
		
		var _f = self.form[$ "__create"];
		if (_f != undefined) _f();
	}
	
	static __free = function() {
		
		var _f = self.form[$ "__free"];
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
	
	static getTimeMax = function() {
		
		return self.form.argumentShell;
	}
	
	static getTimeLeft = function() {
		
		return self.__time;
	}
	
	static getTimePass = function() {
		
		return (self.form.argumentShell - self.__time);
	}
	
	static getCoefLeft = function() {
		
		return (self.__time / self.form.argumentShell);
	}
	
	static getCoefPass = function() {
		
		return (1 - self.__time / self.form.argumentShell);
	}
	
	static toString = function() {
		
		return (
			"name: " + string(self.form.name) + @"
time-left: " + string(self.getTimeLeft()) + @"
time-pass: " + string(self.getTimePass()) + @"
coef-left: " + string(self.getCoefLeft()) + @"
coef-pass: " + string(self.getCoefPass()));
	}
	
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
	
	static toString = function() {
		
		return ("name: " + string(self.form.name));
	}
	
}

#endregion

