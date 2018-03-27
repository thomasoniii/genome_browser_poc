package genome_browser::genome_browserImpl;
use strict;
use Bio::KBase::Exceptions;
# Use Semantic Versioning (2.0.0-rc.1)
# http://semver.org
our $VERSION = '0.0.1';
our $GIT_URL = '';
our $GIT_COMMIT_HASH = '';

=head1 NAME

genome_browser

=head1 DESCRIPTION

A KBase module: genome_browser

=cut

#BEGIN_HEADER

use GenomeFileUtil::GenomeFileUtilClient;
use AssemblyUtil::AssemblyUtilClient;
use Workspace::WorkspaceClient;

#END_HEADER

sub new
{
    my($class, @args) = @_;
    my $self = {
    };
    bless $self, $class;
    #BEGIN_CONSTRUCTOR

    $self->{callback_url} = $ENV{SDK_CALLBACK_URL};

    #END_CONSTRUCTOR

    if ($self->can('_init_instance'))
    {
	$self->_init_instance();
    }
    return $self;
}

=head1 METHODS



=head2 get_gff

  $return = $obj->get_gff($genome_ref)

=over 4

=item Parameter and return types

=begin html

<pre>
$genome_ref is a string
$return is a genome_browser.GenomeToGFFResult
GenomeToGFFResult is a reference to a hash where the following keys are defined:
	gff_file has a value which is a genome_browser.File
	from_cache has a value which is a genome_browser.boolean
File is a reference to a hash where the following keys are defined:
	path has a value which is a string
	shock_id has a value which is a string
	ftp_url has a value which is a string
boolean is an int

</pre>

=end html

=begin text

$genome_ref is a string
$return is a genome_browser.GenomeToGFFResult
GenomeToGFFResult is a reference to a hash where the following keys are defined:
	gff_file has a value which is a genome_browser.File
	from_cache has a value which is a genome_browser.boolean
File is a reference to a hash where the following keys are defined:
	path has a value which is a string
	shock_id has a value which is a string
	ftp_url has a value which is a string
boolean is an int


=end text



=item Description



=back

=cut

sub get_gff
{
    my $self = shift;
    my($genome_ref) = @_;

    my @_bad_arguments;
    (!ref($genome_ref)) or push(@_bad_arguments, "Invalid type for argument \"genome_ref\" (value was \"$genome_ref\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to get_gff:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'get_gff');
    }

    my $ctx = $genome_browser::genome_browserServer::CallContext;
    my($return);
    #BEGIN get_gff

    my $genomeFileUtil = GenomeFileUtil::GenomeFileUtilClient->new( $self->{callback_url} );
    my $gff_file = $genomeFileUtil->genome_to_gff({'genome_ref' => $genome_ref});
    open (my $gff_handle, '<', $gff_file->{'file_path'});
    local $/ = undef;
    my $gff_contents = <$gff_handle>;
    close $gff_handle;

    $return = $gff_contents;

    #END get_gff
    my @_bad_returns;
    (ref($return) eq 'HASH') or push(@_bad_returns, "Invalid type for return variable \"return\" (value was \"$return\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to get_gff:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'get_gff');
    }
    return($return);
}




=head2 get_fasta

  $return = $obj->get_fasta($genome_ref)

=over 4

=item Parameter and return types

=begin html

<pre>
$genome_ref is a string
$return is a genome_browser.GenomeToGFFResult
GenomeToGFFResult is a reference to a hash where the following keys are defined:
	gff_file has a value which is a genome_browser.File
	from_cache has a value which is a genome_browser.boolean
File is a reference to a hash where the following keys are defined:
	path has a value which is a string
	shock_id has a value which is a string
	ftp_url has a value which is a string
boolean is an int

</pre>

=end html

=begin text

$genome_ref is a string
$return is a genome_browser.GenomeToGFFResult
GenomeToGFFResult is a reference to a hash where the following keys are defined:
	gff_file has a value which is a genome_browser.File
	from_cache has a value which is a genome_browser.boolean
File is a reference to a hash where the following keys are defined:
	path has a value which is a string
	shock_id has a value which is a string
	ftp_url has a value which is a string
boolean is an int


=end text



=item Description



=back

=cut

sub get_fasta
{
    my $self = shift;
    my($genome_ref) = @_;

    my @_bad_arguments;
    (!ref($genome_ref)) or push(@_bad_arguments, "Invalid type for argument \"genome_ref\" (value was \"$genome_ref\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to get_fasta:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'get_fasta');
    }

    my $ctx = $genome_browser::genome_browserServer::CallContext;
    my($return);
    #BEGIN get_fasta

    my $ws = Workspace::WorkspaceClient->new('https://ci.kbase.us/services/ws', token => $ENV{'KB_AUTH_TOKEN'} );
    my $go_info = $ws->get_objects2({
      'objects' => [{'ref' => $genome_ref}],
      'no_data' => 1,
    });

#    my $genome_obj_refs = $go_info

    my $refs = $go_info->{data}->[0]->{refs};

    my $ref_info = $ws->get_object_info3({'objects' => [map {{'ref' => $_}} @$refs]});

    my @assembly_ref = ();

    #foreach my $i (@{$ref_info->{infos}}) {
    for (my $i = 0; $i < @{$ref_info->{infos}}; $i++) {
      my $info = $ref_info->{infos}->[$i]->[2];
      if ($info =~ /KBaseGenomeAnnotations.Assembly/ || $info =~ /KBaseGenomes.ContigSet/) {
        push @assembly_ref, join(';', @{$ref_info->{paths}->[$i]});
      }
    }


    my $assemblyFileUtil = AssemblyUtil::AssemblyUtilClient->new( $self->{callback_url} );
    my $fasta_file = $assemblyFileUtil->get_assembly_as_fasta({'ref' => $assembly_ref[0]});

    open (my $fasta_handle, '<', $fasta_file->{'path'});
    local $/ = undef;
    my $fasta_contents = <$fasta_handle>;

    $return = $fasta_contents;



    #END get_fasta
    my @_bad_returns;
    (ref($return) eq 'HASH') or push(@_bad_returns, "Invalid type for return variable \"return\" (value was \"$return\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to get_fasta:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'get_fasta');
    }
    return($return);
}




=head2 status

  $return = $obj->status()

=over 4

=item Parameter and return types

=begin html

<pre>
$return is a string
</pre>

=end html

=begin text

$return is a string

=end text

=item Description

Return the module status. This is a structure including Semantic Versioning number, state and git info.

=back

=cut

sub status {
    my($return);
    #BEGIN_STATUS
    $return = {"state" => "OK", "message" => "", "version" => $VERSION,
               "git_url" => $GIT_URL, "git_commit_hash" => $GIT_COMMIT_HASH};
    #END_STATUS
    return($return);
}

=head1 TYPES



=head2 boolean

=over 4



=item Definition

=begin html

<pre>
an int
</pre>

=end html

=begin text

an int

=end text

=back



=head2 File

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
path has a value which is a string
shock_id has a value which is a string
ftp_url has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
path has a value which is a string
shock_id has a value which is a string
ftp_url has a value which is a string


=end text

=back



=head2 GenomeToGFFResult

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
gff_file has a value which is a genome_browser.File
from_cache has a value which is a genome_browser.boolean

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
gff_file has a value which is a genome_browser.File
from_cache has a value which is a genome_browser.boolean


=end text

=back



=cut

1;
