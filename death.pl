#!/usr/bin/perl
use strict;
use warnings;
use Net::Twitter;
use Acme::SuddenlyDeath;
use Encode qw/encode_utf8 decode_utf8/;

my $twit = Net::Twitter->new(
   traits => ['API::RESTv1_1'],
   consumer_key => 'API key',
   consumer_secret => 'API Secret',
   access_token => 'token',
   access_token_secret => 'token secret',
   legacy_lists_api => 1,
   ssl => 1
	);

my $rnd = int(rand(100));
my $text = '次typoする確率: '.$rnd.'%';

$twit->update(decode_utf8('あ、やべえミスったwwww
	').sudden_death(decode_utf8(' 突然のtypo')).decode_utf8('
	').decode_utf8($text));
