if is_plat("macosx") then
    -- compile error on macosx when set c++11
    -- bit_vector.cpp:181:23: error: use of undeclared identifier 'aligned_alloc'
    -- see@https://stackoverflow.com/questions/29247065/compiler-cant-find-aligned-alloc-function
    set_languages("c++17")
else
    set_languages("c++11")
end
add_rules("mode.debug", "mode.release") 
add_requires("zlib")
add_packages("zlib")
add_ldflags("-pthread")
if is_plat("linux") then
    add_requires("openmp")
    add_packages("openmp")
end

add_includedirs("src")

target("routingkit")
    set_kind("static")
    add_files("src/routingkit/**.cpp")
    set_targetdir("lib")
    add_installfiles("src/(routingkit/**.h)", {prefixdir = "include"})

-- 非递归遍历获取所有子文件
for _, filepath in ipairs(os.files("test/**.cpp")) do
    -- print(filepath)
    target(path.basename(filepath))
        set_kind("binary")
        add_files(filepath)
        add_deps("routingkit")
        set_targetdir("bin/test")
end

for _, filepath in ipairs(os.files("examples/**.cpp")) do
    -- print(filepath)
    target(path.basename(filepath))
        set_kind("binary")
        add_files(filepath)
        add_deps("routingkit")
        set_targetdir("bin/examples")
end