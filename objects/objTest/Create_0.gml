
gameObjectNewEffectForm(
"regen", 20, GAME_OBJECT_EFFECT_TYPE.ADD, 10 * 60,
function(_ef) {
	
	
},
function(_ef) {
	
},
function(_effect, _inst) {
	
	_inst.hp += 1;
});

gameObjectNewEffectForm(
"damage", 50, GAME_OBJECT_EFFECT_TYPE.COUNTER, 2 * 60,
function(_ef) {
	
	
},
function(_ef) {
	
},
function(_effect, _inst) {
	_inst.hp -= _effect.getCount();
});

self.hand = new GameObjectEffectHandler();
self.hp = 100;