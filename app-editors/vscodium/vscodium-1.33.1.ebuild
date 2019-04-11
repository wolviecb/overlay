# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils pax-utils

DESCRIPTION="Multiplatform Visual Studio Code from Microsoft"
HOMEPAGE="https://code.visualstudio.com"
SRC_URI="
	amd64? ( https://github.com/VSCodium/vscodium/releases/download/${PV}/VSCodium-linux-x64-${PV}.tar.gz -> ${P}-x64.tar.gz )"
RESTRICT="mirror strip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="libsecret"

DEPEND="
	>=media-libs/libpng-1.2.46:0
	>=x11-libs/gtk+-2.24.8-r1:2
	x11-libs/cairo
	gnome-base/gconf
	x11-libs/libXtst
"

RDEPEND="
	${DEPEND}
	>=net-print/cups-2.0.0
	x11-libs/libnotify
	x11-libs/libXScrnSaver
	dev-libs/nss
	libsecret? ( app-crypt/libsecret[crypt] )
"

QA_PRESTRIPPED="opt/${PN}/code"

S="${WORKDIR}"

src_install(){
	pax-mark m code
	insinto "/opt/${PN}"
	doins -r *
	dosym "../../opt/${PN}/bin/vscodium" "/usr/bin/${PN}"
	make_desktop_entry "${PN}" "Visual Studio Code" "${PN}" "Development;IDE"
	doicon "${FILESDIR}/${PN}.png"
	fperms +x "/opt/${PN}/vscodium"
	fperms +x "/opt/${PN}/bin/vscodium"
	fperms +x "/opt/${PN}/libnode.so"
	fperms +x "/opt/${PN}/resources/app/node_modules.asar.unpacked/vscode-ripgrep/bin/rg"
	insinto "/usr/share/licenses/${PN}"
}

pkg_postinst(){
	elog "You may install some additional utils, so check them in:"
	elog "https://code.visualstudio.com/Docs/setup#_additional-tools"
}
