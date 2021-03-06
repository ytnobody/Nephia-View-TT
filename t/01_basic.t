use strict;
use warnings;
use Test::More;
use Plack::Test;
use HTTP::Request::Common;
use FindBin;
use lib ("$FindBin::Bin/MyApp/lib");
use MyApp;

test_psgi
    app => MyApp->run( view => { 
        class => 'TT',
        INCLUDE_PATH => [ "$FindBin::Bin/MyApp/view" ],
    } ),
    client => sub {
        my $cb = shift;
        my $res = $cb->(GET '/');
        is $res->code, 200;
        like $res->content, qr{<h1>MyApp</h1>};
    }
;

done_testing;
