#!/usr/bin/env perl

use strict;
use feature qw/say/;

use DBI;

use Text::CSV;
use IO::Handle;
use Getopt::Long;
use warnings;

my %options;
GetOptions( \%options, 'host=s', 'user=s', 'passwd=s' );
for my $arg (qw/host user passwd/) {
    die
        "\tperl get-stock-center-orders.pl -host=ORACLE_DNS -user=USERNAME -passwd=PASSWD\n\n"
        if not defined $options{$arg};
}

my $host = $options{host};
my $user = $options{user};
my $pass = $options{passwd};
my $dsn  = "dbi:Oracle:host=$host;sid=orcl;port=1521";

print "Connecting to the database... ";
my $dbh = DBI->connect( $dsn, $user, $pass );
say " success!!";

print "Getting the data..";

my $sth = $dbh->prepare( '
	select sorder.stock_order_id order_id, sc.id id, sc.systematic_name stock_name, 
	colleague.first_name, colleague.last_name, colleague.colleague_no,
	sorder.order_date, email.email from cgm_ddb.stock_center sc
	join cgm_ddb.stock_item_order sitem on 
	( 
	    sc.id=sitem.item_id
	    AND
	    sc.strain_name = sitem.item
	) 
	join cgm_ddb.stock_order sorder on sorder.stock_order_id=sitem.order_id
	join cgm_ddb.colleague on colleague.colleague_no = sorder.colleague_id
	JOIN cgm_ddb.coll_email colemail ON colemail.colleague_no=colleague.colleague_no
	JOIN cgm_ddb.email ON email.email_no=colemail.email_no
	UNION ALL
	select sorder.stock_order_id order_id, sc.id id, sc.name stock_name, 
	colleague.first_name, colleague.last_name, colleague.colleague_no,
	sorder.order_date, email.email from plasmid sc
	join stock_item_order sitem on 
	(
	      sc.name=sitem.item
	      AND
	      sc.id = sitem.item_id
	)
	join stock_order sorder on sorder.stock_order_id=sitem.order_id
	join colleague on colleague.colleague_no = sorder.colleague_id
	JOIN cgm_ddb.coll_email colemail ON colemail.colleague_no=colleague.colleague_no
	JOIN cgm_ddb.email ON email.email_no=colemail.email_no
' );

$sth->execute();

my $filename = "stock_center_orders.csv";
my $output   = IO::File->new(">$filename");

my $csv = Text::CSV->new( { auto_diag => 1, binary => 1 } );

$csv->print(
    $output,
    [   "StockOrder_ID", "StockID",    "StockName", "FirstName",
        "LastName",      "Colleague#", "OrderDate", "email"
    ]
);

print "..printing to a file ";

while (
    my ($stock_order_id, $sc_id,        $stock_name, $first_name,
        $last_name,      $colleague_no, $order_date, $email
    )
    = $sth->fetchrow()
    )
{
    $csv->print(
        $output,
        [   $stock_order_id, $sc_id,        $stock_name, $first_name,
            $last_name,      $colleague_no, $order_date, $email
        ]
    );
    $output->print("\n");
}

$sth->finish();

$dbh->disconnect();

print "...and done!\n";

exit;

=head1 NAME

get-stock-center-orders - Export stock orders (straing and plasmids) from Stock Center

=head1 SYNOPSIS

perl generate-gpi-file.pl  -host=<ORACLE_DNS> -user=<USERNAME> -passwd=<PASSWD>

=head1 OUTPUT

<stock_center_orders.csv>

