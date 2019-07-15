package SQL_API;

use DBI;

sub new {
    my $class = shift;
    my $self = {
        username => shift,
        password => shift,
        dbname => shift,
        host => shift,
        count => 0
    };

    bless $self, $class;

    our $driver = "mysql";
    my $dsn = "DBI:$driver:database=$self->{dbname}:$self->{host}";
    our $dbh = DBI->connect($dsn, $self->{username}, $self->{password}) or die $DBI::errstr;

    return $self;
}

sub read_db {
    my ($self, $statement) = @_;

    my $sth = $dbh->prepare($statement);
    $sth->execute();

    my @data = ();
    while (my @row = $sth->fetchrow_array()) {
        push @data, @row;
    }

    $self->{data.$self->{count}} = @data;
    $self->{count}++;

    return @data;
}

sub terminate {
    $dbh->disconnect;
}

1;
