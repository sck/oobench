#! /usr/bin/perl -w
use strict;

sub help {
    print STDERR "USAGE: $0 <count>\n";
    exit(1);
}

sub copyClassUsingTemplate {
    my ($templateClass, $count) = @_;
    my $countLZ = sprintf("%04d", $count);
    my $packageName = $countLZ;
    $packageName =~ s#\d{2}$##g;
    $packageName =~ s#(\d{2})#c$1#g;
    my $countLZasPath = ".tmp/$packageName";
    my $newClassName = $templateClass;
    $newClassName =~ s#YYY/##;
    $newClassName =~ s/XXXX/$countLZ/;

    open(TCLASS, "$templateClass") || do {
        print STDERR "$templateClass: $!\n";
        return 1;
    };
    my $all;
    {
        local($/) = undef;
        $all = <TCLASS>;
    }
    close(TCLASS);

    $all =~ s/XXXX/$countLZ/gs;
    $all =~ s/YYY/$packageName/gs;

    system "mkdir -p $countLZasPath";

    my $newClassNamePath = ">$countLZasPath/$newClassName";
    open(NEWCLASS, ">$newClassNamePath") || do {
        print STDERR ">$newClassNamePath: $!\n";
        return 1;
    };
    print NEWCLASS $all;
    close(NEWCLASS);
}

my $count = shift || help;

print "Creating $count classes\n";

for (my $i = 0; $i < $count; $i++) {
    copyClassUsingTemplate("YYY/ExampleClassXXXX.class", $i);
}

print "Creating ClassLoadingPerformance.java\n";

open(LOADER, ">ClassLoadingPerformance.java");


print LOADER 
qq~package org.oobench.classloading;

public class ClassLoadingPerformance {
    public static void main(String[] args) {
        ClassLoadingBenchmark.showLocation();
        ClassLoadingBenchmark bench = new ClassLoadingBenchmark($count);
        bench.setArguments(args);
        if (bench.isTestOnly()) {
            System.exit(0);
        }
        bench.start();
        bench.reset();
~;

for (my $i = 0; $i < $count; $i++) {
    my $countLZ = sprintf("%04d", $i);
    my $packageName = $countLZ;
    $packageName =~ s#\d{2}$##g;
    $packageName =~ s#(\d{2})#c$1#g;
    print LOADER "        $packageName.ExampleClass$countLZ.showId();\n";
    print LOADER "        bench.proceed();\n";
}

print LOADER 
qq~        bench.reset();
        bench.stop();
    }
}
~;
close(LOADER);
