# Godot AC-like Voicebox
original by [mattmarch](https://github.com/mattmarch), edited by envy
Male 1 by envy/Davide Azzaretto
Male 2 by Simone Andolina
Male 3 by supercatge/Alessandro Ficara
Female 1 by 
Female 2 by 
Female 3 by 
## Usage
1. Add Voicebox.tscn to your scene.
2. To read a string aloud pass it like `$Voicebox.play_string('Your example string!')`
3. The pitch can be varied by setting `$Voicebox.base_pitch` between 2.5 and 4.5.
4. The `characters_sounded` signal is emitted with the spoken characters as an argument when each sound is made, it can be used to make letters appear on the screen as the dialogue is spoken.
5. The `finished_phrase` signal is emitted once all the characters have been spoken.
6. Use [AudioEffectPitchShift](https://docs.godotengine.org/en/stable/classes/class_audioeffectpitchshift.html) to vary the pitch rather than `pitch_scale` in `AudioStreamPlayer` so that we don't speed up/slow down the dialogue when changing pitch. 
