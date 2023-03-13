vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO projectchrono/chrono
  REF 30cd3f2702cb58182e46d5b2724d2d2850a50e21
  SHA512 f5e66c2171e62dd63bd1822f2ca17feaa18b3f2140a720ba7c2d1a730f0e7321fe5cbc0d2345903060ec0e9d1cc238e632550c57d565d9c28040812801b24a12
  HEAD_REF release/8.0
  PATCHES 
    "fix-cmake-errors.patch"
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" USE_SHARED_LIBS)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
  FEATURES
    hdf             ENABLE_HDF5
    postprocess     ENABLE_MODULE_POSTPROCESS
    irrlicht        ENABLE_MODULE_IRRLICHT
    vehicle         ENABLE_MODULE_VEHICLE
    multicore       ENABLE_MODULE_MULTICORE
    opengl          ENABLE_MODULE_OPENGL
    synchrono       ENABLE_MODULE_SYNCHRONO
    cosimulation    ENABLE_MODULE_COSIMULATION
)

vcpkg_cmake_configure(
  SOURCE_PATH "${SOURCE_PATH}"
  OPTIONS
    -DBUILD_SHARED_LIBS=${USE_SHARED_LIBS}
    ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()

file(
  INSTALL "${SOURCE_PATH}/LICENSE"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright
)

file(
  INSTALL "${CURRENT_PACKAGES_DIR}/cmake/ChronoConfig.cmake"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/cmake")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/cmake")
