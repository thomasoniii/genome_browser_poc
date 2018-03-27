use genome_browser::genome_browserImpl;

use genome_browser::genome_browserServer;
use Plack::Middleware::CrossOrigin;



my @dispatch;

{
    my $obj = genome_browser::genome_browserImpl->new;
    push(@dispatch, 'genome_browser' => $obj);
}


my $server = genome_browser::genome_browserServer->new(instance_dispatch => { @dispatch },
				allow_get => 0,
			       );

my $handler = sub { $server->handle_input(@_) };

$handler = Plack::Middleware::CrossOrigin->wrap( $handler, origins => "*", headers => "*");
