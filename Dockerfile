FROM archlinux:base

RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm gcc gcc-objc make rustup go dmd cbindgen zig nim rust-bindgen
RUN rustup default stable

COPY . .
RUN make
CMD ["make", "run"]