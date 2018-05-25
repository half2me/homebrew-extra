class Openalpr < Formula
  desc "Automatic License Plate Recognition library"
  homepage "https://github.com/openalpr/openalpr"
  url "https://github.com/openalpr/openalpr/archive/v2.3.0.tar.gz"
  sha256 "1cfcaab6f06e9984186ee19633a949158c0e2aacf9264127e2f86bd97641d6b9"
  head "https://github.com/openalpr/openalpr.git", :branch => "master"

  depends_on "cmake" => :build
  depends_on "leptonica"
  depends_on "libtiff"
  depends_on "tesseract"
  depends_on "opencv"

  def install
    mkdir "src/build" do
      args = std_cmake_args
      args << "-DCMAKE_INSTALL_SYSCONFDIR=#{etc}"
      args << "-DCMAKE_MACOSX_RPATH=true"
      args << "-DWITH_DAEMON=NO"
      args << "-DCMAKE_INSTALL_SYSCONFDIR:PATH=#{etc}"
      system "cmake", "..", *args
      system "make", "install"
    end
  end

  test do
    output = shell_output("#{bin}/alpr #{test_fixtures("test.jpg")}")
    assert_equal "No license plates found.", output.chomp
  end
end
