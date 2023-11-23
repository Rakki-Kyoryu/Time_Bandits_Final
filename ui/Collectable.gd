extends Area2D

@export var item_res: Inventory_Items

func collect(inventory: Inventory):
	inventory.insert(item_res)
	queue_free()
