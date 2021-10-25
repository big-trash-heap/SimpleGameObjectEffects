

gameObjectNewEffectForm(
"regen", 20, GameObjectEffectShellTime, 10 * room_speed,
function(_inst) {
	
	_inst.hp += 1;
});

gameObjectNewEffectFormUpdata(
"damage", 21, GameObjectEffectShellTime, 4 * room_speed,
function(_inst) {
	
	_inst.hp -= 1;
});

gameObjectNewEffectFormUpdata(
"counters", -1, GameObjectEffectShellTimeStack, {
	time: 4 * room_speed,
	count: infinity,
	uncount: true,
});

self.hand = new GameObjectEffectHandler(self);
self.hp = 100;

