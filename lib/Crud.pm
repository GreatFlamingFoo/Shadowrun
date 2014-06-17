package Shadowrun;
use Dancer ':syntax';
use Dancer::Plugin::SimpleCRUD;
use Dancer::Plugin::REST;
use SRDB;

prefix '/api';
prepare_serializer_for_format;

foreach(map { $_->name } SRDB->metadm->tables)
{
	my $table = $_;
	my $res = lc $table;
	my %col;
	
	my $sth = SRDB->dbh->column_info('%','%', $table, '%');
	while(my $row = $sth->fetchrow_hashref)
	{
		$col{ $row->{'COLUMN_NAME'} } = 1;
	}
	debug("setting up resource /api/$res ", );#[keys %col]);
	
	resource $res =>
		get		=> sub { return SRDB->unbless( SRDB->table($table)->fetch(param("id")) ); },
		delete	=> sub { return SRDB->table($table)->delete(params("id")); },
		create	=> sub 
		{ 
			my $args = {params()};
			$args = { map { $_, $args->{$_} } grep { $col{$_} } keys %$args };
			debug( $args );
			return SRDB->table($table)->insert( $args );
		},
		update	=> sub 
		{
			my $args = {params()};
			$args = { map { $_, $args->{$_} } grep { $col{$_} } keys %$args };
			# debug( $args ); 
			SRDB->table($table)->update(param("id"), $args);
		},
		;
	
	no strict 'refs';
	*{"SRDB::${table}::url"} = sub {
		my $self = shift;
		return request->uri_for( '/api/'.$res.'/'.$self->{'ID'} );
	};
}

prefix undef;

my %args = (
	editable=>1,
	sortable=>1,
	key_column=>"ID",
);

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
	%args,
);

simple_crud(
	record_title=>"Character_Quality",
	prefix=>'/admin/character_quality',
	db_table=>"Character_Quality",
	foreign_keys=>{
		CID=>{table=>'Character', key_column=>'ID', label_column=>'Character'},
		QID=>{table=>'Quality', key_column=>'ID', label_column=>'Name'},
	},
	%args,
);

simple_crud(
	record_title=>"Character_Skill",
	prefix=>'/admin/character_skill',
	db_table=>"Character_Skill",
	foreign_keys=>{
		CID=>{table=>'Character', key_column=>'ID', label_column=>'Character'},
		SID=>{table=>'Skill', key_column=>'ID', label_column=>'Name'},
	},
	%args,
);

simple_crud(
	record_title=>"Contact",
	prefix=>'/admin/contact',
	db_table=>"Contact",
	foreign_keys=>{
		CID=>{table=>'Character', key_column=>'ID', label_column=>'Character'},
	},
	%args,
);

simple_crud(
	record_title=>"Quality",
	prefix=>'/admin/quality',
	db_table=>"Quality",
	%args,
);

simple_crud(
	record_title=>"Skill",
	prefix=>'/admin/skill',
	db_table=>"Skill",
	%args,
);

simple_crud(
	record_title=>"Deck",
	prefix=>'/admin/deck',
	db_table=>"Deck",
	foreign_keys=>{
		GID=>{table=>'Gear', key_column=>'ID', label_column=>'Name'},
	},
	%args,
);

simple_crud(
	record_title=>"Deck_Program",
	prefix=>'/admin/deck_program',
	db_table=>"Deck_Program",
	foreign_keys=>{
		DID=>{table=>'Deck', key_column=>'ID', label_column=>'ID'},
		PID=>{table=>'Program', key_column=>'ID', label_column=>'Name'},
	},
	%args,
);

simple_crud(
	record_title=>"Program",
	prefix=>'/admin/program',
	db_table=>"Program",
	%args,
);

simple_crud(
	record_title=>"Vehicle",
	prefix=>'/admin/vehicle',
	db_table=>"Vehicle",
	foreign_keys=>{
		CID=>{table=>'Character', key_column=>'ID', label_column=>'Character'},
	},
	%args,
);

simple_crud(
	record_title=>"Gear",
	prefix=>'/admin/gear',
	db_table=>"Gear",
	foreign_keys=>{
		CID=>{table=>'Character', key_column=>'ID', label_column=>'Character'},
	},
	%args,
);

simple_crud(
	record_title=>"RangedWeapon",
	prefix=>'/admin/ranged_weapon',
	db_table=>"RangedWeapon",
	foreign_keys=>{
		GID=>{table=>'Gear', key_column=>'ID', label_column=>'Name'},
		Mode=>{table=>'Mode', key_column=>'ID', label_column=>'Name'},
	},
	%args,
);

simple_crud(
	record_title=>"Mode",
	prefix=>'/admin/mode',
	db_table=>"Mode",
	%args,
);

simple_crud(
	record_title=>"Weapon_Mode",
	prefix=>'/admin/weapon_mode',
	db_table=>"Weapon_Mode",
	foreign_keys=>{
		WID=>{table=>'RangedWeapon', key_column=>'ID', label_column=>'ID'},
		MID=>{table=>'Mode', key_column=>'ID', label_column=>'Name'},
	},
	%args,
);

simple_crud(
	record_title=>"MeleeWeapon",
	prefix=>'/admin/melee_weapon',
	db_table=>"MeleeWeapon",
	foreign_keys=>{
		GID=>{table=>'Gear', key_column=>'ID', label_column=>'Name'},
	},
	%args,
);

simple_crud(
	record_title=>"Armor",
	prefix=>'/admin/armor',
	db_table=>"Armor",
	foreign_keys=>{
		GID=>{table=>'Gear', key_column=>'ID', label_column=>'Name'},
	},
	%args,
);

simple_crud(
	record_title=>"Spell",
	prefix=>'/admin/spell',
	db_table=>"Spell",
	%args,
);

simple_crud(
	record_title=>"Character_Spell",
	prefix=>'/admin/character_spell',
	db_table=>"Character_Spell",
	foreign_keys=>{
		CID=>{table=>'Character', key_column=>'ID', label_column=>'Character'},
		SID=>{table=>'Spell', key_column=>'ID', label_column=>'Name'},
	},
	%args,
);

simple_crud(
	record_title=>"Power",
	prefix=>'/admin/power',
	db_table=>"Power",
	foreign_keys=>{
		CID=>{table=>'Character', key_column=>'ID', label_column=>'Character'},
	},
	%args,
);

simple_crud(
	record_title=>"Character_Augmentation",
	prefix=>'/admin/character_augmentation',
	db_table=>"Character_Augmentation",
	foreign_keys=>{
		GID=>{table=>'Gear', key_column=>'ID', label_column=>'Name'},
		AID=>{table=>'Augmentation', key_column=>'ID', label_column=>'Name'},
	},
	%args,
);

simple_crud(
	record_title=>"Augmentation",
	prefix=>'/admin/augmentation',
	db_table=>"Augmentation",
	%args,
);

simple_crud(
	record_title=>"Augmentation_Stat",
	prefix=>'/admin/augmentation_stat',
	db_table=>"Augmentation_Stat",
	foreign_keys=>{
		SID=>{table=>'Stat', key_column=>'ID', label_column=>'ID'},
		AID=>{table=>'Augmentation', key_column=>'ID', label_column=>'Name'},
	},
	%args,
);

simple_crud(
	record_title=>"Stat",
	prefix=>'/admin/stat',
	db_table=>"Stat",
	%args,
);

simple_crud(
	record_title=>"Character_Stat",
	prefix=>'/admin/character_stat',
	db_table=>"Character_Stat",
	foreign_keys=>{
		CID=>{table=>'Character', key_column=>'ID', label_column=>'Character'},
		SID=>{table=>'Stat', key_column=>'ID', label_column=>'ID'},
	},
	%args,
);

true;