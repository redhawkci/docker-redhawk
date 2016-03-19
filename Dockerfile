FROM centos:6
MAINTAINER Ryan Bauman <ryanbauman@gmail.com>

COPY redhawk.repo /etc/yum.repos.d/

RUN yum update -y && \
    yum install -y epel-release && \
    yum install -y redhawk-devel \
                   redhawk-sdrroot-dev-mgr \
                   redhawk-sdrroot-dom-mgr \
                   redhawk-sdrroot-dom-profile \
                   redhawk-codegen \
                   redhawk-basic-components \
                   bulkioInterfaces \
                   burstioInterfaces \
                   frontendInterfaces \
                   GPP \
                   omniEvents-server \
                   omniORB-servers \
                   omniORB-utils \
                   supervisor && \
    yum clean all && \
    mkdir -p /var/log/omniEvents && \
    chown omniORB /var/log/omniEvents

#Add config files
COPY *.c* /etc/

#Default environment
ENV OSSIEHOME=/usr/local/redhawk/core \
    SDRROOT=/var/redhawk/sdr \
    PYTHONPATH=/usr/local/redhawk/core/lib64/python:/usr/local/redhawk/core/lib/python \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/redhawk/core/bin \
    LD_LIBRARY_PATH=/usr/local/redhawk/core/lib64:/usr/local/redhawk/core/lib

EXPOSE 2809 11169
CMD ["/usr/bin/supervisord", "-n"]
