extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var screensize = Vector2()
onready var rnd = RandomNumberGenerator.new()
onready var flagT

#Quando o objeto é chamado, ele se inicia em uma posição aleatória acima da tela
func _ready():
	screensize = get_viewport_rect().size
	rnd.randomize()
	var random = rnd.randf_range(40,screensize.x-40)
	position.x = random
	pass # Replace with function body.

#A cada frame ele se move para baixo
func _process(delta):
	
	position.y += (100 *delta)
	

func _change_Flag(flag):
	flagT = flag

#Ao colidir com qualquer área, player ou "chão", se deleta
func _on_Area2D_area_entered(area):
	self.queue_free()
