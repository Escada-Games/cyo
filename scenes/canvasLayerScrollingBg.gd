extends CanvasLayer
var fOffset=0
var fSpacing=64#20#32*sqrt(2)
const fSpeed=100
const bgTile=preload("res://scenes/bgTile.tscn")
func _ready():
	for i in range(-1,12):
		for j in range(-1,9):
			var k=bgTile.instance()
			k.global_position=Vector2(i,j)*fSpacing#+Vector2(1,1)*fOffset
			add_child(k)
	set_process(true)
func _process(delta):
	fOffset=delta*fSpeed#wrapf(fOffset+delta*fSpeed,0,fSpacing)
	for node in self.get_children():
		node.global_position.x=wrapf(node.global_position.x+delta*fSpeed,-fSpacing,640+fSpacing)
		node.global_position.y=wrapf(node.global_position.y+delta*fSpeed,-fSpacing,500+fSpacing)
