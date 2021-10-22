

#region class-GameObjectEffectShell

function GameObjectEffectShell(_effectForm) : __GameObjectEffectShell(_effectForm) constructor {
	
	#region __private
		
	static __create = function(_bind) {
		
		var _f = self.form[$ "__create"];
		if (_f != undefined) _f(_bind);
	}
	
	static __free = function(_bind) {
		
		var _f = self.form[$ "__free"];
		if (_f != undefined) _f(_bind);
	}
	
	static __updata = function(_bind) {
		
		self.form[$ "__updata"](_bind);
	}
	
	static __tick = function(_bind) {
		
		return self.form[$ "__tick"](_bind);
	}
	
	#endregion
	
}

function GameObjectEffectShellTime(_effectForm) : GameObjectEffectShell(_effectForm) constructor {
	
	#region __private
	
	self.__time = _effectForm.argumentShell;
	
	static __updata = function(_bind) {
		
		self.__time = self.form.argumentShell;
		self.form[$ "__updata"](_bind);
	}
	
	static __tick = function(_bind) {
		
		if (self.__time > 0) {
			
			--self.__time;
			self.form[$ "__tick"](_bind);
			return 0;
		}
		return 1;
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

function GameObjectEffectShellTimeStack(_effectForm) : GameObjectEffectShellTime(_effectForm) constructor {
	
	#region __private
	
	self.__time  = _effectForm.argumentShell.time;
	self.__count = 1;
	
	static __updata = function(_bind) {
		
		self.__time = self.form.argumentShell.time;
		if (self.__count < self.form.argumentShell.count) {
			++self.__count;
			self.form[$ "__updata"](_bind, 1);
		}
		else {
			self.form[$ "__updata"](_bind, 0);	
		}
	}
	
	static __tick = function(_bind) {
		
		if (self.form.argumentShell.uncount) {
			
			if (self.__count > 0) {
				--self.__time;
				self.form[$ "__tick"](_bind);
				if (self.__time == 0) {
					if (--self.__count > 0) self.__time = self.form.argumentShell.time;
					self.form[$ "__updata"](_bind, -1);
				}
				return 0;
			}
			return 1;
		}
		if (self.__time > 0) {
			
			--self.__time;
			self.form[$ "__tick"](_bind);
			return 0;
		}
		return 1;
	}
	
	#endregion
	
	static getTimeMax = function() {
		
		return self.form.argumentShell.time;
	}
	
	static getTimeLeft = function() {
		
		return self.__time;
	}
	
	static getTimePass = function() {
		
		return (self.form.argumentShell.time - self.__time);
	}
	
	static getCoefLeft = function() {
		
		return (self.__time / self.form.argumentShell.time);
	}
	
	static getCoefPass = function() {
		
		return (1 - self.__time / self.form.argumentShell.time);
	}
	
	static getCount = function() {
		
		return self.__count;
	}
	
	static getCountMax = function() {
		
		return self.form.argumentShell.count; 
	}
	
	static toString = function() {
		
		return (
			"name: " + string(self.form.name) + @"
time-left: " + string(self.getTimeLeft()) + @"
time-pass: " + string(self.getTimePass()) + @"
coef-left: " + string(self.getCoefLeft()) + @"
coef-pass: " + string(self.getCoefPass()) + @"
count: " + string(self.getCount()));
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

