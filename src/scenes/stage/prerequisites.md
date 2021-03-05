# STAGE PREREQUISITES
A stage must have:
- StaticBody2D with TextureRect and Collision[Shape/Polygon]
- CameraLimits instanced scene
- PlayerSpawn instanced scene
- Hidden Label node whose text is the name of the stage and that has been renamed to "Stage_Name"
*ALL UNDER A RENAMED "Scene" Node which is actually just a basic Node (NOT NODE2D)*
The Structure must, then, be as follows:
```
"Stage" Node
|
└──"Stage_Name" Label with Name as text (Not visible)
|
└──StaticBody2D
|       |
|       └──TextureRect
|       |
|       └──Collision[Shape/Polygon; Polygon preferred]
|
└──CameraLimits (tick editable children)
|
└──PlayerSpawn
```