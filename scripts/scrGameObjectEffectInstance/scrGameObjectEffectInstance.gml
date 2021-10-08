

#region class-GameObjectEffectInstance

function GameObjectEffectInstance(_effectForm) : __GameObjectEffectInstance(_effectForm) constructor {}

#endregion


#region __private

function __GameObjectEffectInstance(_effectForm) constructor {
	
	/* вы должны гарантировать, что поле и данные внутри него
	** не будут изменятся
	*/
	self.form = _effectForm;
	self.form.__create(self);
}

#endregion

