package Shadowrun;
use Dancer ':syntax';
use CRUD;
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

true;
