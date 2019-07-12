use strict;
use warnings;

BEGIN {push (@INC,'C:/Users/NIP/Desktop');}

use SQLManager;
use feature "say";

my $user = "root";
my $pass = "password";
my $db = "northwind";
my $host = "localhost";

my $statement = "SELECT CustomerID FROM customers";

my $SQLManager = new SQLManager($user, $pass, $db, $host);
my @data = $SQLManager->read_db($statement);
