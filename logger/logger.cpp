/* Atelier KDE Printer Host for 3D Printing
    Copyright (C) <2017>
    Author: Patrick José Pereira - patrickelectric@gmail.com

    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License as
    published by the Free Software Foundation; either version 3 of
    the License or any later version accepted by the membership of
    KDE e.V. (or its successor approved by the membership of KDE
    e.V.), which shall act as a proxy defined in Section 14 of
    version 3 of the license.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "logger.h"

#include <QDebug>
#include <QString>
#include <QTime>

Logger::Logger()
{
}

void Logger::writeMessage(const QString& msg)
{
    QString debugMsg = msg;
    qDebug().noquote() << debugMsg.remove(QRegExp("<[^>]*>"));
    QString text = msg;
    _logText = _logText + msg + "<br/>";

    emit(Logger::self()->logTextChanged());
}

void Logger::messageHandle(QtMsgType type, const QMessageLogContext& context, const QString &msg)
{
    Q_UNUSED(context)

    QString msgCopy = QString(context.category) + QStringLiteral(": ") + msg;
    QString txt = QTime::currentTime().toString(QStringLiteral("[hh:mm:ss:zzz] "));
    switch (type) {
        case QtDebugMsg:
            txt.append(QStringLiteral("<font color=\"%1\">Debug: %2</font>").arg("gray", msgCopy));
            break;

        case QtWarningMsg:
            txt.append(QStringLiteral("<font color=\"%1\">Warning: %2</font>").arg("yellow", msgCopy));
            break;

        case QtCriticalMsg:
            txt.append(QStringLiteral("<font color=\"%1\">Critical: %2</font>").arg("red", msgCopy));
            break;

        case QtFatalMsg:
            txt.append(QStringLiteral("<font color=\"%1\">Fatal: %2</font>").arg("red", msgCopy));
            abort();
            break;

        default:
            return;
    }

    Logger::self()->writeMessage(txt);
}

Logger* Logger::self()
{
    static Logger* self = new Logger();
    return self;
}

Logger::~Logger()
{
}
