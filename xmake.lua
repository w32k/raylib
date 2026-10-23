option("rlplatform")
    set_default("PLATFORM_DESKTOP_GLFW")
    set_values("PLATFORM_DESKTOP_GLFW", "PLATFORM_DESKTOP_SDL",
        "PLATFORM_DESKTOP_RGFW", "PLATFORM_DESKTOP_WIN32",
        "PLATFORM_WEB", "PLATFORM_WEB_EMSCRIPTEN",
        "PLATFORM_WEB_RGFW", "PLATFORM_DRM", "PLATFORM_ANDROID",
        "PLATFORM_MEMORY")

option("rlgraphicsapi")
    set_default("GRAPHICS_API_OPENGL_43")
    set_values("GRAPHICS_API_OPENGL_33", "GRAPHICS_API_OPENGL_SOFTWARE",
        "GRAPHICS_API_OPENGL_11", "GRAPHICS_API_OPENGL_21", "GRAPHICS_API_OPENGL_43",
        "GRAPHICS_API_OPENGL_ES2")

target("raylib")
    if is_config("os", "windows") then
        set_toolchains("w64devkit")
    end
    if is_config("os", "linux") then
        add_cflags("-D_GLFW_X11")
    end
    set_kind("static")
    add_includedirs("src")
    if is_config("rlplatform", "PLATFORM_DESKTOP_GLFW") then
        add_includedirs("src/external/glfw/include")
    end
    -- TODO: implement the rest
    add_files("src/*.c")
    add_cflags("-D$(rlgraphicsapi) -D$(rlplatform)", {force = true})

target("clean")
    set_kind("phony")
    on_run(function()
        os.rm(".xmake", {async = true, detach = true})
        os.rm("build", {async = true, detach = true})
    end)



toolchain("w64devkit")
    set_kind("standalone")
    set_toolset("cc", "gcc")
    set_toolset("ld", "gcc")
    set_toolset("ar", "ar")
toolchain_end()
