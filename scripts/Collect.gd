extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var screensize = Vector2()
onready var cube = preload("res://cenas/Requisito.tscn")
onready var container = get_node("container")
onready var scoretext = get_node("scoretext")
onready var rnd = RandomNumberGenerator.new()
onready var ground = get_node("ground")
onready var finish = get_node("finish")
var total = 0
var flag
var score = 0
var limite = 0
var Flim = 0
var NFlim = 0
var ReqFList = ["RF1","RF2","RF3"]#,"RF4","RF5","RF6","RF7","RF8","RF9","RF10"]
var ReqNFList = ["RNF1","RNF2","RNF3"]#,"RNF4","RNF5","RNF6","RNF7","RNF8","RNF9","RNF10"]

# Called when the node enters the scene tree for the first time.
func _ready():
	ReqFList = shuffleList(ReqFList)
	ReqNFList = shuffleList(ReqNFList)
	screensize = get_viewport_rect().size

func _process(delta):
	scoretext.set_text(String(score))

#Randomiza a lista de requisitos
func shuffleList(list):
	var shuffledList = []
	var indexList = range(list.size())
	for i in range(list.size()):
		randomize()
		var x = randi()%indexList.size()
		shuffledList.append(list[x])
		indexList.remove(x)
		list.remove(x)
	return shuffledList

#ao fechar o timer, pega um número baseado no limite, na lista, e instância um bloco de requisito
func _on_Timer_timeout():
	if limite < 6:
		rnd.randomize()
		var reqrand = rnd.randi_range(1,2)
		#var randomindex = rnd.randi_range(1,3)
		#print(ReqFList[limite])
		if reqrand == 1 && Flim < ReqFList.size():
			var c = cube.instance()
			var reqtext = c.get_node("reqtext")
			var flag = c.get_node(".")
			c._change_Flag(1)
			reqtext.set_text(String(ReqFList[Flim]))
			container.add_child(c)
			Flim += 1
			limite += 1
		else:
			reqrand = 2
		#Se reqrand = 1 e não houverem mais argumentos no primeiro array, transportar para a outra opção
		#Por algum motivo ele ainda tenta entrar mesmo Flim >= ReqFList.size, sem pensamento cabeça de vento
		if reqrand == 2 && NFlim < ReqNFList.size():
			var c = cube.instance()
			var reqtext = c.get_node("reqtext")
			var flag = c.get_node(".")
			c._change_Flag(2)
			reqtext.set_text(String(ReqNFList[NFlim]))
			container.add_child(c)
			NFlim += 1
			limite += 1
		else:
			reqrand = 1

#Ao colidir com o player, aumenta o score
func _on_Area2D_area_entered(area):
	total += 1
	print(total)
	if area.flagT == 1:
		score += 1
	if total == limite:
		print("Finish!")
		finish.set_visible(1)

func _on_ground_area_entered(area):
	total += 1
	print(total)
	if total == limite:
		print("Finish!")
		finish.set_visible(1)
