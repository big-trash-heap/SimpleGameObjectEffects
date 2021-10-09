

gameObjectNewEffectForm(
"regen", 20, GameObjectEffectShellTime, 10 * room_speed,
function(_inst) {
	
	_inst.hp += 1;
});

gameObjectNewEffectForm(
"damage", 21, GameObjectEffectShellTime, 4 * room_speed,
function(_inst) {
	
	_inst.hp -= 1;
}, functorEm);

self.hand = new GameObjectEffectHandler();
self.hp = 100;

