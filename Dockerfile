FROM centos:6
MAINTAINER Ryan Bauman <ryanbauman@gmail.com>

COPY *.repo /etc/yum.repos.d/

RUN yum update -y && \
    yum install -y epel-release && \
    yum install -y redhawk* \
                   GPP* \
                   bulkio* \
                   burstio* \
                   frontend* \
                   omniEvents-server \
                   omniORB-servers \
                   omniORB-utils \
                   supervisor && \
    yum clean all && \
    mkdir -p /var/log/omniEvents && \
    chown omniORB /var/log/omniEvents

RUN sed -i 's/enabled=0/enabled=1/' /etc/yum.repos.d/redhawk-2.0.repo && \
    sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/redhawk-1.10.repo

RUN yum update -y GPP-*

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
