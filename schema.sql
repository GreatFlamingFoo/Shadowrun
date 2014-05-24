CREATE TABLE Character (
	ID INT PRIMARY KEY, Character TEXT, Player TEXT, Notes TEXT, Alias TEXT,
	Metatype TEXT, Ethnicity TEXT, Age INT, Sex TEXT, Height TEXT, Weight TEXT, 
	StreetCred TEXT, Notoriety TEXT, PublicAwareness TEXT, Karma INT, TotalKarma INT, 
	Misc TEXT, Body INT, Agility INT, Reaction INT, Strength INT, Willpower INT, 
	Logic INT, Intuition INT, Charisma INT, Edge INT, EdgePoints INT, Essence REAL,
	MagicResonance INT, Initiative TEXT, MatrixInitiative TEXT, AstralInitiative TEXT,
	LifeStyle TEXT, Nuyen TEXT
);

CREATE TABLE Character_Quality (
	ID INT PRIMARY KEY, CID INT, QID INT, Details TEXT
);

CREATE TABLE Character_Skill (
	ID INT PRIMARY KEY, CID INT, SID INT, Rating INT, Specialization TEXT, Notes Text
);

CREATE TABLE Contact (
	ID INT PRIMARY KEY, CID INT, Name TEXT, Loyalty INT, Connection INT, Favor TEXT,
	Misc TEXT
);

CREATE TABLE Quality (
	ID INT PRIMARY KEY, Name TEXT, Type TEXT, Cost INT, Description TEXT
);

CREATE TABLE Skill (
	ID INT PRIMARY KEY, Name TEXT, Type TEXT, `Default` BOOLEAN, SkillGroup INT,
	Specializations TEXT, Description TEXT, Stat TEXT
);
