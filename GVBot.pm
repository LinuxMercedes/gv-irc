package GVBot;

use strict;
use warnings;

use base qw(Bot::BasicBot);

use Google::Voice;
use Data::Dumper;

my $count = 0;
my %conns;

sub said {
	my $self = shift;
	my $args = shift;

	if(!$args->{"address"}) {
		return;
	}

	$args->{"body"} =~ /^(\w+)(.*)$/;
	my $command = $1;
	my $data = $2;

	my $user = $args->{"who"};

	my $response = "No response";

	if($args->{"channel"} eq "msg") {
		if($command eq "login") {
			if($conns{$user}) {
				$response = "You're already logged in, $user";
			}
			else {
				$data =~ /^\s+(\S+)\s+(.+)$/;
				my $uname = $1;
				my $pw = $2;

				$conns{$user} = Google::Voice->new->login($uname, $pw);

				if($conns{$user}) {
					$response = "Logged $uname in.";
				}
				else {
					$response = "Invalid login info, dude.";
				}
			}
		}
		elsif($command eq "message") {
			if(!$conns{$user}) {
				$response = "Log in first, please.";
			}
			else {
				$data =~/^\s+([+\d]+)\s+(.+)$/;
				my $number = $1;
				my $text = $2;

				if($conns{$user}->send_sms($number => "$text")) {
					$response = "Message sent";
				}
				else {
					$response = "Invalid message";
				}
			}
		}
		
	}
	else {
		$response = "Hello!";
	}

	$args->{"body"} = $response;
	$self->say($args) if $response;
}

"false";

