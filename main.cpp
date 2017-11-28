#include <QApplication>
#include <QQuickView>
#include <QtQml>
#include <QUrl>
#include <QDir>
#include <QDebug>

#ifndef MOBILE
#include <KStatusNotifierItem>
#include <AtCore/AtCore>
#endif
#include "gridmesh.h"
#include "linemesh.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    Q_INIT_RESOURCE(viewer3d);

    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);


    // Enable high dpi support
    app.setAttribute(Qt::AA_UseHighDpiPixmaps, true);

#ifndef MOBILE
    qmlRegisterType<AtCore>("org.kde.atcore", 1, 0, "AtCore");
#endif
    qmlRegisterType<GridMesh>("GridMesh", 1, 0, "GridMesh");
    qmlRegisterType<LineMesh>("LineMesh", 1, 0, "LineMesh");
#ifndef MOBILE
    app.setQuitOnLastWindowClosed(false);

    auto *engine = new QQmlApplicationEngine("qrc:/main.qml");
    KStatusNotifierItem *statusNotifier = nullptr;
    for(auto obj : engine->rootObjects()) {
            if (auto window = qobject_cast<QWindow*>(obj)) {
            statusNotifier = new KStatusNotifierItem();
            statusNotifier->setIconByName(QStringLiteral("atcore-app"));
            statusNotifier->setCategory(KStatusNotifierItem::ApplicationStatus);
            statusNotifier->setStatus(KStatusNotifierItem::Active);
            QObject::connect(statusNotifier, &KStatusNotifierItem::activateRequested, [window]{
                window->show();
            });
            break;
        }
    }
#else
    QQuickView view;
    view.setSource(QUrl(QStringLiteral("qrc:/main_mobile.qml")));
    view.show();
#endif

    return app.exec();
}
