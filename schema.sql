CREATE TABLE Character (
	ID INT PRIMARY KEY AUTOINCREMENT, Character TEXT, Player TEXT, Notes TEXT, Alias TEXT,
	Metatype TEXT, Ethnicity TEXT, Age INT, Sex TEXT, Height TEXT, Weight TEXT, 
	StreetCred TEXT, Notoriety TEXT, PublicAwareness TEXT, Karma INT, TotalKarma INT, 
	Misc TEXT, EdgePoints INT, 	Initiative TEXT, MatrixInitiative TEXT, 
	AstralInitiative TEXT, LifeStyle TEXT, Nuyen TEXT
	-- Body INT, Agility INT, Reaction INT, Strength INT, Willpower INT, 
	-- Logic INT, Intuition INT, Charisma INT, Edge INT, Essence REAL,
	-- MagicResonance INT, 
);

CREATE TABLE Character_Quality (
	ID INT PRIMARY KEY AUTOINCREMENT, CID INT, QID INT, Details TEXT, Karma INT
);

CREATE TABLE Character_Skill (
	ID INT PRIMARY KEY AUTOINCREMENT, CID INT, SID INT, Rating INT, Specialization TEXT, 
	Notes Text
);

CREATE TABLE Contact (
	ID INT PRIMARY KEY AUTOINCREMENT, CID INT, Name TEXT, Loyalty INT, Connection INT, 
	Favor TEXT, Misc TEXT
);

CREATE TABLE Quality (
	ID INT PRIMARY KEY AUTOINCREMENT, Name TEXT, Type TEXT, Cost INT, Description TEXT
);

CREATE TABLE Skill (
	ID INT PRIMARY KEY AUTOINCREMENT, Name TEXT, Type TEXT, `Default` BOOLEAN, 
	SkillGroup INT, Specializations TEXT, Description TEXT, Stat TEXT
);

CREATE TABLE Deck (
	ID INT PRIMARY KEY AUTOINCREMENT, CID INT, Model TEXT, Attack INT, Sleaze INT, 
	DeviceRating INT, DataProcessing INT, Firewall INT, MatrixDmg INT, MaxMatrixDmg INT
);

CREATE TABLE Deck_Program (
	ID INT PRIMARY KEY AUTOINCREMENT, DID INT, PID INT, Rating INT
);

CREATE TABLE Program (
	ID INT PRIMARY KEY AUTOINCREMENT, Name TEXT, `Desc` TEXT, Cost INT
);

CREATE TABLE Vehicle (
	ID INT PRIMARY KEY AUTOINCREMENT, CID INT, Name TEXT, Acceleration INT, Pilot INT, 
	Armor INT, Hadling TEXT, Speed TEXT, Body INT, Sensor INT, Notes TEXT
);

CREATE TABLE Gear (
	ID INT PRIMARY KEY AUTOINCREMENT, CID INT, Name TEXT, `Desc` TEXT, Rating INT, 
	Count INT, Active BOOLEAN
);

CREATE TABLE RangedWeapon (
	ID INT PRIMARY KEY AUTOINCREMENT, GID INT, Mode INT, Dmg TEXT, Acc TEXT, AP INT, RC INT,
	Ammo INT, ClipSize TEXT
);

CREATE TABLE Mode (
	ID INT PRIMARY KEY AUTOINCREMENT, Name TEXT, `Desc` TEXT, Ammo INT
);

CREATE TABLE Weapon_Mode (
	ID INT PRIMARY KEY AUTOINCREMENT, WID INT, MID INT
);

CREATE TABLE MeleeWeapon (
	ID INT PRIMARY KEY AUTOINCREMENT, GID INT, Dmg TEXT, Acc TEXT, Reach INT, AP INT
);

CREATE TABLE Armor (
	ID INT PRIMARY KEY AUTOINCREMENT, GID INT, `Set` TEXT, Notes TEXT
);

CREATE TABLE Spells (
	ID INT PRIMARY KEY AUTOINCREMENT, Name TEXT, Type TEXT, Target TEXT, Range TEXT, 
	Duration TEXT, Drain TEXT
);

CREATE TABLE Character_Spell (
	ID INT PRIMARY KEY AUTOINCREMENT, CID INT, SID INT
);

CREATE TABLE Powers (
	ID INT PRIMARY KEY AUTOINCREMENT, Name TEXT, Rating INT, Notes TEXT
);

CREATE TABLE Character_Augmentation (
	ID INT PRIMARY KEY AUTOINCREMENT, GID INT, AID INT, Ess REAL
);

CREATE TABLE Augmentation (
	ID INT PRIMARY KEY AUTOINCREMENT, Name TEXT, `Desc` TEXT, MaxRating INT, Capacity INT, 
	Avalibility TEXT, Cost INT, Type TEXT
);

CREATE TABLE Augmentation_Stat (
	ID INT PRIMARY KEY AUTOINCREMENT, AID INT, SID INT, Rating INT
);

CREATE TABLE Stat (
	ID INT PRIMARY KEY AUTOINCREMENT, Body INT, Agility INT, Reaction INT, Strength INT, 
	Willpower INT, Logic INT, Intuition INT, Charisma INT, Edge INT, Essence REAL, 
	MagicResonance INT
);

CREATE TABLE Character_Stat (
	ID INT PRIMARY KEY AUTOINCREMENT, CID INT, SID INT, Active BOOLEAN
);

