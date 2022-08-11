extends Interactable
export(Resource) var item
export(Resource) var diag

func _interact(_interactParent : Node) -> void:
  assert(FileMan.add_item(item))
  SceneManager.start_convo(diag, self)
  queue_free()
  FileMan.data.itemsCollected += 1
  return
