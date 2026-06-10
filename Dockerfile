FROM postgres:15

# French locale
RUN localedef -i fr_FR -c -f UTF-8 -A /usr/share/locale/locale.alias fr_FR.UTF-8

# default environment language
ENV LANG fr_FR.utf8