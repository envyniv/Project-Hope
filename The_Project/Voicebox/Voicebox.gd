extends AudioStreamPlayer
class_name VoiceBox

signal characters_sounded(characters)
signal finished_phrase()


const PITCH_MULTIPLIER_RANGE := 0.3
const INFLECTION_SHIFT := 0.4

export(float, 2.5, 4.5) var base_pitch := 3.5

const sounds = {
	'a': preload('res://Voicebox/Sounds/Male/1/a.wav'),
	'b': preload('res://Voicebox/Sounds/Male/1/b.wav'),
	'c': preload('res://Voicebox/Sounds/Male/1/c.wav'),
	'd': preload('res://Voicebox/Sounds/Male/1/d.wav'),
	'e': preload('res://Voicebox/Sounds/Male/1/e.wav'),
	'f': preload('res://Voicebox/Sounds/Male/1/f.wav'),
	'g': preload('res://Voicebox/Sounds/Male/1/g.wav'),
	'h': preload('res://Voicebox/Sounds/Male/1/h.wav'),
	'i': preload('res://Voicebox/Sounds/Male/1/i.wav'),
	'j': preload('res://Voicebox/Sounds/Male/1/j.wav'),
	'k': preload('res://Voicebox/Sounds/Male/1/k.wav'),
	'l': preload('res://Voicebox/Sounds/Male/1/l.wav'),
	'm': preload('res://Voicebox/Sounds/Male/1/m.wav'),
	'n': preload('res://Voicebox/Sounds/Male/1/n.wav'),
	'o': preload('res://Voicebox/Sounds/Male/1/o.wav'),
	'p': preload('res://Voicebox/Sounds/Male/1/p.wav'),
	'q': preload('res://Voicebox/Sounds/Male/1/q.wav'),
	'r': preload('res://Voicebox/Sounds/Male/1/r.wav'),
	's': preload('res://Voicebox/Sounds/Male/1/s.wav'),
	't': preload('res://Voicebox/Sounds/Male/1/t.wav'),
	'u': preload('res://Voicebox/Sounds/Male/1/u.wav'),
	'v': preload('res://Voicebox/Sounds/Male/1/v.wav'),
	'w': preload('res://Voicebox/Sounds/Male/1/w.wav'),
	'x': preload('res://Voicebox/Sounds/Male/1/x.wav'),
	'y': preload('res://Voicebox/Sounds/Male/1/y.wav'),
	'z': preload('res://Voicebox/Sounds/Male/1/z.wav'),
	'th': preload('res://Voicebox/Sounds/Male/1/th.wav'),
	'sh': preload('res://Voicebox/Sounds/Male/1/sh.wav'),
	' ': preload('res://Voicebox/Sounds/Misc/blank.wav'),
	'.': preload('res://Voicebox/Sounds/Misc/longblank.wav')
}


var remaining_sounds := []


func _ready():
	connect("finished", self, "play_next_sound")


func play_string(in_string: String):
	parse_input_string(in_string)
	play_next_sound()


func play_next_sound():
	if len(remaining_sounds) == 0:
		emit_signal("finished_phrase")
		return
	var next_symbol = remaining_sounds.pop_front()
	emit_signal("characters_sounded", next_symbol.characters)
	# Skip to next sound if no sound exists for text
	if next_symbol.sound == '':
		play_next_sound()
		return
	var sound: AudioStreamSample = sounds[next_symbol.sound]
	# Add some randomness to pitch plus optional inflection for end word in questions
	pitch_scale = base_pitch + (PITCH_MULTIPLIER_RANGE * randf()) + (INFLECTION_SHIFT if next_symbol.inflective else 0.0)
	stream = sound
	play()


func parse_input_string(in_string: String):
	for word in in_string.split(' '):
		parse_word(word)
		add_symbol(' ', ' ', false)
	

func parse_word(word: String):
	var skip_char := false
	var is_inflective := word[-1] == '?'
	for i in range(len(word)):
		if skip_char:
			skip_char = false
			continue
		# If not the last letter, check if next letter makes a two letter substring, e.g. 'th'
		if i < len(word) - 1:
			var two_character_substring = word.substr(i, i+2)
			if two_character_substring.to_lower() in sounds.keys():
				add_symbol(two_character_substring.to_lower(), two_character_substring, is_inflective)
				skip_char = true
				continue
		# Otherwise check if single character has matching sound, otherwise add a blank character
		if word[i].to_lower() in sounds.keys():
			add_symbol(word[i].to_lower(), word[i], is_inflective)
		else:
			add_symbol('', word[i], false)


func add_symbol(sound: String, characters: String, inflective: bool):
	remaining_sounds.append({
		'sound': sound,
		'characters': characters,
		'inflective': inflective
	})