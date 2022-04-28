FROM archlinux:latest

# Setup packages and rust
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm base-devel git nano rustup

# Setup user
RUN useradd -m user && \
    usermod -aG wheel user
    
# Copy sudoers file
COPY sudoers.txt /etc/sudoers

# Setup rust and paru
RUN cd /home/user && \
    su user -c "rustup install stable && \
                rustup default stable && \
                git clone https://aur.archlinux.org/paru.git && \
                cd paru && \
                makepkg -si --noconfirm"

CMD ["su", "-", "user"]
