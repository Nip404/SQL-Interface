use strict;
use warnings;

use 5.30.0

use lib::SQL_API;
use feature "say";

my $user = "root";
my $pass = "password";
my $db = "northwind";
my $host = "localhost";

#SELECT field FROM table WHERE cond
#INSERT INTO table VALUES @(table row)
#UPDATE table SET field = expr WHERE cond
#DELETE FROM table WHERE cond
my %statement = (
    fetch => "SELECT CompanyName, City FROM customers WHERE CustomerID = 'ANATR'",
    insertion => "INSERT INTO ",
    update => "",
    deletion => "",
);

my $Manager = new SQL_API($user, $pass, $db, $host);

#fetch
my @data = $Manager->read_db($statement{"fetch"});
say "Company Name: $data[0]";
say "City: $data[1]";

#insertion

#update entry

#deletion

$Manager->terminate();
