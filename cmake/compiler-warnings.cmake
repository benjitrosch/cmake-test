# Add warnings based on compiler
# Set some helper variables for readability
set(compiler_is_clang "$<OR:$<CXX_COMPILER_ID:AppleClang>,$<CXX_COMPILER_ID:Clang>>")
set(compiler_is_gnu "$<CXX_COMPILER_ID:GNU>")
set(compiler_is_msvc "$<CXX_COMPILER_ID:MSVC>")

target_compile_options(${PROJECT_NAME}
    PRIVATE
        # MSVC only
        $<${compiler_is_msvc}:
            # Enable strict warnings
            /W4

            # Treat all warning as errors
            /WX

            /wd4018
            /wd4024
            /wd4047
            /wd4057
            /wd4099
            /wd4100
            /wd4101
            /wd4127
            /wd4152
            /wd4232
            /wd4244
            /wd4245
            /wd4267
            /wd4305
            /wd4459
            /wd4701
            /wd4706
            /wd4996
            /wd5072
		>

        # Clang and GNU
        $<$<OR:${compiler_is_clang},${compiler_is_gnu}>:
            -Wall
            -Wcast-align
            -Wpedantic

            # Disable warnings you don't want here
            -Wno-unused-parameter
            -Wno-c++98-compat
            -Wno-c++98-compat-pedantic

            # prints extra hardening suggestions for unsafe buffer access
            # -fsafe-buffer-usage-suggestions
        >

        # Clang only
        $<${compiler_is_clang}:
            -Wimplicit-fallthrough

        >

        # GNU only
        $<${compiler_is_gnu}:
            -Walloc-zero
            -Wduplicated-branches
            -Wduplicated-cond
            -Wlogical-op
        >
)
