function setBxCompat()
	filter "action:vs*"
		includedirs { "../bx/include/compat/msvc" }
	filter { "system:windows", "action:gmake" }
		includedirs { "../bx/include/compat/mingw" }
	filter { "system:macosx" }
		includedirs { "../bx/include/compat/osx" }
		buildoptions { "-x objective-c++" }
end

project "bimg"
	kind "StaticLib"
	language "C++"
	cppdialect "C++14"
	exceptionhandling "Off"
	rtti "Off"
	files
	{
		"include/bimg/*.h",
		"src/image.cpp",
		"src/image_gnf.cpp",
		"src/*.h",
		"3rdparty/astc-codec/src/decoder/*.cc"
	}
	includedirs
	{
		"../bx/include",
		"include",
		"3rdparty/astc-codec",
		"3rdparty/astc-codec/include"
	}
	filter "configurations:Release"
		defines "BX_CONFIG_DEBUG=0"
	filter "configurations:Debug"
		defines "BX_CONFIG_DEBUG=1"
	filter "action:vs*"
		defines "_CRT_SECURE_NO_WARNINGS"
	setBxCompat()