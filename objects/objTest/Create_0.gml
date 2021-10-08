
gameObjectNewEffectForm(
"regen", 20, GameObjectEffectShell, 
function(_inst) {
	
	_inst.hp += 1;
});

gameObjectNewEffectForm(
"damag", 20, GameObjectEffectShell, 
function(_inst) {
	
	_inst.hp -= 1;
});

self.hand = new GameObjectEffectHandler();
self.hp = 100;