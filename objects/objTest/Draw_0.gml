
if keyboard_check_pressed(ord("1"))
	self.hand.append("regen")

if keyboard_check_pressed(ord("2"))
	self.hand.append("damage")

if keyboard_check_pressed(ord("3"))
	self.hand.clear()

self.hand.tick(self);

self.hand.forAll(function(_effect, _data, _index) {
	
	draw_text(_index * 200, 0, @"
	name: " + string(_effect.form.name) + @"
");
});

draw_text(0, 512, self.hp);
