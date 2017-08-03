# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.34

inherit gnome2-utils vala autotools git-r3

DESCRIPTION="Pantheon's Window Manager"
HOMEPAGE="https://github.com/elementary/gala"
EGIT_REPO_URI="https://github.com/elementary/gala.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.32:2
	dev-libs/libgee:0.8
	>=media-libs/clutter-1.12
	media-libs/clutter-gtk
	>=pantheon-base/plank-0.3
	x11-libs/bamf
	>=x11-libs/granite-0.3
	>=x11-libs/gtk+-3.4:3
	>=x11-wm/mutter-3.14.4
	gnome-base/gnome-desktop:3"
DEPEND="${RDEPEND}
	>=dev-lang/vala-0.34.8
	virtual/pkgconfig"

src_prepare() {
	eapply_user

	eautoreconf

	vala_src_prepare
}

src_configure() {
	econf VALAC="${VALAC}" VAPIGEN="${VAPIGEN}"
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
