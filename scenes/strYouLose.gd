extends Label

var vVelocity=Vector2(0,-128)
var fAngularSpeed=10

func _ready():
	randomize()
	vVelocity.y+=rand_range(-16,16)
	fAngularSpeed+=rand_range(-2,2)
	self.rect_global_position.x+=rand_range(-16,16)
	self.rect_global_position.y+=rand_range(-16,16)
	
	self.rect_scale=Vector2()
	$twn.interpolate_property(self,'rect_scale',self.rect_scale,Vector2(1,1)*rand_range(0.8,1.2),0.33,Tween.TRANS_BACK,Tween.EASE_OUT)
	$twn.start()
	
	set_process(true)
func _process(delta):
	self.rect_rotation+=fAngularSpeed*delta
	vVelocity.y+=9.8
	self.rect_global_position+=vVelocity*delta
	if self.rect_global_position.y>600:
		self.queue_free()
