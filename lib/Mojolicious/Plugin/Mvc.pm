package Mojolicious::Plugin::Mvc;
use Mojo::Base 'Mojolicious::Plugin';

our $VERSION = '0.01';

sub register {
    my ( $self, $app ) = @_;

    my $mode    = $app->mode;
    my $home    = $app->home;
    my $moniker = $app->moniker;

    # app 自身のクラス名取得
    die 'Can not get class name!' if $home->path('lib')->list->size ne 1;
    my $appclass = $home->path('lib')->list->first->basename('.pm');
    my $appname  = class_to_file $appclass;

    # 設定ファイル (読み込む順番に注意)
    my $defalt_path = $home->child("$moniker.conf");
    my $common_path = $home->child( 'etc', "$appname.common.conf" );
    my $mode_path   = $home->child( 'etc', "$appname.$mode.conf" );

    if ( $defalt_path->lstat ) {
        $app->plugin( Config => +{ file => $defalt_path->to_string } );
    }
    if ( $common_path->lstat ) {
        $app->plugin( Config => +{ file => $common_path->to_string } );
    }
    if ( $mode_path->lstat ) {
        $app->plugin( Config => +{ file => $mode_path->to_string } );
    }
    my $config = $app->config;

    $app->helper(
        model => sub { $appclass::Model->new( +{ conf => $config } ); } );
    $app->helper( site_name => sub { $appclass; } );
    return;
}

1;
__END__

=encoding utf8

=head1 NAME

Mojolicious::Plugin::Mvc - Mojolicious Plugin

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('Mvc');

  # Mojolicious::Lite
  plugin 'Mvc';

=head1 DESCRIPTION

L<Mojolicious::Plugin::Mvc> is a L<Mojolicious> plugin.

=head1 METHODS

L<Mojolicious::Plugin::Mvc> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 register

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<https://mojolicious.org>.

=cut
