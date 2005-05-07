use Test::More;
use File::Find;
use strict;

@ARGV = ();
find( sub { push @ARGV, $File::Find::name if /\.p(m|od)$/ }, 'blib' );

plan tests => scalar @ARGV;

# check that no file contains a FIXME / XXX
my $fixme = 0;
while (<>) {
    $fixme++ if /FIXME|XXX/;
}
continue {
    if (eof) {
        is( $fixme, 0, "No FIXME/XXX found in $ARGV" );
        $fixme = 0;
    }
}
