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

#pragma once

#include <QObject>
#include <QTextEdit>

enum QtMsgType;
class QMessageLogContext;
class QString;
/**
 * @brief Singleton Class to manage log messages
 *
 */
class Logger : public QObject
{
    Q_OBJECT
public:
    /**
     * @brief Write message in QTextEdit
     *
     * @param msg p_msg: message
     */
    void writeMessage(const QString& msg);

    static void messageHandle(QtMsgType type, const QMessageLogContext& context, const QString &msg);
    Q_PROPERTY(QString logText READ logText WRITE setLogText NOTIFY logTextChanged)
    QString logText() { return _logText; };
    void setLogText(QString text) { _logText = text;};

    ~Logger();
    static Logger* self();

    signals:
        void logTextChanged();

private:
    Logger* operator = (Logger& other) = delete;
    Logger(const Logger& other) = delete;
    Logger();

    QString _logText;
};
