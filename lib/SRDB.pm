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


# 					Class 				Role 		Mult 	Join
->Composition(	[qw/Character			Character	1		ID	/],
				[qw/Character_Quality	Qualities	*		CID	/])
->Composition(	[qw/Character			Character	1		ID	/], 
				[qw/Character_Skill		Skills		*		CID	/])
->Composition(	[qw/Character			Character	1		ID	/],
				[qw/Contact				Contacts	*		CID	/])
->Association(	[qw/Quality				Quality		1		ID	/],
				[qw/Character_Quality	Characters	*		QID	/])
->Association(	[qw/Skill				Skill		1		ID	/],
				[qw/Character_Skill		Characters	*		SID	/])

;

# my $dbh = DBI->connect(setting('dsn'), setting('db_user'), setting('db_pass'), {RaiseError=>1}) or
#      die $DBI::errstr;
# SRDB->dbh($dbh);
SRDB->dbh(database());


1;