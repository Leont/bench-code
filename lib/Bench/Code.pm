package Bench::Code;

use strict;
use warnings;
use Sub::Exporter::Progressive -setup => { exports => [ 'benchmark' ] };

use POSIX::RT::Clock;

my $monotonic = POSIX::RT::Clock->new('monotonic');
my $cputime = eval { POSIX::RT::Clock->new('thread') } || POSIX::RT::Clock->new('process');

sub benchmark(&) {
	my $cb = shift;
	my $mono = $monotonic->get_time;
	my $cpu = $cputime->get_time;
	$cb->();
	return ($monotonic->get_time - $mono, $cputime->get_time - $cpu);
}

1;

# ABSTRACT: Benchmark monotonic and cputime of a piece of code

=func benchmark { CODE }

This function benchmarks the code you're giving it. It returns a list of the elapsed monotonic and cpu time while calling the code.

