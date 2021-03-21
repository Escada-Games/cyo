extends Node2D
var radius=0
func _ready():
	$twn.interpolate_property(self,'radius',self.radius,24,0.66,Tween.TRANS_QUINT,Tween.EASE_OUT)
	$twn.interpolate_property(self,'modulate:a',self.modulate.a,0,0.33,Tween.TRANS_QUINT,Tween.EASE_IN,0.33)
	$twn.start()
	$twn.connect("tween_all_completed",self,'queue_free')
	set_process(true)
func _process(delta):
	update()
func _draw():
	draw_arc(Vector2(),self.radius,0,2*PI,360,Color('ffffff'),2.0)
