FROM archlinux:base

RUN pacman -Syyuu --noconfirm

RUN useradd build -m
RUN passwd -d build

## odin

RUN pacman -S --noconfirm llvm14 clang14 which python3 git base-devel sudo clang

RUN git clone https://aur.archlinux.org/odin.git
WORKDIR odin
RUN chown -R build .

RUN sudo -u build makepkg --skippgpcheck
RUN pacman -U *.pkg.tar.zst --noconfirm

## ncurses5-compat-libs

RUN pacman -S --noconfirm glibc gcc-libs

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

WORKDIR /

## native-image

RUN pacman -S --noconfirm java-runtime-common java-environment-common

RUN git clone https://aur.archlinux.org/jdk19-graalvm-bin.git
WORKDIR jdk19-graalvm-bin
RUN chown -R build .

RUN sudo -u build makepkg --skippgpcheck
RUN pacman -U *.pkg.tar.zst --noconfirm

WORKDIR /

RUN git clone https://aur.archlinux.org/native-image-jdk19-bin.git
WORKDIR native-image-jdk19-bin 
RUN chown -R build .

RUN sudo -u build makepkg --skippgpcheck
RUN pacman -U *.pkg.tar.zst --noconfirm

WORKDIR /

## kotlin-native

WORKDIR /

RUN git clone https://aur.archlinux.org/kotlin-native-bin.git
WORKDIR kotlin-native-bin
RUN chown -R build .

RUN sudo -u build makepkg --skippgpcheck
RUN pacman -U *.pkg.tar.zst --noconfirm

## rest

RUN pacman -S --noconfirm gcc gcc-objc gcc-ada gcc-fortran make rustup gnucobol go dmd cbindgen zig nim rust-bindgen fpc patchelf ghc crystal julia
RUN rustup default stable
RUN julia -e 'using Pkg; Pkg.add("PackageCompiler")'

WORKDIR /app
COPY . .
RUN make
CMD ["make", "run"]