# build command
#docker build -t moononournation/debian-imagemagick-lua-meshlab:1.0.1 .
# push command
#docker image push moononournation/debian-imagemagick-lua-meshlab:1.0.1

#building Multi-Arch Images commands
#docker buildx ls
#docker buildx create --use
#docker buildx build --platform linux/amd64,linux/arm -t moononournation/debian-imagemagick-lua-meshlab:1.0.1 --push .

# run command
#docker run -it -v /path/to/BanateCAD:/lua moononournation/debian-imagemagick-lua-meshlab:1.0.1

FROM debian:jessie-slim

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
		build-essential \
		ca-certificates \
        cmake \
		curl \
        debhelper \
		gcc \
        git \
        imagemagick \
        libgd-dev \
		libreadline-dev \
		libssl-dev \
        lua5.1 \
        luarocks \
		make \
        meshlab \
		mingw-w64 \
        xauth \
        xvfb \
        unzip \
    && luarocks install luafilesystem \
    && luarocks install penlight \
    && luarocks install LPeg \
    && ln -s /usr/include/lua5.1 /usr/include/lua \
    && cd /usr/local/src \
    && git clone https://github.com/ittner/lua-gd.git \
    && cd lua-gd \
    && perl -pi -e 's/DH_COMPAT\=4/DH_COMPAT\=9/g' debian/rules \
    && echo 9 > debian/compat \
    && dpkg-buildpackage -us -uc \
    && cd .. \
    && rm -r lua-gd \
    && dpkg -i lua-gd_2.0.33r3-1_*.deb \
    && rm lua-gd_2.0.33r3-1_*.deb \
    && mkdir iup-3.27-Lua51_Linux319_64_lib \
    && cd iup-3.27-Lua51_Linux319_64_lib \
    && curl -L "https://ayera.dl.sourceforge.net/project/iup/3.27/Linux%20Libraries/Lua51/iup-3.27-Lua51_Linux319_64_lib.tar.gz"  | tar -xzf - \
    && ./install \
    && cd .. \
    && rm -r iup-3.27-Lua51_Linux319_64_lib \
    && apt-get remove -y \
		build-essential \
		ca-certificates \
        cmake \
		curl \
        debhelper \
		gcc \
        git \
		libreadline-dev \
		libssl-dev \
		make \
		mingw-w64 \
        unzip \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/*

WORKDIR /lua
