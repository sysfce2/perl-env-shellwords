package Env::ShellWords;

use strict;
use warnings;
use Text::ParseWords qw( shellwords );

# ABSTRACT: Environment variables for arguments as array
# VERSION

sub TIEARRAY
{
  my($class, $name) = @_;
  bless \$name, $class;
}

sub FETCH
{
  my($self, $key) = @_;
  my @list = shellwords($ENV{$$self});
  $list[$key];
}

sub _render
{
  my($self, @list) = @_;
  $ENV{$$self} = join ' ', map {
    my $value = $_;
    $value = '' unless defined $value;
    $value =~ s/(\s)/\\$1/g;
    $value eq '' ? "''" : $value;
  } @list;
}

sub STORE
{
  my($self, $key, $value) = @_;
  my @list = shellwords($ENV{$$self});
  $list[$key] = $value;
  _render($self, @list);
  $value;
}

sub FETCHSIZE
{
  my($self) = @_;
  my @list = shellwords($ENV{$$self});
  $#list + 1;
}

sub STORESIZE
{
  my($self, $count) = @_;
  my @list = shellwords($ENV{$$self});
  $#list = $count - 1;
  _render($self, @list);
  return;
}

sub CLEAR
{
  my($self) = @_;
  _render($self);
  return;
}

sub PUSH
{
  my($self, @values) = @_;
  _render($self, shellwords($ENV{$$self}), @values);
  return;
}

sub POP
{
  my($self) = @_;
  my @list = shellwords($ENV{$$self});
  my $value = pop @list;
  _render($self, @list);
  return $value;
}

sub SHIFT
{
  my($self) = @_;
  my($value, @list) = shellwords($ENV{$$self});
  _render($self, @list);
  return $value;
}

sub UNSHIFT
{
  my($self, @values) = @_;
  _render($self, @values, shellwords($ENV{$$self}));
  return;
}

sub SPLICE
{
  my($self, $offset, $length, @values) = @_;
  my @list = shellwords($ENV{$$self});
  my @ret = splice @list, $offset, $length, @values;
  _render($self, @list);
  @ret;
}

sub DELETE
{
  my($self, $key) = @_;
  my @list = shellwords($ENV{$$self});
  my $value = delete $list[$key];
  _render($self, @list);
  return $value;
}

sub EXISTS
{
  my($self, $key) = @_;
  my @list = shellwords($ENV{$$self});
  return exists $list[$key];
}

1;
