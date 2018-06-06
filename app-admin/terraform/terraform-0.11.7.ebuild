# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-vcs-snapshot golang-build

EGO_PN="github.com/hashicorp/terraform"
DESCRIPTION="Terraform builds, changes, and versioning infrastructure"
HOMEPAGE="http://www.terraform.io"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SLOT="0"
LICENSE="MPL-2.0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="test"

DEPEND="dev-go/gox
	>=dev-lang/go-1.9:=
	dev-go/go-tools:="
RDEPEND=""

src_prepare() {
	default
	# Avoid the need to have a git checkout
	sed -e 's:^\(GIT_COMMIT=\).*:\1:' \
		-e 's:^\(GIT_DIRTY=\).*:\1:' \
		-e s:\'\${GIT_COMMIT}\${GIT_DIRTY}\':: \
		-i src/${EGO_PN}/scripts/build.sh || die
	sed -e "/hooks/d" -i src/${EGO_PN}/Makefile || die
}

src_install() {
	dobin ${PN}
}
