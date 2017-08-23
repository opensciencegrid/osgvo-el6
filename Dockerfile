FROM centos:6
MAINTAINER Mats Rynge "rynge@isi.edu"

RUN yum -y upgrade
RUN yum -y install epel-release yum-plugin-priorities

# osg repo
RUN yum -y install http://repo.grid.iu.edu/osg/3.3/osg-3.3-el6-release-latest.rpm
   
# pegasus repo 
RUN echo -e "# Pegasus\n[Pegasus]\nname=Pegasus\nbaseurl=http://download.pegasus.isi.edu/wms/download/rhel/6/\$basearch/\ngpgcheck=0\nenabled=1\npriority=50" >/etc/yum.repos.d/pegasus.repo

# well rounded basic system to support a wide range of user jobs
RUN yum -y grouplist \
    && yum -y groupinstall "Additional Development" \
                           "Compatibility Libraries" \
                           "Console Internet Tools" \
                           "Development Tools" \
                           "Internet Applications" \
                           "Networking Tools" \
                           "Scientific Support"

RUN yum -y install \
           redhat-lsb \
           astropy-tools \
           bc \
           binutils \
           binutils-devel \
           coreutils \
           curl \
           fontconfig \
           gcc \
           gcc-c++ \
           gcc-gfortran \
           git \
           glew-devel \
           glib2-devel \
           glib-devel \
           graphviz \
           gsl-devel \
           java-1.8.0-openjdk \
           java-1.8.0-openjdk-devel \
           libgfortran \
           libGLU \
           libX11-devel \
           libXaw-devel \
           libXext-devel \
           libXft-devel \
           libxml2 \
           libxml2-devel \
           libXmu-devel \
           libXpm \
           libXpm-devel \
           libXt \
           mesa-libGL-devel \
           numpy \
           octave \
           octave-devel \
           openssl098e \
           p7zip p7zip-plugins \
           python-astropy \
           python-devel \
           R-devel \
           redhat-lsb-core \
           rsync \
           scipy \
           subversion \
           tcl-devel \
           tcsh \
           time \
           tk-devel \
           wget \
           which \
    
# osg
# use CA certs from CVMFS
RUN yum -y install osg-ca-certs osg-wn-client \
    && mv /etc/grid-security/certificates /etc/grid-security/certificates.osg-ca-certs \
    && ln -f -s /cvmfs/oasis.opensciencegrid.org/mis/certificates /etc/grid-security/certificates

# htcondor - include so we can chirp
RUN yum -y install condor

# pegasus
RUN yum -y install pegasus

# required directories
RUN mkdir -p /cvmfs

# verification
RUN ls -l /etc/grid-security/

# build info
RUN echo "Timestamp:" `date --utc` | tee /image-build-info.txt

