use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
	      NAME	=> 'Text::Levenshtein',
	      VERSION	=> '0.06_01',
	      LINKTYPE	=> '$(INST_PM)',
	      PREREQ_PM => {'Test::More' => 0}
	     );
