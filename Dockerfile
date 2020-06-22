FROM modulator:latest

MAINTAINER Fenglin Chen <f73chen@uwaterloo.ca>

# packages should already be set up in modulator:latest
USER root

# move in the yaml to build modulefiles from
COPY star_fusion_recipe.yaml /modulator/code/gsi/recipe.yaml

# build the modules and set folder & file permissions
RUN ./build-local-code /modulator/code/gsi/recipe.yaml --initsh /usr/share/modules/init/sh --output /modules && \
	find /modules -type d -exec chmod 777 {} \; && \
	find /modules -type f -exec chmod 777 {} \;

# add the user
RUN groupadd -r -g 1000 ubuntu && useradd -r -g ubuntu -u 1000 ubuntu
USER ubuntu

# copy the setup file to load the modules at startup
COPY .bashrc /home/ubuntu/.bashrc

# set environment paths for modules
ENV STAR_FUSION_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/star-fusion-1.8.1"
ENV PERL_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/perl-5.30"
ENV STAR_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/star-2.7.3a"
ENV SAMTOOLS_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/samtools-1.9"
ENV HTSLIB_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/htslib-1.9"

ENV PATH="/modules/gsi/modulator/sw/Ubuntu18.04/star-fusion-1.8.1/bin:/modules/gsi/modulator/sw/Ubuntu18.04/perl-5.30/bin:/modules/gsi/modulator/sw/Ubuntu18.04/star-2.7.3a/bin:/modules/gsi/modulator/sw/Ubuntu18.04/samtools-1.9/bin:/modules/gsi/modulator/sw/Ubuntu18.04/htslib-1.9/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ENV MANPATH="/modules/gsi/modulator/sw/Ubuntu18.04/star-fusion-1.8.1/man:/modules/gsi/modulator/sw/Ubuntu18.04/perl-5.30/share/man:/modules/gsi/modulator/sw/Ubuntu18.04/samtools-1.9/share/man:/modules/gsi/modulator/sw/Ubuntu18.04/htslib-1.9/share/man"
ENV LD_LIBRARY_PATH="/modules/gsi/modulator/sw/Ubuntu18.04/star-fusion-1.8.1/lib:/modules/gsi/modulator/sw/Ubuntu18.04/perl-5.30/lib:/modules/gsi/modulator/sw/Ubuntu18.04/htslib-1.9/lib"
ENV PERL5LIB="/modules/gsi/modulator/sw/Ubuntu18.04/star-fusion-1.8.1/lib/perl5:/modules/gsi/modulator/sw/Ubuntu18.04/perl-5.30/lib/site_perl"
ENV PKG_CONFIG_PATH="/modules/gsi/modulator/sw/Ubuntu18.04/htslib-1.9/lib/pkgconfig"

CMD /bin/bash
