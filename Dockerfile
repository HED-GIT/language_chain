FROM archlinux:base

RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm base-devel sudo gcc gcc-objc make rustup go dmd cbindgen zig nim rust-bindgen git
RUN rustup default stable

RUN useradd build -m
RUN passwd -d build

RUN pacman -S --noconfirm patchelf
RUN git clone https://aur.archlinux.org/swift-bin.git
WORKDIR swift-bin
RUN chown -R build .

RUN sudo -u build makepkg
RUN pacman -U *.pkg.tar.zst --noconfirm

WORKDIR /
COPY . .
RUN make
CMD ["make", "run"]