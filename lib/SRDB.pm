use strict;
use warnings;
use Dancer ':syntax';
use Dancer::Plugin::Database;
use DBI;
use DBIx::DataModel;

DBIx::DataModel

->Schema("SRDB")


#		   Class					Table					PK
->Table(qw/Character				Character				ID	/)
->Table(qw/Character_Quality		Character_Quality		ID	/)
->Table(qw/Character_Skill			Character_Skill			ID	/)
->Table(qw/Contact					Contact					ID	/)
->Table(qw/Quality					Quality					ID	/)
->Table(qw/Skill					Skill					ID	/)
->Table(qw/Deck						Deck					ID	/)
->Table(qw/Deck_Program				Deck_Program			ID	/)
->Table(qw/Program					Program					ID	/)
->Table(qw/Vehicle					Vehicle					ID	/)
->Table(qw/Gear						Gear					ID	/)
->Table(qw/RangedWeapon				RangedWeapon			ID	/)
->Table(qw/Mode						Mode					ID	/)
->Table(qw/Weapon_Mode				Weapon_Mode				ID	/)
->Table(qw/MeleeWeapon				MeleeWeapon				ID	/)
->Table(qw/Armor					Armor					ID	/)
->Table(qw/Spell					Spell					ID	/)
->Table(qw/Character_Spell			Character_Spell			ID	/)
->Table(qw/Power					Power					ID	/)
->Table(qw/Character_Augmentation	Character_Augmentation	ID	/)
->Table(qw/Augmetnation				Augmetnation			ID	/)
->Table(qw/Augmetnation_Stat		Augmetnation_Stat		ID	/)
->Table(qw/Stat						Stat					ID	/)
->Table(qw/Character_Stat			Character_Stat			ID	/)

# 					Class 				Role 				Mult 	Join
->Composition(	[qw/Character			Character			1		ID			/],
				[qw/Character_Quality	Char_Qualities		*		CID			/])
#                                                       	
->Composition(	[qw/Character			Character			1		ID			/], 
				[qw/Character_Skill		Char_Skills			*		CID			/])
#                                                       	
->Composition(	[qw/Character			Character			1		ID			/],
				[qw/Contact				Contacts			*		CID			/])
#                                                       	
->Association(	[qw/Quality				Quality				1		ID			/],
				[qw/Character_Quality	Char_Qualities		*		QID			/])
#                                                       	
->Association(	[qw/Skill				Skill				1		ID			/],
				[qw/Character_Skill		Char_Skills			*		SID			/])
#                                                       	
->Association(	[qw/Skill				Group				1		ID			/],
				[qw/Skill				Group_Skills		*		SkillGroup	/])
#                                                       	
->Association(	[qw/Character			Character			1		ID			/],
				[qw/Deck				Decks				*		CID			/])
#                                                       	
->Association(	[qw/Deck				Deck				1		ID			/],
				[qw/Deck_Program		Deck_Programs		*		DID			/])
#                                                       	
->Association(	[qw/Program				Program				1		ID			/],
				[qw/Deck_Program		Deck_Programs		*		PID			/])
#                                                       	
->Association(	[qw/Character			Character			1		ID			/],
				[qw/Vehicle				Vehicles			*		CID			/])
#                                                       	
->Association(	[qw/Character			Character			1		ID			/],
				[qw/Gear				Gear				*		CID			/])
#                                                       	
->Association(	[qw/Gear				Gear				1		ID			/],
				[qw/RangedWeapon		RangedWeapon		*		GID			/])
#                                                       	
->Association(	[qw/RangedWeapon		RangedWeapon		1		ID			/],
				[qw/Weapon_Mode			Modes				*		WID			/])
#                                                       	
->Association(	[qw/RangedWeapon		RangedWeapon		1		Mode		/],
				[qw/Mode				Mode				1		ID			/])
#                                                       	
->Association(	[qw/Mode				Mode				1		ID			/],
				[qw/Weapon_Mode			Weapon_Mode			*		MID			/])
#                                                       	
->Association(	[qw/Gear				Gear				1		ID			/],
				[qw/MeleeWeapon			MeleeWeapon			*		GID			/])
#                                                       	
->Association(	[qw/Gear				Gear				1		ID			/],
				[qw/Armor				Armor				*		GID			/])
#                                                       	
->Association(	[qw/Character			Character			1		ID			/],
				[qw/Character_Spell		Char_Spells			*		CID			/])
#
->Association(	[qw/Spell				Spell				1		ID			/],
				[qw/Character_Spell		Char_Spells			*		SID			/])
#
->Association(	[qw/Character			Character			1		ID			/],
				[qw/Power				Powers				*		CID			/])
#
->Association(	[qw/Gear				Gear				1		ID			/],
				[qw/Character_Augmentation	Char_Augmetation	*	GID			/])
#
->Association(	[qw/Augmetnation		Augmetnation		1		ID			/],
				[qw/Character_Augmentation	Char_Augmetation	*	AID			/])
#
->Association(	[qw/Augmetnation		Augmetnation		1		ID			/],
				[qw/Augmetnation_Stat	Aug_Stats			*		AID			/])
#
->Association(	[qw/Stat				Stat				1		ID			/],
				[qw/Augmetnation_Stat	Aug_Stats			*		SID			/])
#
->Association(	[qw/Stat				Stat				1		ID			/],
				[qw/Character_Stat		Char_Stats			*		SID			/])
#
->Association(	[qw/Character			Character			1		ID			/],
				[qw/Character_Stat		Char_Stats			*		CID			/])
#
->Association(	[qw/Character			Character			1		BaseStat	/],
				[qw/Stat				BaseStats			1		ID			/])
#

# Many to Many joins #
# 					Class 				Role 			Mult 	Method Path
->Association(	[qw/Character			Characters		*		Char_Skills		Character	/],
				[qw/Skill				Skills			* 		Char_Skills		Skill		/])
# 
->Association(	[qw/Character			Characters		*		Char_Qualities	Character	/],
				[qw/Quality				Qualities		*		Char_Qualities	Quality		/])
#
->Association(	[qw/Character			Characters		*		Char_Stats		Character	/],
				[qw/Stat				Stats			*		Char_Stats		Stat		/])
#

;

SRDB->dbh(database());

package SRDB::Character;

use POSIX qw{ceil};


sub PhysicalLimit
{
	my $self = shift;
	# return ceil(($self->{'Strength'} + $self->{'Body'} + $self->{'Agility'} + $self->{'Reaction'}) / 3);
	return ceil(($self->Strength * 2 + $self->Body + $self->Reaction) / 3);
}

sub MentalLimit
{
	my $self = shift;
	# return ceil(($self->{'Willpower'} + $self->{'Logic'} + $self->{'Intuition'} + $self->{'Charisma'} ) / 3);
	return ceil(($self->Logic * 2 + $self->Intuition + $self->Willpower ) / 3);
}

sub SocialLimit
{
	my $self = shift;
	return ceil(($self->Charisma * 2 + $self->Willpower + $self->Essence) / 3);
}

sub PhysicalTrack
{
	my $self = shift;
	return 8 + ceil($self->Body / 2);
}

sub StunTrack
{
	my $self = shift;
	return 8 + ceil($self->Willpower / 2);
}

sub Body
{ 
	my $self = shift;
	return $self->Stats(-columns=>[qw/SUM(Body)|Total/], -result_as=>'firstrow')->{'Total'};
}
sub Agility
{ 
	my $self = shift;
	return $self->Stats(-columns=>[qw/SUM(Agility)|Total/], -result_as=>'firstrow')->{'Total'};;
}
sub Reaction
{ 
	my $self = shift;
	return $self->Stats(-columns=>[qw/SUM(Reaction)|Total/], -result_as=>'firstrow')->{'Total'};;
}
sub Strength
{ 
	my $self = shift;
	return $self->Stats(-columns=>[qw/SUM(Strength)|Total/], -result_as=>'firstrow')->{'Total'};;
}
sub Willpower
{ 
	my $self = shift;
	return $self->Stats(-columns=>[qw/SUM(Willpower)|Total/], -result_as=>'firstrow')->{'Total'};;
}
sub Logic
{ 
	my $self = shift;
	return $self->Stats(-columns=>[qw/SUM(Logic)|Total/], -result_as=>'firstrow')->{'Total'};;
}
sub Intuition
{ 
	my $self = shift;
	return $self->Stats(-columns=>[qw/SUM(Intuition)|Total/], -result_as=>'firstrow')->{'Total'};;
}
sub Charisma
{ 
	my $self = shift;
	return $self->Stats(-columns=>[qw/SUM(Charisma)|Total/], -result_as=>'firstrow')->{'Total'};;
}
sub Edge
{ 
	my $self = shift;
	return $self->Stats(-columns=>[qw/SUM(Edge)|Total/], -result_as=>'firstrow')->{'Total'};;
}
sub Essence
{ 
	my $self = shift;
	return $self->Stats(-columns=>[qw/SUM(Essence)|Total/], -result_as=>'firstrow')->{'Total'};;
}
sub MagicResonance
{ 
	my $self = shift;
	return $self->Stats(-columns=>[qw/SUM(MagicResonance)|Total/], -result_as=>'firstrow')->{'Total'};;
}

# skill lookup with group cascade
sub get_skill
{
	my $self = shift;
	my $skill_name = shift;
	# my $row = SRDB->join();
	my $skill = SRDB->table('Skill')->select(-where=>{Name=>$skill_name}, -result_as=>'firstrow');
	my $cs = SRDB->table('Character_Skill')->select(-where=>{CID=>$self->{'ID'}, SID=>$skill->{'ID'}}, -result_as=>'firstrow');
	if($cs) {
		return $cs->{'Rating'};
	} elsif(defined $skill->{'SkillGroup'}) {
		$cs = SRDB->table('Character_Skill')->select(-where=>{CID=>$self->{'ID'}, SID=>$skill->{'SkillGroup'}},
			-result_as=>'firstrow');
		return $cs->{'Rating'} if $cs;
	}
	
	if($skill->{'Default'}) {
		return -1;
	} else {
		return undef;
	}
}


1;