
if keyboard_check_pressed(ord("1"))
	self.hand.append("regen")

if keyboard_check_pressed(ord("2"))
	self.hand.append("damage")

if keyboard_check_pressed(ord("3"))
	self.hand.append("counters")
	
if keyboard_check_pressed(ord("C"))
	self.hand.clear()

self.hand.tick();

self.hand.forAll(function(_effect, _0, _1, _index) {
	
	draw_text(_index * 200, 0, _effect);
});

draw_text(0, 512, self.hp);
