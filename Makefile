# podman or docker
BUILDER:=podman

# FIXME: privileged required for building flatpak inside container
# https://github.com/flatpak/flatpak/issues/1326

.PHONY: all
all: clean base
	podman rm -f beeware-build 2>/dev/null || true
	# Build flatpak for testing without android emulator
	podman run \
		--privileged \
		-it \
		--name beeware-build \
		-v `pwd`/in:/in \
		-v `pwd`/out:/out \
		beeware-build bash -c \
		'. /opt/venv/bin/activate ; cd /out ; cp -r /in/* . ; ls build/*/linux/flatpak 2>/dev/null || briefcase create linux flatpak ; briefcase build linux flatpak ; briefcase package linux flatpak'
	# Build apk for android
	podman run \
		--privileged \
		-it \
		--name beeware-build \
		-v `pwd`/in:/in \
		-v `pwd`/out:/out \
		beeware-build bash -c \
		'. /opt/venv/bin/activate ; cd /out ; cp -r /in/* . ; ls build/*/android/gradle 2>/dev/null || yes | briefcase create android ; briefcase build android ; briefcase package android -p apk'
	echo 'Build result:'
	find out/dist -type f

.PHONY: base
base:
	podman build -t beeware-build .

.PHONY: clean
clean:
	find out -maxdepth 1 -mindepth 1 ! -name .gitkeep ! -name out -exec rm -rf {} +

.PHONY: clean-containers
clean-containers:
	podman image rm -f beeware-build
