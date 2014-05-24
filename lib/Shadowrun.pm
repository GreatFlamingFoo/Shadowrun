package Shadowrun;
use Dancer ':syntax';
use Dancer::Plugin::SimpleCRUD;
use SRDB;

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

simple_crud(
	record_title=>'Skills',
	prefix=>'/admin/skill',
	db_table=>'Skill',
	editable=>1,
	sortable=>1,
	# key_column=>'ID',
);

simple_crud(
	record_title=>'Qualities',
	prefix=>'/admin/quality',
	db_table=>'Quality',
	editable=>1,
	sortable=>1,
	# key_column=>'ID',
);

true;
