if (WIN32)
    target_link_libraries(${PROJECT_NAME} PRIVATE
        $<$<CONFIG:Debug>:
            ${BULLET_DIR}/bin/Bullet3Common_Debug.lib;
            ${BULLET_DIR}/bin/BulletCollision_Debug.lib;
            ${BULLET_DIR}/bin/BulletDynamics_Debug.lib;
            ${BULLET_DIR}/bin/BulletInverseDynamics_Debug.lib;
            ${BULLET_DIR}/bin/BulletSoftBody_Debug.lib;
            ${BULLET_DIR}/bin/LinearMath_Debug.lib;
        >
        $<$<CONFIG:Release>:
            ${BULLET_DIR}/bin/Bullet3Common.lib;
            ${BULLET_DIR}/bin/BulletCollision.lib;
            ${BULLET_DIR}/bin/BulletDynamics.lib;
            ${BULLET_DIR}/bin/BulletInverseDynamics.lib;
            ${BULLET_DIR}/bin/BulletSoftBody.lib;
            ${BULLET_DIR}/bin/LinearMath.lib;
        >
    )
elseif(APPLE)
    target_link_libraries(${PROJECT_NAME} PRIVATE
        ${BULLET_DIR}/bin/libBullet3Common.a
        ${BULLET_DIR}/bin/libBulletCollision.a
        ${BULLET_DIR}/bin/libBulletDynamics.a
        ${BULLET_DIR}/bin/libBulletInverseDynamics.a
        ${BULLET_DIR}/bin/libBulletSoftBody.a
        ${BULLET_DIR}/bin/libLinearMath.a
    )
endif()
