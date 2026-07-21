extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var honks = 1
var unread_honks = 1
var full_months = {"Jan": "January", "Feb": "February", "Mar": "March", "Apr": "April", "May": "May", "Jun": "June", "Jul": "July", "Aug": "August", "Sep": "September", "Oct": "October", "Nov": "November", "Dec": "December"}
var all_honks = {}
var pres_handles = {"Argentina": "ArgentGov", "Australia": "AustraGov", "Bolivia": "BoliviGov", "Brazil": "BrazilGov", "Canada": "CanadaGov", "Central Africa": "CAfricaGov", "Central America": "CAmeriGov", "Central Asia": "CAsiaGov", "Chile": "ChileGov", "China": "ChinaGov", "Eastern Europe": "EEuropGov", "Finland": "FinlanGov", "Greenland": "GreenlGov", "Iceland": "IcelanGov", "India": "IndiaGov", "Indonesia": "IndoneGov", "Iran": "IranGov", "Ireland": "IrelanGov", "Japan": "JapanGov", "Kazakhstan": "KazakhGov", "Korea": "KoreaGov", "Madagascar": "MadagaGov", "Malaysia": "MalaysGov", "Mexico": "MexicoGov", "Mongolia": "MongoliGov", "New Zealand": "NewZeaGov", "Northeast Africa": "NEAfriGov", "Northwest Africa": "NWAfriGov", "Norway": "NorwayGov", "Papua New Guinea": "PNGuinGov", "Paraguay": "ParaguGov", "Peru": "PeruGov", "Phillippines": "PhilliGov", "Russia": "RussiaGov", "N South America": "NSAmerGov", "South Asia": "SAsiaGov", "Southern Africa": "SAfricGov", "Sweden": "SwedenGov", "UK": "UKGov", "USA": "USAGov", "Uruguay": "UruguaGov", "West Asia": "WAsiaGov", "West Europe": "WestEuGov"}
var hater_handles = ["Unwoke", "Patriot", "Cowboy"]
var hater_honks = ["@Cl1m4te Your username is so dumb lol. Climate change is fake.", "@Cl1m4te Go back to your woke bunker and let the rest of us live our lives.", "I passed a crying baby today. Who else suspects it was @Cl1m4te?", "@Cl1m4te You realise global warming is a hoax right? It snowed this winter lol", "@Cl1m4te My friend's a chiropracter and he says climate change is fake. What do you think of that?", "I can't believe idiots like @Cl1m4te still believe in climate change.", "@Cl1m4te Go back to wherever you came from loser.", "@Cl1m4te Sorry you've been brainwashed by the woke masses.", "It's nice outside today, but that doesn't fit @Cl1m4te's agenda so they won't mention it.", "@Cl1m4te The climate always warms. Only idiots think humans have something to do with it."]

# Called when the node enters the scene tree for the first time.
func _ready():
	if honks==1:
		update_unread()

func update_unread():
	get_parent().get_parent().get_parent().get_parent().get_node("MapCamera/SocialMediaButton/UnreadHonks/UnreadHonksText").text = str(unread_honks)

func load_honk(text, icon, username, date):
	var new_honk = get_node("Honk").duplicate()
	new_honk.get_node("HonkText").bbcode_text = text
	new_honk.get_node("Outline/ProfilePicture").texture = load("res://assets/profiles/profile" + str(icon) + ".png")
	new_honk.get_node("Username").text = "@" + username
	new_honk.get_node("Date").bbcode_text = date
	add_child(new_honk)
	move_child(new_honk, 0)

func new_honk(text, icon, username):
	var new_honk = get_node("Honk").duplicate()
	var clock = get_parent().get_parent().get_parent().get_node("Clock")
	var month = full_months[clock.months[clock.month_ind]]
	var year = clock.year
	new_honk.get_node("HonkText").bbcode_text = text
	new_honk.get_node("Outline/ProfilePicture").texture = load("res://assets/profiles/profile" + str(icon) + ".png")
	new_honk.get_node("Username").text = "@" + username
	new_honk.get_node("Date").bbcode_text = "[center]" + month + " " + str(year) + " via Honker app[/center]"
	add_child(new_honk)
	move_child(new_honk, 0)
	all_honks[honks] = [text, icon, username, new_honk.get_node("Date").bbcode_text]
	honks+=1
	
	if icon != 2:
		unread_honks += 1
		get_parent().get_parent().get_parent().get_parent().get_node("MapCamera/SocialMediaButton/UnreadHonks/UnreadHonksText").text = str(unread_honks)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





func _on_SocialMediaButton_pressed():
	unread_honks = 0
