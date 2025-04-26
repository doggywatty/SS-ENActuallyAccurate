currentSelection = 0;
savedSelection = 0;
pauseStatus = false;
specialToggle = false;
musicPlaying = false;

defineMusic = function(_eventPath, _songDesc, _songComp, _special = "", _specialComp = _songComp) constructor
{
	static add = function()
	{
		array_push(obj_soundTest.musicArray, self);
		return self;
	};
	
	eventPath = _eventPath;
	eventInstance = undefined;
	
	if (!is_undefined(eventPath) && is_string(eventPath))
		eventInstance = fmod_createEventInstance(eventPath);
	
	songDescription = _songDesc;
	songComposer = _songComp;
	hasSpecial = _special != "";
	specialDesc = _special;
	specialComposer = _specialComp;
	return self.add();
};

musicArray = [];
new defineMusic("event:/music/Soundtest/intro", "Art Curse", "Paperkitty");
new defineMusic("event:/music/Soundtest/title_exhibition", "Exhibition Night", "Stewart Keller");
new defineMusic("event:/music/Soundtest/hub1", "Good Morning", "Stewart Keller");
new defineMusic("event:/music/Soundtest/options", "Pick Your Poison", "Stewart Keller");
new defineMusic("event:/music/Soundtest/pause", "Earth.", "CableChords");
new defineMusic("event:/music/Soundtest/tutorial", "Family Friendly", "PaperKitty");
new defineMusic("event:/music/Soundtest/harry", "Arkoudaphobia", "Stewart Keller");
new defineMusic("event:/music/Soundtest/entrywayPZ", "Down To Noise", "RodMod");
new defineMusic("event:/music/Soundtest/entrywayPZ_secret", "there's a secret inside my breakfast?", "Various");
new defineMusic("event:/music/Soundtest/cottontownA", "Steamy Cotton Candy", "RodMod", "Werecotton Mix");
new defineMusic("event:/music/Soundtest/cottontownB", "Around The Gateau's Gears", "RodMod", "Werecotton Mix");
new defineMusic("event:/music/Soundtest/cottontown_secret", "Lookie! You've found a steamy surprise.", "Various");
new defineMusic("event:/music/Soundtest/minesA", "Mineshaft Depths", "RodMod", "Minecart Mix", "RodMod, Pteracotta");
new defineMusic("event:/music/Soundtest/minesB", "Cobalt Catastrophe", "RodMod", "Minecart Mix", "RodMod, Pteracotta");
new defineMusic("event:/music/Soundtest/mines_secret", "a jawbreaking secret.", "Various");
new defineMusic("event:/music/Soundtest/molassesA", "Lost Chocolate", "CableChords, RodMod", "Focus Mix");
new defineMusic("event:/music/Soundtest/molassesB", "Found Chocolate", "CableChords", "Focus Mix");
new defineMusic("event:/music/Soundtest/molasses_secret", "man's lost secret.", "Various");
new defineMusic("event:/music/Soundtest/glucosegetaway", "Sugar Rush", "RodMod, CableChords, The8Bitdrummer");
new defineMusic("event:/music/Soundtest/sweetrelease", "Sweet Release of Death", "RodMod");
new defineMusic("event:/music/Soundtest/results", "Results!", "PaperKitty", "AWFUL Mix");
new defineMusic("event:/music/Soundtest/credits", "Toodle-oo!", "PaperKitty");
ini_open(global.SaveFileName);

if (ini_read_string("Game", "Judgment", "none") != "none")
	new defineMusic("event:/music/Soundtest/painterBrain", "Painter's Brain", "Stewart Keller");

if (ini_read_string("Treasure", "mindpalace", "0") != "0")
{
	new defineMusic("event:/music/Soundtest/painterMixtape", "Painter's Mixtape", "Stewart Keller, HyperTem", "OST Mix", "Stewart Keller");
	new defineMusic("event:/music/Soundtest/spiresamba", "Samba de Spire", "PaperKitty");
	new defineMusic("event:/music/Soundtest/mountainA", "Aw, Fudge! (Bonus)", "Pteracotta");
	new defineMusic("event:/music/Soundtest/mountainB", "Fudge It All! (Bonus)", "RodMod");
	new defineMusic("event:/music/Soundtest/mountain_secret", "what the fudge? it's a secret! (Bonus)", "Various");
	new defineMusic("event:/music/Soundtest/runthedog", "Run the Dog (Bonus)", "PaperKitty", "Marshmallow Mix");
	new defineMusic("event:/music/Soundtest/sugarcubehailstorm", "Sugarcube Hailstorm (Bonus)", "PaperKitty");
	new defineMusic("event:/music/Soundtest/painterBoss", "Painter's Theme (Bonus)", "CableChords");
	new defineMusic("event:/music/Soundtest/stinky", "What's that Smell? (Bonus)", "PaperKitty");
}

ini_close();
