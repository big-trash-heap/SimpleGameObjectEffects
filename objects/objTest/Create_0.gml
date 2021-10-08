
gameObjectNewEffectForm(
"regen", 20, GameObjectEffectShellTime, 50,
function(_inst) {
	
	_inst.hp += 1;
});

gameObjectNewEffectForm(
"damage", 21, GameObjectEffectShellTime, 20,
function(_inst) {
	
	_inst.hp -= 1;
}, functorEm);

self.hand = new GameObjectEffectHandler();
self.hp = 100;