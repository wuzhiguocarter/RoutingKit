add_rules("mode.debug", "mode.release") 
-- -- project deps
-- add_requires("jsoncpp", {alias = "jsoncpp"})
-- add_requires("log4cplus", {alias = "log4cplus"})
-- -- brpc deps
-- add_requires("boost", {alias = "boost"})
-- add_requires("gflags", {alias = "gflags"})
-- add_requires("protobuf", {alias = "protobuf"})
-- add_requires("brew::thrift", {alias = "thrift"})
-- add_requires("openssl", {alias = "openssl"})
-- add_requires("lua", {alias = "lua"})
-- add_requires("brew::brpc", {alias = "brpc"})
-- -- simple_rpc deps
-- add_requires("libconfig", {alias = "libconfig"})
-- add_requires("rapidjson", {alias = "rapidjson"})

set_languages("c++11")


add_includedirs("src")

target("routingkit_base")
    set_kind("static")
    add_files("src/routingkit/base/**.cpp")

target("routingkit_utils")
    set_kind("static")
    add_files("src/routingkit/utils/**.cpp")

target("routingkit_core")
    set_kind("static")
    add_files("src/routingkit/core/**.cpp")

-- target("simple_rpc")
--     set_kind("static")
--     add_files("src/simple_rpc/**.cpp")
--     add_packages("brpc", "boost", "protobuf", "libconfig", "gflags", "openssl", "log4cplus", "rapidjson")

-- target("service")
--     set_kind("static")
--     add_files("src/service/**.cpp")

-- target("rule_engine")
--     set_kind("static")
--     add_files("src/common/**.cpp", "src/rule_engine/**.cpp")
--     add_packages("boost", "log4cplus", "lua")

-- target("workflow")
--     set_kind("static")
--     add_files("src/common/**.cpp", "src/workflow/**.cpp")
--     add_packages("brpc", "boost", "jsoncpp", "log4cplus", "gflags", "protobuf", "openssl", "thrift", "lua")

-- target("test_workflow")
--     set_kind("binary")
--     add_files("test/test_workflow.cpp")
--     add_deps("workflow")
--     add_packages("brpc", "boost", "jsoncpp", "log4cplus", "gflags", "protobuf", "openssl", "thrift", "lua")