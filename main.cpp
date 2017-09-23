#include <QApplication>
#include <QQuickView>
#include <QtQml>
#include <QUrl>
#include <QDir>
#include <QDebug>

#include "gridmesh.h"
#include "linemesh.h"


Q_DECL_EXPORT int main(int argc, char *argv[])
{
    Q_INIT_RESOURCE(viewer3d);

    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);

    qmlRegisterType<GridMesh>("GridMesh", 1, 0, "GridMesh");
    qmlRegisterType<LineMesh>("LineMesh", 1, 0, "LineMesh");

    QQuickView view;
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.setSource(QUrl(QStringLiteral("qrc:///main.qml")));
    view.show();

    return app.exec();
}
