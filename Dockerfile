FROM akrog/cinderlib:stable
LABEL maintainers="Gorka Eguileor <geguileo@redhat.com>"
LABEL description="Ember CSI Plugin"

# We need to upgrade pyasn1 because the package for RDO is not new enough for
# pyasn1_modules, which is used by some of the Google's libraries
RUN yum -y install xfsprogs e2fsprogs btrfs-progs && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    pip install --no-cache-dir --upgrade --process-dependency-links 'pyasn1<0.5.0,>=0.4.1' ember-csi

# This is the default port, but if we change it via CSI_ENDPOINT then this will
# no longer be relevant.
EXPOSE 50051

# Define default command
CMD ["ember-csi"]
