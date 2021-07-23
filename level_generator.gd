class_name TextureLevelGenerator2D
extends Node2D

export(Texture) var texture: Texture
export(int) var cell_size := 64
export(Array, Resource) var units = []

var image: Image

func _ready() -> void:
	
	for x in range(texture.get_width()):
		for y in range(texture.get_height()):
			generate_unit(x, y)

func generate_unit(x:int, y:int):
	var color := get_color(x, y)
	
	if color.a == 0:
		return
	for u in units:
		if u.color == color:
			u._scene = load(u.scene_path)
			var node = u._scene.instance()
			add_child(node)
			var pos := Vector2(x,y) * cell_size
			pos += Vector2.ONE * cell_size * .5
			node.position = pos
			print(pos)

func get_color(x: int, y: int) -> Color:
	if image == null:
		image = texture.get_data()
		image.lock()
	
	return image.get_pixel(x, y)
