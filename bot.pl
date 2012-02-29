#! /usr/bin/perl

use strict;
use warnings;

use lib '.';

use GVBot;

my $bot;

$SIG{'INT'} = sub {
	print " recieved; quitting...\n";
	$bot->shutdown("bye");
	exit();
};

$bot = GVBot->new (
		server =>	'irc.freenode.net',
		port => '6667',
		
		channels => ["#lmbot"],

		nick => 'gvbot',
		alt_nicks => ['gvbot_', 'gvbot__'],
		username => 'gvbot',
		name => 'Google Voice bot',
	); 


$bot->run();
