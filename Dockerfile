FROM centos:8
RUN yum update -y
MAINTAINER jagannathan1906@gmail.com
RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# Install necessary packages
RUN yum install -y httpd zip
# Add website ZIP file
ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/
# Set working directory
WORKDIR /var/www/html/
COPY . .
# Unzip the website files using tar
RUN yum install -y tar \
    && unzip photogenic.zip \
    && tar -xf photogenic.tar.gz \
    && rm -f photogenic.zip photogenic.tar.gz
# Copy the website files
RUN cp -rvf photogenic/* .
# Clean up unnecessary files
RUN rm -rf photogenic
# Start Apache in the foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80



 
 
# FROM  centos:latest
# MAINTAINER vikashashoke@gmail.com
# RUN yum install -y httpd \
#  zip\
#  unzip
# ADD https://www.free-css.com/assets/files/free-css-templates/download/page265/shine.zip /var/www/html/
# WORKDIR /var/www/html/
# RUN unzip shine.zip
# RUN cp -rvf shine/* .
# RUN rm -rf shine shine.zip
# CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
# EXPOSE 80   
