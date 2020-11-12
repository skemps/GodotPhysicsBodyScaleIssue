extends Spatial

const STATIC_BODY = preload("res://StaticBody.tscn")
var timer: float = 0.0

func _physics_process(delta):
	timer += delta
	var s = sin(timer)
	if s < 0.0:
		s = 0.0
	$MeshInstance.scale = Vector3(s,s,s)
	
	var from = $Camera.project_ray_origin(self.get_viewport().get_mouse_position())
	var to = from + $Camera.project_ray_normal(self.get_viewport().get_mouse_position()) * 100.0
	
	var space_state = get_world().direct_space_state
	var result = space_state.intersect_ray(from, to)
	if !result:
		print('Nothing detected: ' + str(timer))
		$LabelDetection.text = 'Nothing detected'
	else:
		print('Cube detected: ' + str(timer))
		$LabelDetection.text = 'Cube detected'
