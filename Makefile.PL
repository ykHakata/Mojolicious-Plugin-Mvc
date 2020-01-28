use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Mojolicious::Plugin::Mvc',
  VERSION_FROM => 'lib/Mojolicious/Plugin/Mvc.pm',
  AUTHOR       => 'A Good Programmer <nospam@cpan.org>',
  PREREQ_PM    => {'Mojolicious' => '8.32'},
  test         => {TESTS => 't/*.t'}
);
