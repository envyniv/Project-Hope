[![# Official SVG Last Hope Logo](title.svg)](https://envyniv.github.io/Project-Hope)

_Run of the mill RPG with a somewhat unique battle system, where the main villain tries to blow up the sun with radiation._

> Developed in [Godot](https://godotengine.org/) with [Godot Dialogue Manager](https://github.com/nathanhoad/godot_dialogue_manager); fonts used include [PX Sans](https://github.com/teryror/pixel-fonts).
> Logo(s) by [envyniv](https://github.com/envyniv), OST BGM by [Fluffclipse](https://soundcloud.com/fluffclipse)

---

# Features
_This list is not complete and more elements may be added as time goes on._ 

_Don't use ticked elements to gauge development completion._

Estimated Completion Percentage:
![Pretty Much Nothing](https://progress-bar.dev/11?title=Overhauling%20Systems)

<details><summary>Entities</summary>

## Entities
  - [X] PlayerFollower -> PartyMember
  - [ ] Earthbound-like snake movement
  - [ ] _Parties_, Allow leader switch
  - [X] _Party -> AwareBase_:
  Instead of Party managing everything for the Player, make entities manage their own party, allowing for extra flexibility
  - [X] _FileMan's party funcs -> AwareBase_:
  Since entities now manage their parties, having the old functions makes little sense
  - [ ] _FileMan's item funcs -> AwareBase_?
  Should entities have their own inventories?
  - [ ] Stacking
    - [ ] Hide when colliding with `following`, show when not
    - [ ] Destroy when stacked
    - [ ] _NPC_, Stacking when joining party
  - [x] _Party members_, fix jittering
        ([related to normalized vectors](https://youtu.be/fZ6bOERw03M?t=123))
  - [x] _Party members_, fix always playing walk anim
  - [x] replace `snakeTail` & `follower` with a proper system
  - [ ] _NPC_, follow path node
  - [X] _NPC_, Remove "party dialog" property and "joins party" check.
  These things should be handled in dialogue scripts
  - [ ] Make proper use of state machines
  - [X] _AwareBase -> VesselBase_, _Lifeform -> Soul_

## Minor tweaks
  - [x] _Player_, fix bad animation names
  - [x] _NPC_, conditionally expose properties
  - [x] _Player_, Change Sprinting to Slingshot Running
  - [X] _Camera_, borrowing system:
  Instead of following only one entity, the camera will now remember every previous target, so that if its current target is deleted, the camera will being following the previous target, this should help avoiding hard crashes and add more flexibility
  - [X] _CameraLimits_, move to ReferenceRect

## Lifeforms
- [ ] use `_get_property_list()` instead of `export` for type safety when using the editor
  
</details>

<details><summary>Dialogue Box</summary>

  - [ ] Update to 1.17.10 spec
  - [ ] add speed modifiers as per Godot Dialogue Nodes
  - [x] make it so punctuation slows down text flow
  - [x] move to Godot Dialogue Nodes spec
  - [x] _dialogues_, fix itemnames and party member names not showing

</details>

<details><summary>Saving and Loading</summary>

  - [x] move to Godot Resource
  - [x] add previews
  - [x] allow for more than 3 saves
  - [x] fix Deleting save not giving focus back to plus button
  - [ ] _Save Slot Menu_, fix copy functionality
  - [X] _SaveFile_, remove party members?
  Since whole scene is saved, we can just use the party variable present in the Player entity. If not removing, use for save file sanitation.
  - [X] _SaveFile_, remove position and lead?
  Once again, since the whole current scene is saved, there really is no need for these to be in the save.
</details>

<details><summary>Modding</summary>

  - [x] _Save Slot_, mod selection dropdown
  - [x] _Mods_, implement loader
  - [ ] _FileMan_, load mods in folders

</details>

<details><summary>Settings and Controls</summary>

## Settings

- [x] allow a bunch of customization options (Volume, Text spd, video scaling)
- [x] make controller-friendly
- [x] add "Master" bus volume slider

## Controls

- [ ] _Controls_, make reboundable
  - [x] Keyboard
  - [ ] Controller
  - [ ] Mobile
- [x] _Controls_, fix scene
- [ ] Mobile
  
</details>

<details><summary>GUI</summary>

  - [x] _Pause Menu_, visual overhaul
  - [ ] UI Sounds
  - [ ] _Cursor_, Ddcouple from DiagBox
  - [ ] Dehardcode NodePaths

</details>

<details><summary>Misc Systems and Mechanics</summary>

  - [x] _Player_, split code in AwareBase, PlayerFollower, Player
  - [ ] _ScnChgTrigger_, implement on contact interact
  - [x] _ScnChgTrigger_, conditionally expose where on stage not null
  - [x] _Viewports_, replace `inbattle`, `inshop`, `indialog` with signals
  - [x] _FileMan_, offload all filechecks and loads to it
  - [x] _Splashscreen_, implement custom
  - [x] _Audio_, move volume management to Buses
  - [ ] _Photobooth_, replace setget with _get_property_list()
  - [ ] _Photobooth_, dehardcode node paths
  - [ ] _Party Member_, _MenuMoreMemberContainer_, _Player_, _SaveMenu_: dehardcode `NodePath`s
  - [ ] _ScnChgTrigger_, make it inherit from Interactable
    - [ ] _Interactable_, make it inherit from Area2D
  - [ ] fix custom classes not working properly / being seen as invalid hints;
  Apparently the order of the `extends` and `class_name` keyword matters.
  - [ ] _SceneManager_, rename `plsStartDialogue` to something more sensible

</details>

<details><summary>Battle System</summary>

  - [ ] Defense Phase (Tag)
  - [ ] Attack Phase (Turn-Based)
  - [ ] Item usage
  - [ ] _Skills_, implement

</details>

<details><summary>Assets</summary>

  - [ ] _Bella_, complete movement sprites
  - [ ] _Quinton_, complete movement sprites
  - [ ] _Charlie_, complete movement sprites
  - [ ] _Bella_, complete battle sprites
  - [ ] _Quinton_, complete battle sprites
  - [ ] _Charlie_, complete battle sprites

</details>

---

# Special Thanks

- Everyone in [my discord server](https://discord.gg/bNkDkHW) for being
  supportive
- You
- Gzillion/Newbie, Aléris, and gotimo2 for helping in the early days of the project
- Everyone from the [Godot Engine discord server](https://discord.gg/4JBkykG) for aiding newbies like myself
