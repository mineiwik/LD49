extends Control


var death_notes = {
	"military": "Your army was, let's just say, too weak!",
	"diplomacy": "Your neighboring countries were stronger than you, try again!",
	"money": "You may be full of pride, but unfortunately your banks are not...",
	"stability": "Your nation was too unstable, I'm sorry..."
}

onready var death_note = $TextureRect/DeathNote

func _ready():
	death_note.text = death_notes[Manager.cause_of_death]


func _on_TextureButton_pressed():
	var err := get_tree().change_scene("res://scenes/overview.tscn")
	assert(err == OK)
