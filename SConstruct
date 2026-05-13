import os

# 1. Setup Build Options
opts = Variables([], ARGUMENTS)
opts.Add(EnumVariable("platform", "Target platform", "windows", ["windows", "linux", "macos", "android", "ios"]))
opts.Add(EnumVariable("target", "Compilation target", "template_debug", ["template_debug", "template_release", "editor"]))
opts.Add(EnumVariable("arch", "Architecture", "x86_64", ["x86_32", "x86_64", "arm32", "arm64", "rv64", "ppc32", "ppc64", "wasm32"]))

# Ensure MSVC 2026 is picked up if multiple versions exist
env = Environment(variables=opts)

# 2. Paths
godot_cpp_path = "thirdparty/godot-cpp"
bin_dir = "bin"

# 3. Import godot-cpp environment
env = SConscript(os.path.join(godot_cpp_path, "SConstruct"), exports="env")

# --- C++26 OVERRIDE ---
# We use Replace to clear out the default /std:c++17 set by godot-cpp
if env.get("is_msvc", False):
    # For MSVC 18.4.1 (VS 2026), /std:c++latest enables C++26 features
    env.Replace(CXXFLAGS=["/std:c++latest", "/Zc:__cplusplus"])
else:
    # For GCC/Clang counterparts
    env.Replace(CXXFLAGS=["-std=c++2c"])
# ----------------------

# 4. Add includes
env.Append(CPPPATH=["src/", os.path.join(godot_cpp_path, "include"), os.path.join(godot_cpp_path, "gen/include")])

# 5. Build Configuration
sources = Glob("src/*.cpp")
sources += Glob("src/grid/*.cpp")

clean_build_name = "myextension_temp"
godot_style_name = "libmyextension.{}.{}.{}".format(env["platform"], env["target"], env["arch"])

# Build the shared library
library = env.SharedLibrary(
    target=os.path.join(bin_dir, clean_build_name),
    source=sources
)

# Rename function with improved path handling
def rename_lib(target, source, env):
    import os
    # target[0] is the .dll, target[1] is often the .lib or .pdb
    old_file = os.path.abspath(str(target[0]))
    new_file = os.path.abspath(os.path.join(bin_dir, godot_style_name + env['SHLIBSUFFIX']))
    
    if os.path.exists(new_file):
        os.remove(new_file)
    os.rename(old_file, new_file)
    print(f"--- Moved {os.path.basename(old_file)} to {os.path.basename(new_file)} ---")

env.AddPostAction(library, rename_lib)

Default(library)