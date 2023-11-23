extends Resource

class_name Inventory

signal updated

@export var items: Array[Inventory_Items]

func insert(item: Inventory_Items):
	for i in range(items.size()):
		if !items[i]:
			items[i] = item
			break
	updated.emit()
