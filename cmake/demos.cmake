add_executable(demo_simple1
"${tensorflow_source_dir}/demo/simple1/main.cc"
${tf_cc_obj}
)

target_link_libraries(demo_simple1 ${test_framework_link} ${tf_cc_link})

add_executable(demo_loader
"${tensorflow_source_dir}/demo/loader/main.cc"
${tf_cc_obj}
)

target_link_libraries(demo_loader ${test_framework_link} ${tf_cc_link})
