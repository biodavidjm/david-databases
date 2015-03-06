#!/usr/bin/env perl

use strict;
use warnings;
use feature qw/say/;

use DBI;

use Text::CSV;
use IO::Handle;
use Getopt::Long;
use Carp;

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

print "Getting the data... ";

my $sth = $dbh->prepare( '
	select 
	SO.STOCK_ORDER_ID ORDER_ID, 
	SO.ORDER_DATE,
	PLASMID.ID ID,
	PLASMID.NAME NAME,
	COLLEAGUE.COLLEAGUE_NO,
	COLLEAGUE.FIRST_NAME,
	COLLEAGUE.LAST_NAME,
	EMAIL.EMAIL
	from PLASMID
	JOIN STOCK_ITEM_ORDER SIO ON
	(
	  PLASMID.ID=SIO.ITEM_ID
	  AND
	  PLASMID.NAME=SIO.ITEM
	)
	join STOCK_ORDER SO on SIO.ORDER_ID=SO.STOCK_ORDER_ID
	left join COLLEAGUE on COLLEAGUE.COLLEAGUE_NO=SO.COLLEAGUE_ID
	left join COLL_EMAIL COE on COE.COLLEAGUE_NO=COLLEAGUE.COLLEAGUE_NO
	left join EMAIL on EMAIL.EMAIL_NO=COE.EMAIL_NO
' );

$sth->execute();

my $filename = "stock_center_orders-plasmids100.csv";

my $output = IO::File->new(">$filename");

my $csv = Text::CSV->new (
    {
        auto_diag => 1, 
        binary => 0,
        blank_is_undef => 1,
        empty_is_undef => 1,
        quote_null => 1,
        quote_binary => 1

    }
) or croak "Cannot use CSV: " . Text::CSV->error_diag();

$csv->column_names (qw( code name price description ));
$csv->print(
    $output,
    [   
        "StockOrder_ID", 
    	"OrderDate", 
    	"StockID", 
    	"StockName", 
    	"ColleagueID",
    	"FirstName", 
    	"LastName",
        "email"
    ]
);

$output->print("\n");

print "printing to a file... ";

while 	(
    my( $stock_order_id, 
    	$order_date, 
    	$sc_id, 
    	$stock_name, 
    	$colleague_no,
    	$first_name,
        $last_name,      
        $email
    ) = $sth->fetchrow()
)
{
	# Control of required values
	stop_empty($stock_order_id);
	stop_empty($order_date);
	stop_empty($sc_id);
	stop_empty($stock_name);
	# Not required values that might be empty.
	# my $colleague_no_in = check_if_empty_col_num($colleague_no);
	# my $first_name_in = check_if_empty_name($first_name);
	# my $last_name_in = check_if_empty_name($last_name);
	# my $emailin = check_if_empty_email($email);
   
    $csv->print(
        # $output,
        # [   $stock_order_id, 
        # 	$order_date, 
        # 	$sc_id, 
        # 	$stock_name, 
        # 	$colleague_no_in,
        # 	$first_name_in,
        #     $last_name_in,      
        #     $emailin
        # ]

            $output,
        [   $stock_order_id, 
            $order_date, 
            $sc_id, 
            $stock_name, 
            $colleague_no,
            $first_name,
            $last_name,      
            $email
        ]
    );
    $output->print("\n");
}

$sth->finish();

$dbh->disconnect();

print "...and $filename ready!\n";

exit;

sub check_if_empty_email {
    my ($self) = @_;
    my $blank = 'no@email.com';
    if(!(defined $self)) {
        return($blank);
    }
    else{
        return($self);
    }
}

sub check_if_empty_name {
    my ($self) = @_;
    my $blank = 'Anonymous';
    if(!(defined $self)) {
        return($blank);
    }
    else{
        return($self);
    }
}

sub check_if_empty_col_num {
    my ($self) = @_;
    my $blank = 10000001;
    if(!(defined $self)) {
        return($blank);
    }
    else{
        return($self);
    }
}

sub stop_empty {
    my ($self) = @_;
    if(!(defined $self)) {
        die "REQUIRED VALUE IS EMPTY!\n";
    }
}


=head1 NAME

get-stock-center-orders - Export stock orders (straing and plasmids) from Stock Center

=head1 SYNOPSIS

perl generate-gpi-file.pl  -host=<ORACLE_DNS> -user=<USERNAME> -passwd=<PASSWD>

=head1 OUTPUT

<stock_center_orders.csv>

