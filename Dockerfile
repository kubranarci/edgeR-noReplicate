FROM ubuntu:12.04
MAINTAINER Kubra Narci 
RUN echo "deb http://cran.r-project.org/bin/linux/ubuntu precise/" > /etc/apt/sources.list.d/cran.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
RUN apt-get update
RUN apt-get -y install r-base
RUN apt-get install wget build-essential zlib1g-dev libncurses5-dev -y

RUN apt-get install --yes libxml2-dev -y

# Set CRAN repository to use
RUN echo 'local({r <- getOption("repos"); r["CRAN"] <- "http://cran.r-project.org"; options(repos=r)})' > ~/.Rprofile

# Install bioconductor
# Force Bioconductor 2.10 version
RUN wget http://bioconductor.org/biocLite.R
RUN sed -i 's/\"2.11"/"2.10"/' biocLite.R
RUN R -e 'source("http://bioconductor.org/biocLite.R"); biocLite("edgeR")'
RUN R -e 'source("http://bioconductor.org/biocLite.R"); biocLite("lattice")'
RUN R -e 'source("http://bioconductor.org/biocLite.R"); biocLite("annotate")'
RUN R -e 'source("http://bioconductor.org/biocLite.R"); biocLite("org.Hs.eg.db")'


RUN apt-get install git -y
RUN  git clone https://github.com/kubranarci/edgeR-noReplicate.git
RUN cd edgeR-noReplicate


