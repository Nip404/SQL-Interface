use strict;
use warnings;

my $path = 'Insert path of package SQL_API.pm';
BEGIN {push (@INC,$path);}

use SQL_API;
use feature "say";

my $user = "root";
my $pass = "password";
my $db = "northwind";
my $host = "localhost";

my $statement = "SELECT CustomerID FROM customers";

my $SQLManager = new SQLManager($user, $pass, $db, $host);
my @data = $SQLManager->read_db($statement);
