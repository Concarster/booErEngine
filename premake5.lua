workspace "BooEr"

     architecture "x86"
     architecture "x64"

     startproject "BooErGame"

     filter "system:windows"
		disablewarnings { "4996", "4251" }
                  
platforms {       -- Dropdown Solution Confg Platforms section in VS
    
     "Win32",
     "x64"
} 
    
configurations {   -- Dropdown Solution Configurations
     "Debug",
     "Release"  
}

outputdir = "%{cfg.buildcfg}_%{cfg.system}_%{cfg.architecture}"

-- Include directories relative to root folder (solution directory)
IncludeDir = {}
IncludeDir["GLFW"]     = "BooErEngine/Mods/GLFW/include"
IncludeDir["Glad"]     = "BooErEngine/Mods/Glad/include"
IncludeDir["ImGui"]    = "BooErEngine/Mods/imgui"
IncludeDir["glm"]      = "BooErEngine/Mods/glm"
IncludeDir["SOIL2"]    = "BooErEngine/Mods/SOIL2/incs"
IncludeDir["GSL"]      = "BooErEngine/Mods/GSL/include"
IncludeDir["spdlog"]   = "BooErEngine/Mods/spdlog/include"

group "Dependencies"

include "BooErEngine/Mods/GLFW"
include "BooErEngine/Mods/Glad"
include "BooErEngine/Mods/imgui"
include "BooErEngine/Mods/SOIL2"

 group ""

--[[ GLOBAL Precompiled Header   
pchheader "booPCH.h"
pchsource "BooErEngine/src/booPCH.cpp"
]]


project "BooErEngine" 
    location "BooErEngine"
    kind "SharedLib"
    language "C++"

    pchheader "booPCH.h"
    pchsource "BooErEngine/src/booPCH.cpp"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir    ("bint/" .. outputdir .. "/%{prj.name}")


    files {

        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp",

    }

    includedirs {
        "%{prj.name}/src",
        "%{IncludeDir.spdlog}",
        "%{IncludeDir.GLFW}",
        "%{IncludeDir.Glad}",
        "%{IncludeDir.ImGui}",
        "%{IncludeDir.glm}",
        "%{IncludeDir.SOIL2}",
        "%{IncludeDir.GSL}",
        "%{IncludeDir.boost}",
        "$(BOOST)",
    }

    libdirs { 
        "$(BOOST)/stage/lib" 
    }

    links { 
        "GLFW",
		"Glad",
		"ImGui",
        "SOIL2";
		"opengl32.lib"
	}

    filter"system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"

        defines {
             "BOO_ENGINE",
             "BOO_WINDOW",
             "BOO_BUILD_DLL",
             "GLFW_INCLUDE_NONE"
        }

        postbuildcommands {
            ("{COPY} %{cfg.buildtarget.relpath} \"../bin/" .. outputdir .. "/BooErGame/\"")
        }

        filter "configurations:Debug"
        buildoptions "/MDd"
        defines "BOO_DEBUG"
        symbols "On"

        filter "configurations:Release"
        buildoptions "/MD"
        defines "BOO_RELEASE"
        optimize "On"


-----------------------------------
-----     PROJECT # 1 BooErGame     -----
-----------------------------------

project "BooErGame" 
    location "BooErGame"
    kind "ConsoleApp"
    language "C++"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bint/" .. outputdir .. "/%{prj.name}")

    files {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp",
    }

    includedirs {

        "BooErEngine/src",
        "%{prj.name}/src",
        "%{IncludeDir.spdlog}",
        "%{IncludeDir.GLFW}",
        "%{IncludeDir.Glad}",
        "%{IncludeDir.ImGui}",
        "%{IncludeDir.glm}",
        "%{IncludeDir.SOIL2}",
        "%{IncludeDir.GSL}",
        "$(BOOST)",
    }

    libdirs { 
        "$(BOOST)/stage/lib" 
    }
  
    links {
        "BooErEngine",
		"opengl32.lib"
    }

    filter"system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"

        defines {
             "BOO_ENGINE",
             "BOO_WINDOW"
        }


        filter "configurations:Debug"
        buildoptions "/MDd"
        defines "BOO_DEBUG"
        symbols "On"

        filter "configurations:Release"
        buildoptions "/MD"
        defines "BOO_RELEASE"
        optimize "On"
