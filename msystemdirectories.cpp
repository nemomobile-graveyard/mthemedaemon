/***************************************************************************
**
** Copyright (C) 2010, 2011 Nokia Corporation and/or its subsidiary(-ies).
**
** This library is free software; you can redistribute it and/or
** modify it under the terms of the GNU Lesser General Public
** License version 2.1 as published by the Free Software Foundation
** and appearing in the file LICENSE.LGPL included in the packaging
** of this file.
**
****************************************************************************/

#include "msystemdirectories.h"
#include "qdebug.h"

#include <QString>
#include <QDesktopServices>
#include <QDir>
#include <QFileInfo>

#include <cstdlib>


namespace {
    QString cacheDirPrefix = QString();
    bool prefixChanged = false;
}


QString MSystemDirectories::cacheDirectory()
{
    static QString cacheDir;
    if (cacheDir.isEmpty() || prefixChanged) {
        cacheDir = cacheDirPrefix;

        // first check if we can write to the cache dir
        cacheDir += "/var/cache/meegotouch/";
        QDir().mkpath(cacheDir);
        QFileInfo cacheDirInfo(cacheDir);
        if (!(cacheDirInfo.isWritable() && cacheDirInfo.isDir()))
        {
            // now we try a standard cache location
            cacheDir = cacheDirPrefix + QDesktopServices::storageLocation(QDesktopServices::CacheLocation) + QDir::separator() + QLatin1String("meegotouch") + QDir::separator();
            QDir().mkpath(cacheDir);
            cacheDirInfo.setFile(cacheDir);
            if (!cacheDirInfo.isWritable() && cacheDirInfo.isDir()) {
                qCritical() << "No writable cache directory found. Make sure that " << cacheDir << " is writable.";
                _exit(EXIT_FAILURE);
            }
        }

        prefixChanged = false;
    }

    return cacheDir;
}


void MSystemDirectories::setPrefix(const QString &prefix)
{
    cacheDirPrefix = prefix;
    prefixChanged = true;
}

