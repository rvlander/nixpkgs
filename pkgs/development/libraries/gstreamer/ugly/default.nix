{ stdenv, fetchurl, pkgconfig, python
, gst-plugins-base, orc
, a52dec, libcdio, libdvdread
, lame, libmad, libmpeg2, x264, libintlOrEmpty
}:

stdenv.mkDerivation rec {
  name = "gst-plugins-ugly-1.6.1";

  meta = with stdenv.lib; {
    description = "Gstreamer Ugly Plugins";
    homepage    = "http://gstreamer.freedesktop.org";
    longDescription = ''
      a set of plug-ins that have good quality and correct functionality,
      but distributing them might pose problems.  The license on either
      the plug-ins or the supporting libraries might not be how we'd
      like. The code might be widely known to present patent problems.
    '';
    license     = licenses.lgpl2Plus;
    platforms   = platforms.unix;
    maintainers = with maintainers; [ iyzsong ];
  };

  src = fetchurl {
    url = "${meta.homepage}/src/gst-plugins-ugly/${name}.tar.xz";
    sha256 = "0mvasl1pwq70w2kmrkcrg77kggl5q7jqybi7fkvy3vr28c7gkhqc";
  };

  nativeBuildInputs = [ pkgconfig python ];

  buildInputs = [
    gst-plugins-base orc
    a52dec libcdio libdvdread
    lame libmad libmpeg2 x264
  ] ++ libintlOrEmpty;

  NIX_LDFLAGS = if stdenv.isDarwin then "-lintl" else null;
}
