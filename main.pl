use strict;
use warnings;

use 5.30.0;

use lib::SQL_API;
use Data::Dumper;

use feature "say";

my $user = "root";
my $pass = "password";
my $db = "northwind";
my $host = "localhost";

#SELECT field FROM table WHERE cond
#INSERT INTO table (fields - optional) VALUES @(table row)
#UPDATE table SET field = val WHERE cond
#DELETE FROM table WHERE cond

#CALL
#EXPLAIN PLAN
#LOCK TABLE
#MERGE

my %statement = (
    fetch => "SELECT OrderID, CustomerID, EmployeeID, ShipName, ShipCountry FROM orders",

    fetch2 => "SELECT * FROM `order details`",
    insert => "INSERT INTO `order details` VALUES (4, 2, 666.666, 10, 7.0)",
    update => "UPDATE `order details` SET ProductID = 3 WHERE OrderID = 4",
    delete => "DELETE FROM `order details` WHERE DISCOUNT = 7",
);

my $Manager = new SQL_API($user, $pass, $db, $host);

#fetch
sub fetch {
    my @fields = qw(OrderID CustomerID EmployeeID ShipName ShipCountry);
    my @table = $Manager->read_db($statement{"fetch"}, @fields);

    foreach my $row_ref (@table) {
        say Dumper(\%$row_ref);
    }
}

#insertion
#update entry
#deletion
sub modify {
    my $s = shift;
    my $mode = "update";

    $Manager->modify_db($$s{$mode});
    my @table = $Manager->read_db($$s{"fetch2"});

    foreach my $row_ref (@table) {
        say join ", ", @$row_ref;
    }
}
modify(\%statement);

$Manager->terminate();
