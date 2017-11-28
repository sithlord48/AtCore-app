set(ICONS_SRCS
    16-apps-atcore.png
    32-apps-atcore.png
    48-apps-atcore.png
    128-apps-atcore.png
)

ecm_add_app_icon(ATCORE_APP_ECM_ICONS ICONS ${ICONS_SRCS})

ecm_install_icons(ICONS
    ${ICONS_SRCS}
    DESTINATION
    ${KDE_INSTALL_ICONDIR}
    THEME hicolor
)

add_library(atcore_app_icons ${ATCORE_APP_ECM_ICONS} STATIC)
