FROM openshift/ose-jenkins-agent-base:v4.5.0.20200724.062710
ENV __doozer=update BUILD_RELEASE=202007240519.p0 BUILD_VERSION=v4.5.0 OS_GIT_MAJOR=4 OS_GIT_MINOR=5 OS_GIT_PATCH=0 OS_GIT_TREE_STATE=clean OS_GIT_VERSION=4.5.0-202007240519.p0 SOURCE_GIT_TREE_STATE=clean 
ENV __doozer=merge OS_GIT_COMMIT=77fec3a OS_GIT_VERSION=4.5.0-202007240519.p0-77fec3a SOURCE_DATE_EPOCH=1595515355 SOURCE_GIT_COMMIT=77fec3aa826f3b3f0cab0d52f37f0b7447bea26e SOURCE_GIT_TAG=77fec3a SOURCE_GIT_URL=https://github.com/openshift/jenkins 

MAINTAINER Aaqib Jawed <mailmeaaqib@gmail.com>

# Labels consumed by Red Hat build service

ENV NODEJS_VERSION=12 \
    NPM_CONFIG_PREFIX=$HOME/.npm-global \
    PATH=$HOME/node_modules/.bin/:$HOME/.npm-global/bin/:$PATH \
    BASH_ENV=/usr/local/bin/scl_enable \
    ENV=/usr/local/bin/scl_enable \
    PROMPT_COMMAND=". /usr/local/bin/scl_enable" \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

COPY contrib/bin/scl_enable /usr/local/bin/scl_enable
COPY contrib/bin/configure-agent /usr/local/bin/configure-agent

# Install NodeJS
RUN INSTALL_PKGS="rh-nodejs${NODEJS_VERSION} rh-nodejs${NODEJS_VERSION}-nodejs-nodemon make gcc-c++" && \
    ln -s /usr/lib/node_modules/nodemon/bin/nodemon.js /usr/bin/nodemon && \
    yum install -y --setopt=tsflags=nodocs --disableplugin=subscription-manager $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y

RUN chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME

USER 1001

LABEL \
        com.redhat.component="jenkins-agent-nodejs-12-rhel7-container" \
        name="openshift/jenkins-agent-nodejs-12-rhel7" \
        version="v4.5.0" \
        architecture="x86_64" \
        io.k8s.display-name="Jenkins Agent Nodejs" \
        io.k8s.description="The jenkins agent nodejs image has the nodejs tools on top of the jenkins slave base image." \
        io.openshift.tags="openshift,jenkins,agent,nodejs" \
        License="GPLv2+" \
        vendor="Red Hat" \
        io.openshift.maintainer.product="OpenShift Container Platform" \
        io.openshift.maintainer.component="Jenkins" \
        release="202007240519.p0" \
        io.openshift.build.commit.id="77fec3aa826f3b3f0cab0d52f37f0b7447bea26e" \
        io.openshift.build.source-location="https://github.com/openshift/jenkins" \
        io.openshift.build.commit.url="https://github.com/openshift/jenkins/commit/77fec3aa826f3b3f0cab0d52f37f0b7447bea26e"
