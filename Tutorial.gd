extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var step

# Called when the node enters the scene tree for the first time.
func _ready():
	step = 0

func step(step):
	if step == 0:
		get_node("MenuArrow").visible = true
		get_node("MenuInfo").visible = true
	elif step == 1:
		get_node("MenuArrow").visible = false
		get_node("MenuInfo").visible = false
		get_node("ClockArrow1").visible = true
		get_node("ClockInfo1").visible = true
	elif step == 2:
		get_node("ClockArrow1").visible = false
		get_node("ClockInfo1").visible = false
		get_node("ClockArrow2").visible = true
		get_node("ClockInfo2").visible = true
	elif step == 3:
		get_node("ClockArrow2").visible = false
		get_node("ClockInfo2").visible = false
		get_node("HonkerArrow").visible = true
		get_node("HonkerInfo").visible = true
	elif step == 4:
		get_node("HonkerArrow").visible = false
		get_node("HonkerInfo").visible = false
		get_parent().get_node("SocialMediaPage").visible = true
		get_parent().get_node("SocialMediaPage/HonkerArrow2").visible = true
		get_parent().get_node("SocialMediaPage/HonkerInfo2").visible = true
		get_parent().get_node("SocialMediaPage").pause_mode = Node.PAUSE_MODE_INHERIT
	elif step == 5:
		get_parent().get_node("SocialMediaPage/HonkerArrow2").visible = false
		get_parent().get_node("SocialMediaPage/HonkerInfo2").visible = false
		get_parent().get_node("SocialMediaPage/HonkerArrow3").visible = true
		get_parent().get_node("SocialMediaPage/HonkerInfo3").visible = true
	elif step == 6:
		get_parent().get_node("SocialMediaPage/HonkerArrow3").visible = false
		get_parent().get_node("SocialMediaPage/HonkerInfo3").visible = false
		get_parent().get_node("SocialMediaPage/HonkerArrow4").visible = true
		get_parent().get_node("SocialMediaPage/HonkerInfo4").visible = true
	elif step == 7:
		get_parent().get_node("SocialMediaPage/HonkerArrow4").visible = false
		get_parent().get_node("SocialMediaPage/HonkerInfo4").visible = false
		get_parent().get_node("SocialMediaPage").visible = false
		get_parent().get_node("SocialMediaPage").pause_mode = Node.PAUSE_MODE_PROCESS
		get_node("LabArrow").visible = true
		get_node("LabInfo").visible = true
	elif step == 8:
		get_node("LabArrow").visible = false
		get_node("LabInfo").visible = false
		get_node("InfoArrow").visible = true
		get_node("InfoInfo").visible = true
	elif step == 9:
		get_node("InfoArrow").visible = false
		get_node("InfoInfo").visible = false
		get_node("CountryInfoArrow").visible = true
		get_node("CountryInfo").visible = true
	elif step == 10:
		get_node("CountryInfoArrow").visible = false
		get_node("CountryInfo").visible = false
		get_node("LabArrow2").visible = true
		get_node("LabInfo2").visible = true
	elif step == 11:
		get_node("LabArrow2").visible = false
		get_node("LabInfo2").visible = false
		get_parent().position = Vector2(3780, 3510)
		get_parent().get_parent().get_node("InteractBG/CurrentCP").bbcode_text = "[center]Current CP:  100[/center]"
		get_parent().get_parent().get_node("InteractBG/TutorialLab").visible = true
		get_parent().get_parent().get_node("InteractBG/TutorialLab/LabArrow").visible = true
		get_parent().get_parent().get_node("InteractBG/TutorialLab/LabInfo").visible = true
	elif step == 12:
		get_parent().get_parent().get_node("InteractBG/TutorialLab/LabArrow").visible = false
		get_parent().get_parent().get_node("InteractBG/TutorialLab/LabInfo").visible = false
		get_parent().get_parent().get_node("InteractBG/TutorialLab/LabArrow2").visible = true
		get_parent().get_parent().get_node("InteractBG/TutorialLab/LabInfo2").visible = true
	elif step == 13:
		get_parent().position.x += 1080
		get_parent().get_parent().get_node("InteractBG/TutorialLab/LabArrow2").visible = false
		get_parent().get_parent().get_node("InteractBG/TutorialLab/LabInfo2").visible = false
		get_parent().get_parent().get_node("VirusLabBG/LabArrow").visible = true
		get_parent().get_parent().get_node("VirusLabBG/LabInfo").visible = true
	elif step == 14:
		get_parent().position = Vector2(2160,1170)
		get_parent().get_parent().get_node("VirusLabBG/LabArrow").visible = false
		get_parent().get_parent().get_node("VirusLabBG/LabInfo").visible = false
		get_node("EndMessage").visible = true
	elif step == 15:
		get_node("EndMessage").visible = false
		visible = false
		get_parent().get_parent().tutorialDone()
		var perm_stats = ConfigFile.new()
		var err2 = perm_stats.load("user://perm_stats.cfg")
		perm_stats.set_value("Tutorial", "Finished", true)
		perm_stats.save("user://perm_stats.cfg")
	else:
		get_parent().get_parent().tutorial_on = false

func begin_tutorial():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event is InputEventScreenTouch and event.pressed and get_parent().get_parent().tutorial_on:
		step(step)
		step+=1

