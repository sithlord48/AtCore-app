#include <QApplication>
#include <QQuickView>
#include <QtQml>
#include <QUrl>
#include <QDir>
#include <QDebug>

#ifndef MOBILE
#include <AtCore/AtCore>
#endif
#include "gridmesh.h"
#include "linemesh.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    Q_INIT_RESOURCE(viewer3d);

    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);

    QQuickView view;

#ifndef MOBILE
    qmlRegisterType<AtCore>("org.kde.atcore", 1, 0, "AtCore");
    view.rootContext()->setContextProperty("mobile", false);
#else
    view.rootContext()->setContextProperty("mobile", true);
#endif
    qmlRegisterType<GridMesh>("GridMesh", 1, 0, "GridMesh");
    qmlRegisterType<LineMesh>("LineMesh", 1, 0, "LineMesh");

    view.setResizeMode(QQuickView::SizeRootObjectToView);
#ifndef MOBILE
    view.setSource(QUrl(QStringLiteral("qrc:///main.qml")));
#else
    view.setSource(QUrl(QStringLiteral("qrc:///main_mobile.qml")));
#endif
    view.show();

    return app.exec();
}
