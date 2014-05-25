use strict;
use warnings;
use Dancer ':syntax';
use Dancer::Plugin::Database;
use DBI;
use DBIx::DataModel;

DBIx::DataModel

->Schema("SRDB")


#		   Class				Table				PK
->Table(qw/Character			Character			ID	/)
->Table(qw/Character_Quality	Character_Quality	ID	/)
->Table(qw/Character_Skill		Character_Skill		ID	/)
->Table(qw/Contact				Contacts			ID	/)
->Table(qw/Quality				Quality				ID	/)
->Table(qw/Skill				Skill				ID	/)


# 					Class 				Role 			Mult 	Join
->Composition(	[qw/Character			Character		1		ID			/],
				[qw/Character_Quality	Char_Qualities	*		CID			/])

->Composition(	[qw/Character			Character		1		ID			/], 
				[qw/Character_Skill		Char_Skills		*		CID			/])

->Composition(	[qw/Character			Character		1		ID			/],
				[qw/Contact				Contacts		*		CID			/])

->Association(	[qw/Quality				Quality			1		ID			/],
				[qw/Character_Quality	Char_Qualities	*		QID			/])

->Association(	[qw/Skill				Skill			1		ID			/],
				[qw/Character_Skill		Char_Skills		*		SID			/])

->Association(	[qw/Skill				Group			1		ID			/],
				[qw/Skill				Group_Skills	*		SkillGroup	/])

->Association(	[qw/Character			Characters		*		Char_Skills		Character	/],
				[qw/Skill				Skills			* 		Char_Skills		Skill		/])

->Association(	[qw/Character			Characters		*		Char_Qualities	Character	/],
				[qw/Quality				Qualities		*		Char_Qualities	Quality		/])
;

SRDB->dbh(database());

package SRDB::Character;

use POSIX qw{ceil};


sub PhysicalLimit
{
	my $self = shift;
	# return ceil(($self->{'Strength'} + $self->{'Body'} + $self->{'Agility'} + $self->{'Reaction'}) / 3);
	return ceil(($self->{'Strength'} * 2 + $self->{'Body'} + $self->{'Reaction'}) / 3);
}

sub MentalLimit
{
	my $self = shift;
	# return ceil(($self->{'Willpower'} + $self->{'Logic'} + $self->{'Intuition'} + $self->{'Charisma'} ) / 3);
	return ceil(($self->{'Logic'} * 2 + $self->{'Intuition'} + $self->{'Willpower'} ) / 3);
}

sub SocialLimit
{
	my $self = shift;
	return ceil(($self->{'Charisma'} * 2 + $self->{'Willpower'} + $self->{'Essence'}) / 3);
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
	} elsif($skill->{'Default'}) {
		return -1;
	} else {
		return undef;
	}
}


1;