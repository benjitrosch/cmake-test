add_library(RmlBackend STATIC
    RmlUi_Platform_SDL.cpp
    RmlUi_Renderer_GL3.cpp
)

target_link_libraries(RmlBackend PRIVATE ${SDL_LIBRARIES})
target_include_directories(RmlBackend PUBLIC
    ${SDL_DIR}/include
    ${RML_DIR}/include
    ${CMAKE_CURRENT_SOURCE_DIR}
)
