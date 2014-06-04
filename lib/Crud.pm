package Shadowrun;
use Dancer ':syntax';
use Dancer::Plugin::SimpleCRUD;

get '/admin/' => sub {
	q{<html><body>
	<a href='/admin/character'>character</a><br/>
	<a href='/admin/character_quality'>character_quality</a><br/>
	<a href='/admin/character_skill'>character_skill</a><br/>
	<a href='/admin/contact'>contact</a><br/>
	<a href='/admin/quality'>quality</a><br/>
	<a href='/admin/skill'>skill</a><br/>
	<a href='/admin/deck'>deck</a><br/>
	<a href='/admin/deck_program'>deck_program</a><br/>
	<a href='/admin/program'>program</a><br/>
	<a href='/admin/vehicle'>vehicle</a><br/>
	<a href='/admin/gear'>gear</a><br/>
	<a href='/admin/ranged_weapon'>ranged_weapon</a><br/>
	<a href='/admin/mode'>mode</a><br/>
	<a href='/admin/weapon_mode'>weapon_mode</a><br/>
	<a href='/admin/melee_weapon'>melee_weapon</a><br/>
	<a href='/admin/armor'>armor</a><br/>
	<a href='/admin/spell'>spell</a><br/>
	<a href='/admin/character_spell'>character_spell</a><br/>
	<a href='/admin/power'>power</a><br/>
	<a href='/admin/character_augmentation'>character_augmentation</a><br/>
	<a href='/admin/augmentation'>augmentation</a><br/>
	<a href='/admin/augmentation_stat'>augmentation_stat</a><br/>
	<a href='/admin/stat'>stat</a><br/>
	<a href='/admin/character_stat'>character_stat</a><br/>
</body></html>};
};

simple_crud(
	record_title=>"Character",
	prefix=>'/admin/character',
	db_table=>"Character",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
);

simple_crud(
	record_title=>"Character_Quality",
	prefix=>'/admin/character_quality',
	db_table=>"Character_Quality",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
	foreign_keys=>{
		CID=>{table=>'Character', key_column=>'ID', label_column=>'Character'},
		QID=>{table=>'Quality', key_column=>'ID', label_column=>'Name'},
	}
);

simple_crud(
	record_title=>"Character_Skill",
	prefix=>'/admin/character_skill',
	db_table=>"Character_Skill",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
	foreign_keys=>{
		CID=>{table=>'Character', key_column=>'ID', label_column=>'Character'},
		SID=>{table=>'Skill', key_column=>'ID', label_column=>'Name'},
	}
);

simple_crud(
	record_title=>"Contact",
	prefix=>'/admin/contact',
	db_table=>"Contact",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
	foreign_keys=>{
		CID=>{table=>'Character', key_column=>'ID', label_column=>'Character'},
	}
);

simple_crud(
	record_title=>"Quality",
	prefix=>'/admin/quality',
	db_table=>"Quality",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
);

simple_crud(
	record_title=>"Skill",
	prefix=>'/admin/skill',
	db_table=>"Skill",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
);

simple_crud(
	record_title=>"Deck",
	prefix=>'/admin/deck',
	db_table=>"Deck",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
	foreign_keys=>{
		GID=>{table=>'Gear', key_column=>'ID', label_column=>'Name'},
	}
);

simple_crud(
	record_title=>"Deck_Program",
	prefix=>'/admin/deck_program',
	db_table=>"Deck_Program",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
	foreign_keys=>{
		DID=>{table=>'Deck', key_column=>'ID', label_column=>'ID'},
		PID=>{table=>'Program', key_column=>'ID', label_column=>'Name'},
	}
);

simple_crud(
	record_title=>"Program",
	prefix=>'/admin/program',
	db_table=>"Program",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
);

simple_crud(
	record_title=>"Vehicle",
	prefix=>'/admin/vehicle',
	db_table=>"Vehicle",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
	foreign_keys=>{
		CID=>{table=>'Character', key_column=>'ID', label_column=>'Character'},
	}
);

simple_crud(
	record_title=>"Gear",
	prefix=>'/admin/gear',
	db_table=>"Gear",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
	foreign_keys=>{
		CID=>{table=>'Character', key_column=>'ID', label_column=>'Character'},
	}
);

simple_crud(
	record_title=>"RangedWeapon",
	prefix=>'/admin/ranged_weapon',
	db_table=>"RangedWeapon",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
	foreign_keys=>{
		GID=>{table=>'Gear', key_column=>'ID', label_column=>'Name'},
		Mode=>{table=>'Mode', key_column=>'ID', label_column=>'Name'},
	}
);

simple_crud(
	record_title=>"Mode",
	prefix=>'/admin/mode',
	db_table=>"Mode",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
);

simple_crud(
	record_title=>"Weapon_Mode",
	prefix=>'/admin/weapon_mode',
	db_table=>"Weapon_Mode",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
	foreign_keys=>{
		WID=>{table=>'RangedWeapon', key_column=>'ID', label_column=>'ID'},
		MID=>{table=>'Mode', key_column=>'ID', label_column=>'Name'},
	}
);

simple_crud(
	record_title=>"MeleeWeapon",
	prefix=>'/admin/melee_weapon',
	db_table=>"MeleeWeapon",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
	foreign_keys=>{
		GID=>{table=>'Gear', key_column=>'ID', label_column=>'Name'},
	}
);

simple_crud(
	record_title=>"Armor",
	prefix=>'/admin/armor',
	db_table=>"Armor",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
	foreign_keys=>{
		GID=>{table=>'Gear', key_column=>'ID', label_column=>'Name'},
	}
);

simple_crud(
	record_title=>"Spell",
	prefix=>'/admin/spell',
	db_table=>"Spell",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
);

simple_crud(
	record_title=>"Character_Spell",
	prefix=>'/admin/character_spell',
	db_table=>"Character_Spell",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
	foreign_keys=>{
		CID=>{table=>'Character', key_column=>'ID', label_column=>'Character'},
		SID=>{table=>'Spell', key_column=>'ID', label_column=>'Name'},
	}
);

simple_crud(
	record_title=>"Power",
	prefix=>'/admin/power',
	db_table=>"Power",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
	foreign_keys=>{
		CID=>{table=>'Character', key_column=>'ID', label_column=>'Character'},
	}
);

simple_crud(
	record_title=>"Character_Augmentation",
	prefix=>'/admin/character_augmentation',
	db_table=>"Character_Augmentation",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
	foreign_keys=>{
		GID=>{table=>'Gear', key_column=>'ID', label_column=>'Name'},
		AID=>{table=>'Augmentation', key_column=>'ID', label_column=>'Name'},
	}
);

simple_crud(
	record_title=>"Augmentation",
	prefix=>'/admin/augmentation',
	db_table=>"Augmentation",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
);

simple_crud(
	record_title=>"Augmentation_Stat",
	prefix=>'/admin/augmentation_stat',
	db_table=>"Augmentation_Stat",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
	foreign_keys=>{
		SID=>{table=>'Stat', key_column=>'ID', label_column=>'ID'},
		AID=>{table=>'Augmentation', key_column=>'ID', label_column=>'Name'},
	}
);

simple_crud(
	record_title=>"Stat",
	prefix=>'/admin/stat',
	db_table=>"Stat",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
);

simple_crud(
	record_title=>"Character_Stat",
	prefix=>'/admin/character_stat',
	db_table=>"Character_Stat",
	editable=>1,
	sortable=>1,
	key_column=>"ID",
	foreign_keys=>{
		CID=>{table=>'Character', key_column=>'ID', label_column=>'Character'},
		SID=>{table=>'Stat', key_column=>'ID', label_column=>'ID'},
	}
);

true;