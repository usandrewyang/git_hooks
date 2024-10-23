#! /usr/local/bin/perl
# VERSION 1 : BASE
# VERSION 2 : TF1 change for configBase/configFeature 
use strict;
use warnings;
use File::Basename;
 

my @source_list;
my @suffixlist = ('c');

my %file_info = ();

my @components = (
    "Feature",       "Usage",   "config","configBase","configFeature",     "Log File",
    "Test Topology", "Summary", "Test Setup", "Configuration",
    "Verification",  "Expected Result"
);

my $retval = 0;

&getArgs();

foreach my $source (@source_list) {
    if (!open(SOURCE, $source)) {
        die "Could not open '$source'\n";
    }

    my ($name, $path, $suffix) = fileparse($source, @suffixlist);
    my $filename = $name . $suffix;
    my $logfile  = $name;
    $logfile =~ s/\.$//;
    $logfile .= "_log.txt";
    while (defined(my $line = <SOURCE>)) {
	chomp $line;
        if ($line =~ m/ Feature +: +([a-zA-Z0-9_. ]+)/) {
            $file_info{"Feature"} = $1;
        }
        if ($line =~ m/Usage +: +BCM.0> +cint +([-a-zA-Z0-9_.]+\.c)/) {
            $file_info{"Usage"} = $1;
            if ($file_info{"Usage"} ne $filename) {
                printf
                  "\nWARNING: Embedded file name '%s' does not match actual filename '%s'\n\n",
                  $file_info{"Usage"}, $filename;
                $retval = 1;
            }
        }
        if ($line =~ m/[cC]onfig\s+:\s+([-a-zA-Z0-9_.]+(_|\.)config\.bcm)/) {
            $file_info{"config"} = $1;
            my $full_path = $path . $file_info{"config"};
            if (!-s $full_path) {
                printf "\nWARNING: File '%s' does not exist\n", $full_path;
                $retval = 1;
            }

        }
        if ($line =~ m/[cC]onfig-Base\s+:\s+([-a-zA-Z0-9_.]+(_|\.)config\.yml)/) {
            $file_info{"configBase"} = $1;
            my $full_path = $path . $file_info{"configBase"};
            if (!-s $full_path) {
                printf "\nWARNING: File '%s' does not exist\n", $full_path;
                $retval = 1;
            }

        }
	if(exists($file_info{configBase})) {
        if ($line =~ m/[cC]onfig-Feature\s+:\s+([-a-zA-Z0-9_.]+\.yml)/) {
            $file_info{"configFeature"} = $1;
            my $full_path = $path . $file_info{"configFeature"};
            if (!-s $full_path) {
                printf "\nWARNING: File '%s' does not exist\n", $full_path;
                $retval = 1;
            }

        }
	}
 
	if ($line =~ m/[cC]onfig\s+:\s+([-a-zA-Z0-9_.]+(_|\.)config\.yml)/) {
            $file_info{"config"} = $1;
            my $full_path = $path . $file_info{"config"};
            if (!-s $full_path) {
                printf "\nWARNING: File '%s' does not exist\n", $full_path;
                $retval = 1;
            }
        }
        if ($line =~ m/Log file +:\s+([-a-zA-Z0-9_.]+_log\.txt)/) {
            $file_info{"Log File"} = $1;
            if ($file_info{"Log File"} ne $logfile) {
                printf "WARNING: Log file name '%s' does not match expected filename '%s'\n",
                  $file_info{"Log File"}, $logfile;
                $retval = 1;
            }
            my $full_path = $path . $file_info{"Log File"};
            if (!-s $full_path) {
                printf "\nWARNING: File '%s' does not exist\n", $full_path;
                $retval = 1;
            }
        }
        if ($line =~ m/Test Topology\s+:/) {
            $file_info{"Test Topology"} = "<" . $line . ">";
        }
        if ($line =~ m/Summary:/) {
            $file_info{"Summary"} = "<" . $line . ">";
        }
        if ($line =~ m/Step1 +- +Test Setup/) {
            $file_info{"Test Setup"} = "<" . $line . ">";
        }
        if ($line =~ m/Step2 +- +Configuration/) {
            $file_info{"Configuration"} = "<" . $line . ">";
        }
        if ($line =~ m/Step3 +- +Verification/) {
            $file_info{"Verification"} = "<" . $line . ">";
        }
        if ($line =~ m/Expected Result:/) {
            $file_info{"Expected Result"} = "<" . $line . ">";
        }
    }
    close(SOURCE);

    printf "%s:\n", $source;
    foreach my $key (@components) {
        printf "  %-16s: %s\n", $key,
          exists($file_info{$key}) ? $file_info{$key} : "** MISSING!";
    }
    %file_info = ();
}

if ($retval == 1){
  exit(1);
}else{
  exit(0);
}

sub usage {
    my $program = shift;
    print << "End-Usage";
usage: $0 cint_file [... more cint files]
End-Usage
}

sub getArgs {
    my $argCount = scalar @ARGV;

    if ($argCount == 0) {
        &usage();
        exit 0;
    }
    for (my $i = 0; $i < $argCount; $i++) {
        my $arg = $ARGV[$i];
        if ($arg =~ m/^-([a-zA-Z_0-9]+)/) {
            my $switch = $1;
            &usage();
            die "Unknown switch '-$switch'\n";
        } else {
            push @source_list, $arg;
        }
    }
    if (scalar @source_list == 0) {
        &usage();
        die "Missing CINT files\n";
    }
}
