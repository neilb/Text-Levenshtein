use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
	      NAME	=> 'Text::Levenshtein',
	      VERSION	=> '0.03',
	      LINKTYPE	=> '$(INST_PM)',
	     );
