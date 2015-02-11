#!/usr/bin/env perl

use strict;
use feature qw/say/;

use DBI;

use Text::CSV;
use IO::Handle;
use Getopt::Long;
use warnings;

# Validation section
my %options;
GetOptions( \%options, 'host=s', 'user=s', 'passwd=s' );
for my $arg (qw/host user passwd/) {
    die
        "\tperl a-modware-test.pl -host=ORACLE_DNS -user=USERNAME -passwd=PASSWD\n\n"
        if not defined $options{$arg};
}

my $host = $options{host};
my $user = $options{user};
my $pass = $options{passwd};
my $dsn  = "dbi:Oracle:host=$host;sid=orcl;port=1521";

print "Connecting to the database... ";
my $dbh = DBI->connect( $dsn, $user, $pass );
say " success!!\n";

say "Getting " my $sth = $dbh->prepare( '
	SELECT so.stock_order_id, so.order_date, sio.item_id, sio.item item_name, 
	colleague.first_name, colleague.last_name, email.email FROM cgm_ddb.stock_order so
	JOIN cgm_ddb.stock_item_order sio ON so.stock_order_id=sio.item_id
	JOIN cgm_ddb.colleague ON so.colleague_id=colleague.colleague_no
	JOIN cgm_ddb.coll_email colemail ON colleague.colleague_no=colemail.colleague_no
	JOIN cgm_ddb.email ON colemail.email_no=email.email_no
' );

$sth->execute();

my $output = IO::File->new(">exportingStockCenterOrders.csv");

my $csv = Text::CSV->new( { auto_diag => 1, binary => 1 } );
$csv->print(
    $output,
    [   "StockOrder_ID", "OrderDate", "ItemID", "ItemName",
        "First",         "Last",      "email"
    ]
);

while (
    my ($stock_order_id, $order_date, $item_id, $item_name,
        $first_name,     $last_name,  $email
    )
    = $sth->fetchrow()
    )
{
    $csv->print(
        $output,
        [   $stock_order_id, $order_date, $item_id, $item_name,
            $first_name,     $last_name,  $email
        ]
    );
    $output->print("\n");
}

$sth->finish();

$dbh->disconnect();

exit;

=head1 NAME

get-stock-center-orders - Export stock orders from Stock Center

=head1 SYNOPSIS

perl generate-gpi-file.pl  -host=<ORACLE_DNS> -user=<USERNAME> -passwd=<PASSWD>

=head1 OUTPUT

<exportingStockCenterOrders.csv>

