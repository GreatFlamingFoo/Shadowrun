package Shadowrun;
use Dancer ':syntax';
use Dancer::Plugin::SimpleCRUD;
use SRDB;
use Template;

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

get '/character/:id' => sub {
	template 'character', {
		'c' => SRDB->table('Character')->fetch(param('id')),
	};
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
