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
	cppdialect "C++17"
	staticruntime "on"
	exceptionhandling "Off"
	rtti "Off"
	_3rd_party_location_dir()
	
	set_output_dir()

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

	filter "configurations:Debug"
		defines "BX_CONFIG_DEBUG=1"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "BX_CONFIG_DEBUG=0"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "BX_CONFIG_DEBUG=0"
		runtime "Release"
		optimize "on"

	filter "action:vs*"
		defines "_CRT_SECURE_NO_WARNINGS"
	setBxCompat()