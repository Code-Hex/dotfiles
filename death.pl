#!/usr/bin/perl
use strict;
use warnings;
use Net::Twitter;
use Acme::SuddenlyDeath;
use Encode qw/encode_utf8 decode_utf8/;

my $twit = Net::Twitter->new(
   traits => ['API::RESTv1_1'],
   consumer_key => 'PVonivgYA3JdQzhGY9SsfMoi0',
   consumer_secret => 'VC5DHhuBFZI69asv3BIoFKbAYWfPYQOlGD0pv5uXmUCUd7iwky',
   access_token => '1919043200-rajNa3iDzV8JWShbeE9tTmVo6ZDHP07ZtQ8RUPG',
   access_token_secret => 'i36hiPz6eWdVVV1E797o4gRO0V2PelJAPfzGZbbDwmf6s',
   legacy_lists_api => 1,
   ssl => 1
	);

my $rnd = int(rand(100));
my $text = '次typoする確率: '.$rnd.'%';

$twit->update(decode_utf8('あ、やべえミスったwwww
	').sudden_death(decode_utf8(' 突然のtypo')).decode_utf8('
	').decode_utf8($text));
