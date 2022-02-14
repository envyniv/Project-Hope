extends StaticBody2D

func can_interact(interactParent : Node) -> bool:
    return interactParent is Player

func _interact(_interactParent : Node) -> void:
    #FileMan.inShop=true
    SceneManager.vending_up()
