FROM archlinux:base

RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm base-devel sudo gcc gcc-objc gcc-ada gcc-fortran make rustup gnucobol go dmd cbindgen zig nim rust-bindgen git fpc
RUN rustup default stable

RUN useradd build -m
RUN passwd -d build

RUN pacman -S --noconfirm patchelf

RUN git clone https://aur.archlinux.org/ncurses5-compat-libs.git
WORKDIR ncurses5-compat-libs
RUN chown -R build .

RUN sudo -u build makepkg --skippgpcheck
RUN pacman -U *.pkg.tar.zst --noconfirm

WORKDIR /

RUN git clone https://aur.archlinux.org/swift-bin.git
WORKDIR swift-bin
RUN chown -R build .

RUN sudo -u build makepkg
RUN pacman -U *.pkg.tar.zst --noconfirm

WORKDIR /app
COPY . .
RUN make
CMD ["make", "run"]