# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_DEPEND="python? 2:2.5"
WANT_AUTOMAKE="1.11"

inherit gnome2 python virtualx

DESCRIPTION="A GObject plugins library"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
IUSE="doc gtk python seed vala" # glade
if [[ ${PV} = 9999 ]]; then
	inherit gnome2-live
	KEYWORDS=""
else
	KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
fi

RDEPEND=">=dev-libs/glib-2.23.6:2
	>=dev-libs/gobject-introspection-0.10.1
	gtk? ( >=x11-libs/gtk+-2.90:3[introspection] )
	python? ( >=dev-python/pygobject-2.28 )
	seed? ( >=dev-libs/seed-2.28.0 )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
	>=sys-devel/libtool-2.2.6
	doc? ( >=dev-util/gtk-doc-1.11 )
	vala? ( >=dev-lang/vala-0.11.1:0.12 )"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable gtk)
		$(use_enable python)
		$(use_enable seed)
		$(use_enable vala)
		VALAC=$(type -P valac-0.12)
		--disable-static
		--disable-maintainer-mode
		--disable-gtk2-test-build"
	# Wtf, --disable-gcov, --enable-gcov=no, --enable-gcov, all enable gcov
	# What do we do about gdb, valgrind, gcov, etc?
}

src_test() {
	# Tests need X
	# FIXME: Tests fail!
	Xemake check || die
}
